#!/usr/bin/env python3
"""Static validation for the three-NPC edition; no game files are modified."""
from pathlib import Path
import argparse
import re
import subprocess

ROOT = Path(__file__).resolve().parents[1]
MOD = ROOT / "SkitiaNPCs"

def read(path):
    return path.read_text(encoding="utf-8-sig")

def clean(s):
 # Comments outside WeiDU strings. Preserve positions for slicing the original.
 pat=r'~~~~~[\s\S]*?~~~~~|~[^~]*~|"[^"\n]*"|/\*[\s\S]*?\*/|//[^\n]*'
 return re.sub(pat,lambda m: re.sub(r'[^\n]',' ',m[0]) if m[0].startswith(('//','/*')) else m[0],s)
def ranges(s,rs):
 for a,b,v in sorted(rs,reverse=True): s=s[:a]+v+s[b:]
 return s
header=re.compile(r'^[ \t]*(?:(CHAIN)\s+(?:IF\s+(?:WEIGHT\s+#?-?\d+\s*)?~([^~]*)~\s*THEN\s+)?(\w+)\s+([^\s]+)|(APPEND|BEGIN)\s+(\w+)|(IF)\s*(?:WEIGHT\s+#?-?\d+\s*)?~([^~]*)~\s*(?:THEN\s+)?(?:BEGIN\s+)?([\w.-]+)[ \t]*\n[ \t]*SAY\b|(EXTEND_(?:TOP|BOTTOM)(?:_REGEXP)?|I_C_T\w*|INTERJECT\w*|A_T_T|ADD_\w*|ALTER_TRANS|REPLACE)\b)',re.M)
def parse(p,s):
 cs=clean(s.replace('\r\n','\n'));hs=list(header.finditer(cs));owner=None;nodes=[];refs=[]
 for i,h in enumerate(hs):
  end=hs[i+1].start() if i+1<len(hs) else len(cs);b=cs[h.start():end];key=None;trigger=None
  if h[1]:owner=h[3].lower();key=(owner,h[4].lower());trigger=h[2]
  elif h[5]:owner=h[6].lower()
  elif h[7]:key=(owner,h[9].lower());trigger=h[8]
  else:owner=None
  if key:nodes.append({'key':key,'trigger':trigger,'file':str(p),'start':h.start(),'end':end,'body':b})
  # Ignore strings: conditions/actions/text are not D transitions.
  bare=re.sub(r'~[^~]*~|"[^"\n]*"',lambda m:' '*len(m[0]),b)
  for m in re.finditer(r'\bEXTERN\s+(\w+)\s+([\w.-]+)',bare):refs.append((m[1].lower(),m[2].lower()))
  if owner:
   for m in re.finditer(r'\bGOTO\s+([\w.-]+)|\+\s*([\w.-]+)\s*(?=\n|$)',bare):refs.append((owner,(m[1] or m[2]).lower()))
 return nodes,refs

def translation_contexts(texts, errors):
    """Check IDs against each source's LOAD_TRA/USING context, not all TRA files."""
    lookup = {p.relative_to(MOD).as_posix().lower(): p for p in MOD.rglob("*") if p.is_file()}
    def resolve(name):
        name = re.sub(r"^(?:%MOD_FOLDER%|SkitiaNPCs)/", "", name, flags=re.I)
        return lookup[name.replace("%LANGUAGE%", "English").lower()]
    def ids(path):
        return set(re.findall(r"@(\d+)\s*=", read(path)))
    setup = ids(resolve("Tra/English/Setup.tra"))
    contexts = []
    installers = [MOD / "Setup-SkitiaNPCs.tp2", *sorted((MOD / "Lib").glob("*_BG2.tpa"))]
    for installer in installers:
        text = texts[installer]
        base = set(setup)
        # COMPILE's USING translations are local; LOAD_TRA persists in this installer.
        directive = r"\b(?:LOAD_TRA\s+~[^~]+~|COMPILE\b[\s\S]*?(?=\b(?:COMPILE|LOAD_TRA|EXTEND_TOP|EXTEND_BOTTOM|COPY|COPY_EXISTING|ACTION_IF|END|INCLUDE|LAF|PRINT|APPEND)\b|\Z)|EXTEND_(?:TOP|BOTTOM)\s+~[^~]+~\s+~[^~]+~)"
        for m in re.finditer(directive, text):
            block = m[0]
            if block.startswith("LOAD_TRA"):
                base.update(ids(resolve(re.search(r"~([^~]+)~", block)[1])))
                continue
            local = set(base)
            for name in re.findall(r"USING\s+~([^~]+)~", block):
                local.update(ids(resolve(name)))
            for name in re.findall(r"~([^~]+\.(?:d|baf))~", block, re.I):
                path = resolve(name)
                contexts.append((path, local))
    for path, available in contexts:
        missing = set(re.findall(r"@(\d+)", texts[path])) - available
        if missing:
            errors.append(f"Translation IDs unavailable to {path.name}: {sorted(missing, key=int)}")
    mapped = {path for path, _ in contexts}
    for path in texts:
        if path.suffix.lower() in (".d", ".baf") and path not in mapped:
            errors.append(f"No install/translation context for {path.relative_to(ROOT)}")
    return len(mapped)


