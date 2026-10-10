# Later Invisible Blade assignment

The compatible [Sauler89 Kitpack fork](https://github.com/Sauler89/The-Artisan-s-Kitpack) includes `isaac-hook.tpa`'s code at the **end** of `ArtisansKitpack/lib/Invisible_Blade.tpa`. This is the library installed by core component **7005**.

For another Kitpack copy, append that small block after the existing kit-install code. Do not replace the Kitpack's complete library with an older version. The block only runs when the EET compilation's `SNIBREQ.2da` marker and its helper source exist. It does not change unrelated NPC installations and adds no NPC installer component.

`SkitiaNPCs/Lib/Artisan_Isaac.tpa` resolves the actual `C0_INVISIBLE_BLADE` index from `kit.ids`, then installs the English Artisan-ready BG1/SoD Isaac templates prepared by the compilation. A missing symbol leaves existing creatures untouched.

The kit remains an external dependency. Install subsequent creature/stat/equipment tweaks after it, and finish the installation before starting a new game.
