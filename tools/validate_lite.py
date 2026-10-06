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

def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--weidu", type=Path, help="Optional WeiDU executable")
    ap.add_argument("--ids-dir", type=Path, help="BG2EE IDS tables for BAF parsing")
    ap.add_argument("--game", type=Path, help="Optional game directory instead of --ids-dir")
    args = ap.parse_args()
    errors = []
    code = sorted(p for p in MOD.rglob("*") if p.suffix.lower() in (".tp2", ".tpa", ".d", ".baf"))
    texts = {p: clean(read(p)) for p in code}
    excluded = re.compile(r"\bB?X3(?:Hel|Kal|Isa)\w*\b", re.I)
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
    nodes, refs = [], []
    for p in MOD.rglob("*.d"):
        ns, rs = parse(p, read(p))
        nodes.extend(ns)
        refs.extend(rs)
    defined = {n["key"] for n in nodes}
    for ref in sorted(set(refs)):
        if ref[0] and ref[0].startswith(("x3", "bx3")) and ref not in defined:
            errors.append(f"Unresolved custom dialogue state: {ref}")
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
    if args.weidu:
        print("PASS: WeiDU syntax checks. This is not a full installation or in-game test.")

if __name__ == "__main__":
    main()
