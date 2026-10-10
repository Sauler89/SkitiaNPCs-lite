# Skitia NPCs — EET compilation

**Emily, Recorder and Vienxay for BG1, Siege of Dragonspear, Shadows of Amn and Throne of Bhaal. Isaac is included with Emily in BG1/SoD.**

Version **2.0.0-beta.1**, English only, for **Enhanced Edition Trilogy (EET)**. This unofficial compilation combines the supplied Emily 1.65, Recorder 1.51 and Vienxay 1.67 packages with the corrected three-companion edition of Skitia NPCs 1.1. Original characters, writing, audio and artwork belong to Skitia and their contributors.

## Exactly two components

| ID | Installer component | Included content and fixed choices |
| --- | --- | --- |
| **0** | **SKITIA NPC BG:EE - Emily (with Isaac), Recorder and Vienxay** | All three BG1 NPCs, Isaac, their dialogue, recruitment, quests, items, voices, portraits, abilities and applicable SoD content. Emily's music and Recorder's music are included. Vienxay uses the default **Crisshasart** portrait. A **Yes/No** prompt inside this component controls Vienxay's BG1 dialogue music. |
| **1** | **SKITIA NPC BG2:EE - Emily, Recorder and Vienxay** | The three companions' SoA/ToB dialogue, quests, recruitment, romances, items, voices, abilities, epilogues and supported banters. **Romance Theme Music** is included. Vienxay uses the default **Crisshasart** portrait. **Mnemonic Retrieval** uses its original standard spell and BG2 progression. |

Both components are installed in the **BG2/EET game directory**, after EET core and before EET_end. They are separate campaign components, not instructions to install this package into two different game directories. Normally install **0, then 1**. Each can also be selected on its own.

Recorder remains a **Lorekeeper** throughout the compilation. Vienxay remains a **Shadowmage**. Their shared kit IDs are registered only once; the BG2 component still installs its quest spells and Lorekeeper's Mnemonic Retrieval progression when the BG1 kits already exist.

## Isaac and a later Artisan Kitpack installation

Isaac's final selected kit is **Artisan's Invisible Blade**, core Kitpack component **7005**, symbol `C0_INVISIBLE_BLADE`.

1. Install this compilation's BG1 component.
2. Later install **Artisan's Kitpack: Invisible Blade Thief Kit (7005)** from the [compatible Sauler89 fork](https://github.com/Sauler89/The-Artisan-s-Kitpack).
3. The compatibility hook assigns the newly registered kit to **both BG1 and SoD Isaac** automatically. No third component is added to this NPC installer.
4. Finish the remaining installation, including EET_end, before starting a new game.

If the Artisan kit is already installed, component 0 assigns it immediately. Until the later kit installation, Isaac safely uses **Skitia's original Invisible Blade** from Emily's main component. There is no installer choice between the two kits, and a missing Artisan symbol is never written into a creature.

The **unmodified upstream Kitpack does not automatically rekit Isaac**. Its component 7005 needs the small hook supplied in [compat/Artisan-Kitpack/isaac-hook.tpa](compat/Artisan-Kitpack/isaac-hook.tpa); the linked user fork includes that hook. It detects the compilation's marker and runs the shared helper after installing the kit.

The switch uses Emily's original Artisan-ready creature templates, including their prepared abilities, with Isaac's English identity, scripts, portraits and voice strings. Install subsequent NPC/stat/equipment tweaks **after** component 7005 so that their creature patches are applied to the final templates. This is an installation-time change to game resources; it does not convert an Isaac already stored in a save.

Isaac's BG2 module was disabled in the supplied Skitia NPCs 1.1 installer. This compilation preserves his complete **BG1/SoD** content; it does not enable that unfinished BG2 module.

## Excluded content

- Helga and Kale as playable companions, with their own BG2 quests, equipment, voices, portraits, epilogues and class/kit variants.
- Priest of Haela, Fighter/Priest of Haela, Warden, Vanguard Kale and Barbarian Kale options.
- Recorder's Kapellmeister conversion and the corresponding Bardic Wonders dependency.
- Vienxay's alternative Aeries1986 and NWN portraits.
- The IWD progression variant of Mnemonic Retrieval.
- Separate music, portrait, class and spell-choice components. The selected settings are integrated into components 0 and 1.
- BG1/SoD crossmod conversations and script sequences dedicated to Helga or Kale.

Shared resources needed by the retained companions remain. These include **Gigi's ToB jewelry shop and the engagement ring** used by their romances. Gigi no longer offers Helga's scrying quest or sells its crystal. Banters with existing vanilla companions, including Wilson, and supported installed crossmod NPCs do not install additional playable characters.

The BG2 component retains the original author's use of separate BG2 incarnations of Emily, Recorder and Vienxay for EET transitions and Fate Spirit summoning.

## Installation

1. Extract the package into the BG2/EET game directory, beside `chitin.key`. Keep the **SkitiaNPCs** folder and **Setup-SkitiaNPCs.exe** together.
2. Run `Setup-SkitiaNPCs.exe`, select English, and install component **0**, **1**, or both in that order.
3. Select **Yes or No** when asked about Vienxay's BG1 dialogue music. All other confirmed choices are built in.
4. Install Artisan's Invisible Blade **7005** with the compatibility hook when you reach the Kitpack in your install order.
5. Complete EET_end and the rest of your installation, then test with a **new game**.

The package includes **WeiDU 251** for Windows. On Linux/macOS, use a current WeiDU executable with `SkitiaNPCs/Setup-SkitiaNPCs.tp2`; the upstream audio routines require `oggdec` on Linux and SoX on macOS.

**This replaces the previous BG2-only Lite edition and the individual BG1 packages.** Component numbers have changed: the new 0 is BG1/SoD, and the new 1 is BG2/ToB. Uninstall all components of the previous/full package **using its old installer and files before replacing its folder**. Standalone BG1 NPCs already imported from a BGEE installation into EET must also be removed from the source installation and EET rebuilt before using the compilation. Do not install both editions or duplicate NPC packages together.

## Validation and beta status

Source paths, English translation contexts, custom dialogue destinations and the two-component layout have been checked. WeiDU 251 parses the reachable installer, library, dialogue and script sources. Isolated WeiDU tests exercise the actual Isaac compatibility helper in both installation orders, with a missing kit, repeated execution, an absent marker and uninstall restoration.

**A complete EET installation and in-game playthrough have not been performed.** See [docs/VALIDATION.md](docs/VALIDATION.md) for exact scope and reproduction commands. The beta label reflects this remaining runtime verification.

## Credits

- **Skitia** — original NPC mods, characters and writing: [Skitia's Stories](https://skitias-stories.com/).
- **Crisshasart** — retained default Vienxay portraits; all other original portrait, voice, music and asset contributor credits remain applicable.
- **The Artisan** — the external Invisible Blade kit and Kitpack. The kit itself is not bundled here.
- Original library authors and contributors — `fl#add_kit_ee`, `qd_multiclass`, cpmvars and other retained WeiDU helpers; their source attribution comments are preserved.
- **WeiDU** — installer, included under its [GPL license](docs/WEIDU-LICENSE.txt).
- **Sauler89** — unofficial EET compilation and the three-companion Lite fork.

The original BG2 README is retained in [docs/UPSTREAM-BG2.md](docs/UPSTREAM-BG2.md). This is an unofficial derivative, not an official Skitia release.
