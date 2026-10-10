# Changelog

## 2.0.0-beta.1 — 2026-10-10

- Combined Emily 1.65, Recorder 1.51 and Vienxay 1.67 for BG1/SoD with the corrected Skitia NPCs 1.1 Lite BG2/ToB content.
- Reduced the English EET installer to exactly two components: 0 for BG1/SoD and 1 for BG2/ToB.
- Kept Isaac's complete BG1/SoD content with Emily; retained the original disabled state of his unfinished BG2 module.
- Integrated Emily/Recorder music, BG2 romance themes, Vienxay's Crisshasart portraits and standard Mnemonic Retrieval. Kept Vienxay's BG1 music Yes/No prompt inside component 0.
- Kept Recorder as Lorekeeper; removed Kapellmeister and other unselected options and portrait/spell assets.
- Preserved the earlier Lite removal of Helga/Kale and its shared-romance merchant, quest and dialogue corrections. Removed their optional BG1/SoD conversations and script sequences.
- Added explicit per-source English translation contexts to avoid collisions between the combined packages.
- Guarded Lorekeeper and Shadowmage against duplicate kit registration. Kept BG2 Shadowmage quest spells outside the registration guard and updated the shared Lorekeeper CLAB for its BG2 Mnemonic Retrieval progression.
- Corrected Isaac's original missing-external-kit assignment and malformed SoD `bddialog.2da` entry.
- Removed a Kale-only condition that incorrectly blocked Recorder's final Alora banter.
- Added Artisan-ready Isaac templates, a request marker and a shared compatibility helper. Artisan Kitpack component 7005 can now assign its kit after the NPC compilation is installed.
- Added duplicate-NPC and EET installation-order checks, source validation and isolated compatibility tests.
- Kept Gustav's dialogue compatible with BG1 and BG2 Recorder, isolated their reset cutscenes, corrected Vienxay's reset calls/critical-hit voice, and installed the supplied SoD WAV line.
- Updated the Windows installer to WeiDU 251.

This is a new two-component layout. Uninstall older editions with their original installer before replacing files. Full installation and runtime testing remain outstanding.
