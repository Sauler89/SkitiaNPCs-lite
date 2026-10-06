# Validation — 1.1-lite-beta.2

The Lite edition was checked against fork baseline `b903eb2448c6af049262992e1148fa4eb2878d02`. The baseline installer matches the supplied `SkitiaNPCs-master.zip`.

## Completed checks

- WeiDU 25100 parsed all **144** remaining TP2, TPA, D and BAF files successfully.
- BAF parsing used BG2:EE action, trigger and identifier definitions extracted from the Gibberlings3 IESDP repository. These are validation inputs, not files distributed with or installed by this mod.
- Static source analysis found **4,493** named dialogue states and **7,619** transition references. Custom `X3` / `BX3` dialogue destinations resolve to retained state definitions.
- No active installer, dialogue or script source references the excluded `X3Hel*`, `X3Kal*` or `X3Isa*` actors and variables.
- Explicit installer source paths resolve case-insensitively. All **138** dialogue/script sources have a translation context; their referenced IDs exist in the setup/module/USING files available at compilation.
- Checked **249** explicit custom item, creature, script, dialogue, store and spell references against COPY/COMPILE outputs, including both sides of item transformations. This is a targeted check of the action forms listed in the validator, not a complete game resource linker.
- Checked the reduced NPC module list, stable component IDs and the three corrected dialogue continuations: Emily's injured-player flirt, Vienxay's ToB family topic and Haer'Dalis's response during Recorder's quest.
- Checked remaining binary resources for references to deleted custom resources; removed the unused Isaac wraith creature that still pointed to his deleted dialogue.
- Pruned unused dialogue translation entries without renumbering surviving IDs.

## Second audit corrections

The second audit found gaps in beta.1's actor-prefix and global translation-ID checks:

- Removed Helga's note-transcription service and Kale's cheese research from `X3RMOM.d`, including their entry options, unreachable states and journal strings. The remaining vampire-body condition now has six alternatives.
- Removed Kale's loved-one branch from the shared wraith cutscene.
- Restored the shared engagement ring and Gigi's Amkethran shop, which were originally installed by Helga's module. The shop, creature and ring reuse their original binary assets. The installer removes Helga's scrying crystal from the shop, assigns the merchant's dialogue, clears its nonexistent custom script and compiles a quest-free shop dialogue. The spawn keeps its original location with a Lite-specific flag.
- Changed Emily's disapproval notification to Emily's string and pruned unused Isaac cutscene strings.
- Added the missing Kapellmeister prerequisite and verified it against the actual `kit.ids` symbol.
- Corrected the inherited `X3VTome` typo to `X3VTome1` in Vienxay's Underdark script.

WeiDU 25100 also executed the isolated shared-merchant installation block against an empty test TLK with BG2:EE IDS definitions. The compiled dialogue and spawn script were produced, the engagement ring remained in the 17-item store, the scrying crystal was absent, and the creature's dialogue/script fields matched the intended values. Separate isolated runs verified that the exact Kapellmeister predicate rejects a missing kit and accepts the defined kit. These fixtures exercise the changed patches and predicate; they do not represent a full BG2:EE/EET installation.

The source validator now checks the translation contexts, explicit resource links, removed quest identifiers, merchant installation and kit prerequisite in addition to the earlier checks.

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

Recommended beta smoke test: install on a clean test copy; recruit each of the three companions in SoA; check personal and rest dialogue; visit Recorder's mother and check Vienxay's tome quest; check the Bodhi sequence; start ToB and summon each companion through the Fate Spirit; visit Gigi in Amkethran and buy the engagement ring for a retained romance; repeat on EET. Confirm that Helga and Kale are absent from recruitment and summoning and that their optional components are no longer offered.
