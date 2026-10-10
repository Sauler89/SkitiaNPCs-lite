#!/usr/bin/env python3
"""Validate the combined EET sources; optionally parse them with WeiDU."""
from pathlib import Path
import argparse
import re
import subprocess
from weidu_source_tools import clean, parse, resource_links

ROOT = Path(__file__).resolve().parents[1]
MOD = ROOT / 'SkitiaNPCs'
VARS = {'%mod_folder%': 'SkitiaNPCs', '%sn_emily%': 'SkitiaNPCs/BG1/Emily',
        '%sn_recorder%': 'SkitiaNPCs/BG1/Recorder', '%sn_vienxay%': 'SkitiaNPCs/BG1/Vienxay',
        '%language%': 'English'}

def read(p):
    b=p.read_bytes()
    try: return b.decode('utf-8-sig')
    except UnicodeDecodeError: return b.decode('cp1252')

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--weidu', type=Path)
    ap.add_argument('--ids-dir', type=Path)
    ap.add_argument('--game', type=Path)
    args=ap.parse_args()
    errors=[]
    lookup={p.relative_to(ROOT).as_posix().lower():p for p in MOD.rglob('*')}
    def expand(s):
        for k,v in VARS.items(): s=re.sub(re.escape(k),lambda m:v,s,flags=re.I)
        return s.replace('\\','/')
    def resolve(s):
        s=expand(s)
        if not s.lower().startswith('skitianpcs/') or '%' in s: return None
        p=lookup.get(s.lower())
        if p is None: errors.append('Missing source: '+s)
        return p
    def ids(p):
        return set(re.findall(r'@(\d+)\s*=', read(p)))

    installer=MOD/'Setup-SkitiaNPCs.tp2'
    s=clean(read(installer))
    if re.findall(r'(?m)^DESIGNATED\s+(\d+)',s)!=['0','1']:
        errors.append('The installer must expose exactly components 0 and 1.')
    if len(re.findall(r'(?m)^BEGIN\s+~',s))!=2:
        errors.append('Unexpected top-level component count.')
    if re.search(r'\bSUBCOMPONENT\b',s): errors.append('Separate optional components remain.')
    if len(list(MOD.rglob('*.tp2')))!=1: errors.append('An original standalone TP2 is still bundled.')
    if re.search('KAPELLMEISTER|X3RMEM2',s,re.I): errors.append('An excluded option remains active.')

    reached=set(); contexts=[]
    token=r'[~"]([^~"]+)[~"]'
    directive=re.compile(r'\b(LOAD_TRA|INCLUDE|COMPILE|EXTEND_TOP|EXTEND_BOTTOM)\s+(?:EVALUATE_BUFFER\s+)?'+token+r'(?:\s+'+token+r')?(?:\s+USING\s+'+token+r')?',re.I)
    base=ids(MOD/'Tra/English/Setup.tra')
    def walk(p,available,stack=()):
        if p in stack: return available
        reached.add(p); text=clean(read(p)); last=0
        for m in directive.finditer(text):
            # Translation references in patch actions use the current LOAD_TRA stack.
            missing=set(re.findall(r'@(\d+)',text[last:m.start()]))-available
            if missing: errors.append(f'{p.relative_to(ROOT)}: unavailable patch strings {sorted(missing,key=int)}')
            kind=m[1].upper(); name=m[2]
            if kind=='LOAD_TRA':
                q=resolve(name)
                if q: available=available|ids(q)
            elif kind=='INCLUDE':
                q=resolve(name)
                if q: available=walk(q,available,stack+(p,))
            else:
                if kind.startswith('EXTEND_'): name=m[3]
                q=resolve(name) if name else None
                using=m[4] if kind.startswith('EXTEND_') else m[4] or (m[3] if m[3] and m[3].lower().endswith('.tra') else None)
                local=set(available)
                if using:
                    tr=resolve(using)
                    if tr: local|=ids(tr)
                if q:
                    reached.add(q);contexts.append((q,local))
                    missing=set(re.findall(r'@(\d+)',clean(read(q))))-local
                    if missing:errors.append(f'{q.relative_to(ROOT)}: unavailable dialogue/script strings {sorted(missing,key=int)}')
            last=m.end()
        missing=set(re.findall(r'@(\d+)',text[last:]))-available
        if missing: errors.append(f'{p.relative_to(ROOT)}: unavailable patch strings {sorted(missing,key=int)}')
        return available
    walk(installer,base)
    # This helper is also an external entry point for Artisan's component 7005.
    reached.add(MOD/'Lib/Artisan_Isaac.tpa')
    texts={p:clean(read(p)) for p in reached}
    for p,text in texts.items():
        if p.suffix.lower() in ('.tpa','.tph','.tp2'):
            for source in re.findall(r'[~"]((?:%MOD_FOLDER%|%sn_\w+%|SkitiaNPCs)[/\\][^~"\n]+)[~"]',text,re.I):
                if not expand(source).lower().startswith('skitianpcs/backup'):
                    resolve(source)
        if re.search(r'\b(?:B?X3Hel(?:ga|25|B|J|P|D)?|B?X3Kal\w*|X3HFC|X3KFK)\b',text,re.I):
            errors.append('Excluded playable NPC reference: '+str(p.relative_to(ROOT)))
    bg2=MOD/'Lib/BG2_Main.tpa';text=texts[bg2]
    modules=re.findall(r'INCLUDE ~%MOD_FOLDER%/Lib/(\w+)_BG2.tpa~',text)
    if modules!=['Emily','Recorder','Vienxay']:errors.append('Wrong BG2 companion list: '+str(modules))
    for p in reached:
        if '/BG1/' not in str(p) and re.search(r'\bB?X3Isa\w*\b',texts[p],re.I):
            if p.name not in ('Setup-SkitiaNPCs.tp2','Artisan_Isaac.tpa','Isaac_Artisan_Templates.tpa'):
                errors.append('Unfinished BG2 Isaac reference: '+str(p.relative_to(ROOT)))
    nodes=[]; refs=[]
    for p in sorted(reached):
        if p.suffix.lower()=='.d':
            ns,rs=parse(p,read(p));nodes+=ns;refs+=rs
    defined={n['key'] for n in nodes}
    for ref in sorted(set(refs)):
        if ref[0] and ref[0].startswith(('x3','bx3')) and ref[1] != 'exit' and ref not in defined:
            errors.append('Unresolved custom dialogue state: '+str(ref))
    # BG2 linking retains the established Lite regression scope; BG1 has dynamic
    # area variables and external crossmod dependencies, checked separately.
    bg2texts={p:t for p,t in texts.items() if '/BG1/' not in str(p) and not p.name.startswith('BG1_')}
    linked=resource_links(texts,nodes,errors)
    if 'REMOVE_STORE_ITEM ~X3HGEM~' not in text: errors.append('The shared shop still sells Helga\'s quest crystal.')
    sod=read(MOD/'BG1/Emily/lib/emil_sod.tpa')
    if 'X3Isaac X32Isaa X32IsaaJ X32IsaaD' not in sod:errors.append('Isaac\'s SoD dialogue table is malformed.')
    for p in (MOD/'Lib/BG1_Recorder.tpa',MOD/'Lib/Recorder_BG2.tpa'):
        if 'ACTION_IF (IDS_OF_SYMBOL (~kit~ ~X3Bard~) < 0)' not in read(p):errors.append('Lorekeeper is not guarded against duplicate registration.')
    for p in (MOD/'BG1/Vienxay/library/vien_bg1.tpa',MOD/'Lib/Vienxay_BG2.tpa'):
        if 'ACTION_IF (IDS_OF_SYMBOL (~kit~ ~X3VSM~) < 0)' not in read(p):errors.append('Shadowmage is not guarded against duplicate registration.')
    if args.weidu:
        for p in sorted(reached):
            typ={'tp2':'TP2','tpa':'TPA','tph':'TPA','d':'D','baf':'BAF'}.get(p.suffix[1:].lower())
            if not typ:continue
            cmd=[str(args.weidu.resolve()),'--no-exit-pause']
            cmd+=['--game',str(args.game.resolve())] if args.game else ['--nogame']
            if args.ids_dir:cmd+=['--search-ids',str(args.ids_dir.resolve())]
            result=subprocess.run(cmd+['--parse-check',typ,str(p)],cwd=ROOT,capture_output=True,text=True)
            if result.returncode:errors.append(result.stdout+result.stderr)
    errors=list(dict.fromkeys(errors))
    if errors:
        print('\n'.join(errors));raise SystemExit(1)
    print(f'PASS: two components; {len(reached)} reachable sources; {len(contexts)} compilation/translation contexts.')
    print(f'PASS: {len(defined)} custom dialogue states; {len(refs)} transition references; {linked} explicit custom resource references.')
    if args.weidu:print('PASS: WeiDU syntax checks. No full EET installation or playthrough is implied.')

if __name__=='__main__':main()
