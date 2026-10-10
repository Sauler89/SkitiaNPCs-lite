#!/usr/bin/env python3
"""Shared lexical, dialogue-state and resource-link helpers for WeiDU source audits."""
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

def resource_links(texts, nodes, errors):
    """Check explicit custom resource calls against COPY and COMPILE outputs."""
    installed = {n["key"][0] + ".dlg" for n in nodes}
    for path, text in texts.items():
        if path.suffix.lower() not in (".tp2", ".tpa"):
            continue
        for source, dest in re.findall(r'\bCOPY(?:_EXISTING)?\s+[~"]([^~"]+)[~"]\s+(?:[~"]([^~"]+)[~"]|(?=override\b))', text, re.I):
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

