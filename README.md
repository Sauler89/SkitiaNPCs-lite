# Skitia NPCs Lite — Emily, Recorder & Vienxay

A three-companion variant of **Skitia NPCs for Baldur's Gate II**, based on the original version 1.1. The original characters, writing, voice acting and artwork belong to Skitia and the original contributors. This fork removes Helga and Kale from the BG2 portion of the mod.

**Version: 1.1-lite-beta.2 — English — BG2:EE / EET.**

## Included companions

- **Emily** — aasimar archer.
- **Recorder** — bard with the Lorekeeper kit.
- **Vienxay** — mage/thief with the Shadowmage kit.

The main component installs all three together. Their own SoA/ToB recruitment, quests, romances, personal dialogue, rest talks, voice sets, equipment and epilogues remain, together with their banters with the remaining companions and supported external NPCs. The original game's writing remains in English.

## What changed

- Removed Helga and Kale's installers, creatures, quests, dialogue, audio, equipment, portraits, epilogues and exclusive kit assets.
- Removed the Priest of Haela, Fighter/Priest of Haela and Warden kits, plus Helga/Kale's alternate class and portrait options.
- Reduced dialogue initialization, rest-talk menus, Fate Spirit summoning and EET transitions to the three included companions.
- Updated shared Bodhi, Phaere, Dorn and endgame scripts, romance conditions, recruitment exchanges, party interjections and crossmod banters to work without the removed companions.
- Removed Helga's scrying quest branches and supporting cutscenes from Recorder and Vienxay, and Helga/Kale's quest services from Recorder's mother.
- Kept the shared ToB engagement ring and Gigi's jewelry shop for the three remaining romances. Gigi no longer offers Helga's quest or sells its scrying crystal.
- Removed dormant Isaac content and references. Isaac was not installed by the original main component.
- Preserved Vienxay's ToB family conversation and Haer'Dalis's response in Recorder's quest by correcting their original, accidental requirements for Kale. Added the missing continuation of Emily's injured-player flirt when Helga is absent.
- Removed an unused Isaac cutscene script from Emily's compile list, a reference to a nonexistent `Start.tra`, and a duplicate Wilson dialogue initialization. Changed source-file item copies to use `COPY`.
- Corrected Emily's disapproval message and the quest tome resource name in Vienxay's Underdark area script.
- Added main-component prerequisites to optional components and a check for the external Kapellmeister kit.

See [the validation notes](docs/VALIDATION.md) for the scope and limitations of testing.

## Components

Original component numbers are retained; gaps are intentional.

| ID | Component |
| --- | --- |
| 0 | Skitia NPCs Lite — Emily, Recorder and Vienxay |
| 2 / 3 | Enable / omit romance theme music |
| 8 / 9 / 10 | Vienxay portrait: Crisshasart / Aeries1986 / NWN |
| 13 | Give Recorder the external Kapellmeister kit |
| 14 / 15 | Mnemonic Retrieval: IWD progression / default |

Component 13 requires the Kapellmeister kit to be installed first. All optional components require component 0.

## Installation

1. Download this repository with **Code → Download ZIP** and extract it.
2. Place the `SkitiaNPCs` folder and `Setup-SkitiaNPCs.exe` in the BG2:EE or EET game directory, beside `chitin.key`.
3. Run `Setup-SkitiaNPCs.exe`, select English and install the main component and desired options.
4. On EET, install in the BG2/EET game directory before `EET_end`, following your other NPC mods' ordering requirements.

The original folder and installer names are deliberately retained. **Lite replaces the full Skitia NPCs package; do not install both.** To switch an existing installation, uninstall the full mod with its original files before replacing its folder. Test on a new game: Lite does not remove creatures or quest state already stored in an existing save.

The BG1 versions of these NPCs are separate mods. This fork does not uninstall or modify them; its EET transition setup uses the included BG2 versions, as the original package did.

## Credits

Original mod and characters: **Skitia** — [Skitia's Stories](https://skitias-stories.com/).
All original asset and contributor credits remain applicable. This is an unofficial Lite fork maintained under [Sauler89/SkitiaNPCs-lite](https://github.com/Sauler89/SkitiaNPCs-lite), not a new original NPC mod.
