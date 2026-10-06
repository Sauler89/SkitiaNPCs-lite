# Validation — 1.1-lite-beta.1

The Lite edition was checked against fork baseline `b903eb2448c6af049262992e1148fa4eb2878d02`. The baseline installer matches the supplied `SkitiaNPCs-master.zip`.

## Completed checks

- WeiDU 25100 parsed all **142** remaining TP2, TPA, D and BAF files successfully.
- BAF parsing used BG2:EE action, trigger and identifier definitions extracted from the Gibberlings3 IESDP repository. These are validation inputs, not files distributed with or installed by this mod.
- Static source analysis found **4,507** named dialogue states and **7,651** transition references. Custom `X3` / `BX3` dialogue destinations resolve to retained state definitions.
- No active installer, dialogue or script source references the excluded `X3Hel*`, `X3Kal*` or `X3Isa*` actors and variables.
- Explicit installer source paths resolve case-insensitively, and translation IDs referenced by retained code exist in the remaining translation files.
- Checked the reduced NPC module list, stable component IDs and the three corrected dialogue continuations: Emily's injured-player flirt, Vienxay's ToB family topic and Haer'Dalis's response during Recorder's quest.
- Checked remaining binary resources for references to deleted custom resources; removed the unused Isaac wraith creature that still pointed to his deleted dialogue.
- Pruned unused dialogue translation entries without renumbering surviving IDs.

## Reproduce the source checks

From the repository root:

```sh
python tools/validate_lite.py
```

To also run WeiDU syntax checks using an installed BG2:EE/EET game for its IDS tables:

```sh
python tools/validate_lite.py --weidu /path/to/weidu --game /path/to/game
```

Alternatively, pass `--ids-dir /path/to/bg2ee-ids` with `--weidu` for parsing without a game installation.

## Not yet validated

These checks are **not a complete WeiDU installation, game-resource linkage test or playthrough**. No BG2:EE/EET installation was available for full installation testing. Vanilla dialogue state numbers, third-party crossmod combinations, audiovisual playback and runtime quest progression still require in-game verification.

Recommended beta smoke test: install on a clean test copy; recruit each of the three companions in SoA; check personal and rest dialogue; check the Bodhi sequence; start ToB and summon each companion through the Fate Spirit; repeat on EET. Confirm that Helga and Kale are absent from recruitment and summoning and that their optional components are no longer offered.
