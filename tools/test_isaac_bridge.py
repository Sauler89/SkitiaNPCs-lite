#!/usr/bin/env python3
"""Exercise Isaac's real compatibility helper in an isolated, empty WeiDU game."""
from pathlib import Path
import argparse
import shutil
import struct
import subprocess
import tempfile

ROOT=Path(__file__).resolve().parents[1]

def kit(path):
    return struct.unpack_from('<H',path.read_bytes(),0x246)[0]

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--weidu',required=True,type=Path)
    args=ap.parse_args();exe=args.weidu.resolve()
    with tempfile.TemporaryDirectory(prefix='skitia-isaac-') as directory:
        fixture=Path(directory)
        def prepare(name,early=False,marker=True):
            game=fixture/name;game.mkdir();(game/'override').mkdir()
            (game/'dialog.tlk').write_bytes(b'TLK V1  '+struct.pack('<HII',0,0,18))
            (game/'chitin.key').write_bytes(b'KEY V1  '+struct.pack('<IIII',0,0,24,24))
            (game/'override/kit.ids').write_text('IDS V1.0\n0x4000 TRUECLASS\n0x4001 X3EIB\n'+('0x4002 C0_INVISIBLE_BLADE\n' if early else ''))
            files=['SkitiaNPCs/Lib/Artisan_Isaac.tpa','SkitiaNPCs/Lib/Isaac_Artisan_Templates.tpa',
                   'SkitiaNPCs/Config/SNIBREQ.2da','SkitiaNPCs/BG1/Emily/tra/English/Isaac.tra',
                   'SkitiaNPCs/BG1/Emily/creatures/X3Isaac.cre','SkitiaNPCs/BG1/Emily/creatures/C0Isaac.cre',
                   'SkitiaNPCs/BG1/Emily/creatures/SoD/X32Isaa.cre','SkitiaNPCs/BG1/Emily/creatures/SoD/C02Isaa.CRE',
                   'compat/Artisan-Kitpack/isaac-hook.tpa']
            for file in files:
                target=game/file;target.parent.mkdir(parents=True,exist_ok=True);shutil.copy(ROOT/file,target)
            marker_copy='COPY ~SkitiaNPCs/Config/SNIBREQ.2da~ ~override/SNIBREQ.2da~' if marker else ''
            (game/'probe.tp2').write_text('''BACKUP ~backup~
AUTHOR ~Isolated compatibility fixture~
LANGUAGE ~English~ ~English~ ~SkitiaNPCs/BG1/Emily/tra/English/Isaac.tra~
BEGIN ~Prepare Isaac~
OUTER_SPRINT sn_emily ~SkitiaNPCs/BG1/Emily~
COPY ~%sn_emily%/creatures/X3Isaac.cre~ ~override/X3Isaac.cre~
  WRITE_SHORT 0x246 0x4001
COPY ~%sn_emily%/creatures/SoD/X32Isaa.cre~ ~override/X32Isaa.cre~
  WRITE_SHORT 0x246 0x4001
COPY ~%sn_emily%/creatures/SoD/X32Isaa.cre~ ~override/bdcaelar.cre~
INCLUDE ~SkitiaNPCs/Lib/Isaac_Artisan_Templates.tpa~
'''+marker_copy+'''
INCLUDE ~compat/Artisan-Kitpack/isaac-hook.tpa~
BEGIN ~Register Artisan later and run its hook~
APPEND ~kit.ids~ ~0x4002 C0_INVISIBLE_BLADE~ UNLESS ~C0_INVISIBLE_BLADE~
INCLUDE ~compat/Artisan-Kitpack/isaac-hook.tpa~
BEGIN ~Run the hook again~
INCLUDE ~compat/Artisan-Kitpack/isaac-hook.tpa~
''')
            return game
        def run(game,option,component):
            command=[str(exe),'probe.tp2','--game','.', '--language','0',option,str(component),'--no-exit-pause']
            result=subprocess.run(command,cwd=game,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True)
            if result.returncode:raise AssertionError(result.stdout)
        def assigned(game):
            for target,snapshot,script in [('X3Isaac','SNIBG1','X3Isaac'),('X32Isaa','SNIBSOD','X32Isaa')]:
                p=game/'override'/(target+'.cre');data=p.read_bytes()
                assert kit(p)==0x4002,(target,'wrong dynamically resolved kit')
                expected=bytearray((game/'override'/(snapshot+'.cre')).read_bytes())
                struct.pack_into('<H',expected,0x246,0x4002)
                assert data==expected,(target,'author-provided template not preserved')
                assert data[0x248:0x250].rstrip(b'\0').decode()==script
                assert data[0x2cc:0x2d4].rstrip(b'\0').decode()==script
                assert data[0x280:0x2a0].rstrip(b'\0')==b'X3Isaac'
                assert b'C0IVB02' in data and b'X3EFEINT' not in data
                tlk=(game/'dialog.tlk').read_bytes();count,offset=struct.unpack_from('<II',tlk,0x0a)
                ref=struct.unpack_from('<I',data,8)[0];assert ref<count
                start,length=struct.unpack_from('<II',tlk,18+26*ref+18)
                assert tlk[offset+start:offset+start+length]==b'Isaac'
        late=prepare('late');run(late,'--force-install-list',0)
        before={file:(late/'override'/file).read_bytes() for file in ('X3Isaac.cre','X32Isaa.cre')}
        assert all(kit(late/'override'/file)==0x4001 for file in before)
        run(late,'--force-install-list',1);assigned(late)
        after={file:(late/'override'/file).read_bytes() for file in before}
        run(late,'--force-install-list',2)
        assert all((late/'override'/file).read_bytes()==data for file,data in after.items())
        run(late,'--force-uninstall-list',2);run(late,'--force-uninstall-list',1)
        assert all((late/'override'/file).read_bytes()==data for file,data in before.items())
        assert 'C0_INVISIBLE_BLADE' not in (late/'override/kit.ids').read_text()
        early=prepare('early',early=True);run(early,'--force-install-list',0);assigned(early)
        unrelated=prepare('no-marker',early=True,marker=False);run(unrelated,'--force-install-list',0)
        assert kit(unrelated/'override/X3Isaac.cre')==0x4001
        assert kit(unrelated/'override/X32Isaa.cre')==0x4001
    print('PASS: missing kit is safe; both install orders assign BG1/SoD Isaac; author templates and identity survive.')
    print('PASS: repeated hook is stable; uninstall restores prior creatures; absent marker prevents unrelated changes.')
    print('These are isolated WeiDU patch tests, not a full Artisan/EET installation or playthrough.')

if __name__=='__main__':main()