def resource_links(texts, nodes, errors):
    """Check explicit custom resource calls against COPY and COMPILE outputs."""
    installed = {n["key"][0] + ".dlg" for n in nodes}
    for path, text in texts.items():
        if path.suffix.lower() not in (".tp2", ".tpa"):
            continue
        for source, dest in re.findall(r'\bCOPY\s+[~"]([^~"]+)[~"]\s+(?:[~"]([^~"]+)[~"]|(?=override\b))', text, re.I):
            if not dest or dest.lower() == "override":
                dest = "override/" + source.rsplit("/", 1)[-1]
            if dest.lower().startswith("override/"):
                installed.add(dest.rsplit("/", 1)[-1].lower())
        for block in re.findall(r'\bCOMPILE\b[\s\S]*?(?=\b(?:COMPILE|LOAD_TRA|EXTEND_TOP|EXTEND_BOTTOM|COPY|COPY_EXISTING|ACTION_IF|END|INCLUDE|LAF|PRINT|APPEND)\b|\Z)', text):
            installed.update(Path(name).stem.lower() + ".bcs" for name in re.findall(r'~([^~]+\.baf)~', block, re.I))
    actions = {
        "itm": r"PartyHasItem|HasItem|HasItemEquiped|GiveItemCreate|GiveItem|TakePartyItem|TakePartyItemNum|DestroyItem|XEquipItem|EquipItem|CreateItem|PickUpItem|TransformItem",
        "cre": r"CreateCreature\w*",
        "bcs": r"StartCutScene|ChangeAIScript",
        "dlg": r"SetDialog|SetDialogue|DialogueSet",
        "sto": r"StartStore",
        "spl": r"(?:ApplySpell|ReallyForceSpell|ForceSpell|Spell|SpellNoDec|ForceSpellPoint|ReallyForceSpellDead)RES",
    }
    checked = 0
    for path, text in texts.items():
        if path.suffix.lower() not in (".d", ".baf"):
            continue
        for ext, names in actions.items():
            pattern = rf'\b(?:{names})\s*\(\s*"(X3[\w#]+)"'
            for name in re.findall(pattern, text, re.I):
                checked += 1
                if name.lower() + "." + ext not in installed:
                    errors.append(f"Uninstalled custom resource: {path.name}: {name}.{ext}")
        for name in re.findall(r'\bTransformItem\("[^"\n]+",\s*"(X3[\w#]+)"', text, re.I):
            checked += 1
            if name.lower() + ".itm" not in installed:
                errors.append(f"Uninstalled transformed item: {path.name}: {name}.itm")
    return checked

