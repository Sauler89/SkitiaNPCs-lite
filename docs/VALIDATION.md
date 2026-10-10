# Validation — EET compilation 2.0.0-beta.1

## Completed checks

- The installer exposes exactly **two English components**, designated **0** (BG1/SoD) and **1** (BG2/ToB), and contains no separate optional component or bundled standalone NPC TP2.
- Source analysis follows the actual INCLUDE/COMPILE/EXTEND graph: **336 reachable source files** and **308 compilation/translation contexts**. Explicit local source paths resolve, and each referenced patch/dialogue/script translation ID is available in its LOAD_TRA/USING context.
- Checked **7,970** custom dialogue state definitions and **12,923** transition references. Custom X3/BX3 destinations resolve to retained definitions; EXIT terminators are not treated as state labels.
- Checked **531** explicit custom creature, item, spell, store, script and dialogue references against installation outputs. This is a targeted source-link check, not a complete binary/game-resource linker.
- Confirmed the BG2 module list is Emily, Recorder and Vienxay, and that active excluded Helga/Kale actor references do not remain in the reachable source graph. The unfinished BG2 Isaac module is not installed.
- WeiDU **25100** parses all reachable TP2, TPA, TPH, D and BAF sources. Parser IDS inputs come from the Gibberlings3 IESDP repository. Two SoD-only object names missing from its generic BG2EE tables, CRUSADERS and HOSTILES3, were added as **parser-only aliases**. Their fixture numbers are never distributed or installed; real EET resolves its own merged IDS values.
- Isolated WeiDU tests execute the **actual Isaac template/helper and Artisan compatibility-hook sources**, using an empty KEY/TLK fixture. They verify that a missing external kit leaves both creatures valid, either installation order assigns the resolved kit, the author-provided abilities and English identity/script/dialogue fields survive, repeated execution is stable, an absent marker prevents unrelated changes, and uninstall restores the previous creatures and IDS table.
- Checked that Lorekeeper and Shadowmage registration is guarded; BG2 Shadowmage spell copies remain outside that guard; the BG2 Lorekeeper table includes standard Mnemonic Retrieval progression. Isaac's SoD dialogue-table row has four separate columns.
- Kept Gustav's common dialogue compatible with both Recorder incarnations, isolated Recorder's BG1 reset cutscene from its BG2 counterpart, corrected Vienxay's reset-cutscene calls and critical-hit voice reference, and explicitly copied the supplied WAV voice line. Preserved the previous Lite edition's shared engagement-ring merchant and quest/dialogue corrections. Its earlier audit record is retained in VALIDATION-LITE-beta2.md.

## Reproduce

From the repository root:

```sh
python tools/validate_eet.py
python tools/test_isaac_bridge.py --weidu /path/to/weidu
```

To also parse scripts against an actual EET installation:

```sh
python tools/validate_eet.py --weidu /path/to/weidu --game /path/to/EET
```

For parsing without a game, pass `--ids-dir /path/to/complete-bg2ee-sod-ids` instead of `--game`. Do not copy validation IDS fixtures into your game.

## Remaining runtime verification

These checks are **not a full EET installation, complete resource-link test, full Artisan component installation or playthrough**. No complete game installation was available. Vanilla dialogue state numbers, EET transition execution, audiovisual playback, other-mod combinations, kit ability behavior and quest progression still need in-game verification.

Recommended clean-game beta check: install 0 and 1, then the hooked Artisan component 7005, then finish EET_end. Recruit Emily, Isaac, Recorder and Vienxay in BG1; verify Isaac's kit, dialogue, soundset and initial abilities. Continue into SoD and confirm the four companions' join/kick-out dialogue and personal content. In SoA/ToB, recruit or summon the three BG2 companions; check Recorder's Lorekeeper/Mnemonic Retrieval, Vienxay's quest spells, romances, rest talks, epilogues and Gigi's engagement-ring shop. Confirm that Helga/Kale are absent from recruitment, summoning and installer choices. Separately check the No answer for Vienxay's BG1 music.
