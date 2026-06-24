<!-- This should be copy-pasted into the root of your module folder as readme.md -->

https://github.com/Monkestation/OculisStation/pull/312<!--PR Number-->

## Belt Satchels <!--Title of your addition.-->

Module ID: BELT_SATCHELS<!-- Uppercase, UNDERSCORE_CONNECTED name of your module, that you use to mark files. This is so people can case-sensitive search for your edits, if any. -->

### Description:

Allows satchels to be worn on the belt, in exchange for holding less and slowing you when paired with a backpack on your back.

In specific, allows `/obj/item/storage/backpack/satchel/`s to be worn on the belt, and slows you when you have a `/obj/item/storage/backpack/` on both your belt and back.

<!-- Here, try to describe what your PR does, what features it provides and any other directly useful information. -->

### TG Proc/File Changes:

- WIP
<!-- If you edited any core procs, you should list them here. You should specify the files and procs you changed.
E.g:
- `code/modules/mob/living.dm`: `proc/overriden_proc`, `var/overriden_var`
  -->

### Modular Overrides:

- `modular_oculis/master_files/code/game/objects/items/storage/backpack.dm`:
  - `/obj/item/storage/backpack/equipped`
  - `/obj/item/storage/backpack/dropped`
  - `/obj/item/storage/backpack/satchel/Initialize`

<!-- If you added a new modular override (file or code-wise) for your module, you should list it here. Code files should specify what procs they changed, in case of multiple modules using the same file.
E.g:
- `modular_oculis/master_files/sound/my_cool_sound.ogg`
- `modular_oculis/master_files/code/my_modular_override.dm`: `proc/overriden_proc`, `var/overriden_var`
  -->

### Defines:

- `code\__DEFINES\~~oculis_defines\storage.dm`:
  - `PAIRED_STORAGE_DEFAULT_SLOWDOWN`

<!-- If you needed to add any defines, mention the files you added those defines in, along with the name of the defines. -->

### Included files that are not contained in this module:

- N/A
<!-- Likewise, be it a non-modular file or a modular one that's not contained within the folder belonging to this specific module, it should be mentioned here. Good examples are icons or sounds that are used between multiple modules, or other such edge-cases. -->

### Credits:

- Shroopy - module creator
- [Monkestation](https://github.com/Monkestation/Monkestation2.0) - original source of the ported belt satchel code
<!-- Here go the credits to you, dear coder, and in case of collaborative work or ports, credits to the original source of the code. -->