def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--weidu", type=Path, help="Optional WeiDU executable")
    ap.add_argument("--ids-dir", type=Path, help="BG2EE IDS tables for BAF parsing")
    ap.add_argument("--game", type=Path, help="Optional game directory instead of --ids-dir")
    args = ap.parse_args()
    errors = []
    code = sorted(p for p in MOD.rglob("*") if p.suffix.lower() in (".tp2", ".tpa", ".d", ".baf"))
    texts = {p: clean(read(p)) for p in code}
    excluded = re.compile(r"\b(?:B?X3(?:Hel|Kal|Isa)\w*|X3HNote[234]?|X3HZavatarQuest|X3KResearch\w*|X3KnowledgeCheese|X3KCHEES|X3[KI]Body|X3KLOVE)\b", re.I)
    for p, text in texts.items():
        if excluded.search(text):
            errors.append(f"Excluded NPC reference: {p.relative_to(ROOT)}")
    installer = texts[MOD / "Setup-SkitiaNPCs.tp2"]
    modules = re.findall(r"INCLUDE ~%MOD_FOLDER%/Lib/(\w+)_BG2.tpa~", installer)
    if modules != ["Emily", "Recorder", "Vienxay"]:
        errors.append(f"Wrong companion modules: {modules}")
    components = [int(x) for x in re.findall(r"DESIGNATED (\d+)", installer)]
    if components != [0, 2, 3, 8, 9, 10, 13, 14, 15]:
        errors.append(f"Unexpected component IDs: {components}")
    paths = {p.relative_to(MOD).as_posix().lower() for p in MOD.rglob("*")}
    for p, text in texts.items():
        if p.suffix.lower() not in (".tp2", ".tpa"):
            continue
        for name in re.findall(r'(?:%MOD_FOLDER%|SkitiaNPCs)/([^~"\s]+)', text, re.I):
            name = name.lower().replace("%language%", "english")
            if "%" not in name and not name.startswith("backup") and name not in paths:
                errors.append(f"Missing source file: {p.name}: {name}")
    strings = set()
    for p in MOD.rglob("*.tra"):
        strings.update(re.findall(r"@(\d+)\s*=", read(p)))
    for p, text in texts.items():
        missing = set(re.findall(r"@(\d+)", text)) - strings
        if missing:
            errors.append(f"Undeclared translation IDs: {p.name}: {sorted(missing)}")
    mapped = translation_contexts(texts, errors)
    nodes, refs = [], []
    for p in MOD.rglob("*.d"):
        ns, rs = parse(p, read(p))
        nodes.extend(ns)
        refs.extend(rs)
    defined = {n["key"] for n in nodes}
    for ref in sorted(set(refs)):
        if ref[0] and ref[0].startswith(("x3", "bx3")) and ref not in defined:
            errors.append(f"Unresolved custom dialogue state: {ref}")
    linked = resource_links(texts, nodes, errors)
    # Regression checks for continuations exposed by removing the original actors.
    rest = texts[MOD / "Dialogue/RestTalk.d"]
    if not re.search(r'Global\("X3VieRomanceActive","GLOBAL",2\).*@1383.*\+ Kids', rest):
        errors.append("Vienxay family conversation has lost its romance entry point")
    emily = texts[MOD / "Dialogue/X3EmiJ.d"]
    if not re.search(r'CHAIN X3EmiJ injured1A\s+@1625\s+EXTERN X3EmiJ injured1A2', emily):
        errors.append("Emily injured-player flirt has lost its continuation")
    recorder = texts[MOD / "Dialogue/X3RebJ.d"]
    if not re.search(r'(?m)^IF ~[^~]*InParty\("HAERDALIS"\)~ EXTERN HAERDAJ body.9', recorder):
        errors.append("Haer'Dalis response has lost its entry point")
    if not re.search(r'DESIGNATED 13\s+REQUIRE_COMPONENT[^\n]+\s+REQUIRE_PREDICATE \(IDS_OF_SYMBOL \(~kit~ ~C0_KAPELLMEISTER~\) >= 0\) @1103', installer):
        errors.append("Kapellmeister option must reject a missing external kit")
    if "@200206" in emily:
        errors.append("Emily's disapproval still uses Helga's message")
    if 'REMOVE_STORE_ITEM ~X3HGEM~' not in installer:
        errors.append("Shared jeweler must not sell Helga's removed scrying crystal")
    for name in ("X3ERING.ITM", "X3HGEM.STO", "X3HGEM.cre"):
        if not re.search(rf'COPY ~%MOD_FOLDER%/[^~]+/{re.escape(name)}~', installer, re.I):
            errors.append(f"Shared romance merchant resource missing: {name}")
    if not re.search(r'CreateCreature\("X3HGEM",', texts[MOD / "Scripts/AR5500.baf"]):
        errors.append("Shared romance jeweler has no spawn point")
    if args.weidu:
        for p in code:
            cmd = [str(args.weidu.resolve())]
            cmd += ["--game", str(args.game.resolve())] if args.game else ["--nogame"]
            if args.ids_dir:
                cmd += ["--search-ids", str(args.ids_dir.resolve())]
            cmd += ["--parse-check", p.suffix[1:].upper(), str(p)]
            result = subprocess.run(cmd, cwd=ROOT, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
            if result.returncode:
                errors.append(result.stdout)
    if errors:
        print("\n".join(errors))
        raise SystemExit(1)
    print(f"PASS: {len(code)} source files, {len(defined)} dialogue states, {len(refs)} transitions checked.")
    print(f"PASS: {mapped} translation contexts and {linked} explicit custom resource references.")
    if args.weidu:
        print("PASS: WeiDU syntax checks. This is not a full installation or in-game test.")

if __name__ == "__main__":
    main()
