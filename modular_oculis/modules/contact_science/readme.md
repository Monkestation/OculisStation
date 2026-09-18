<!-- This should be copy-pasted into the root of your module folder as readme.md -->

https://github.com/Monkestation/OculisStation/pull/<!--PR Number-->

## \<Contact Science> <!--Title of your addition.-->

Module ID: CONTACT_SCIENCE

### Description:

Adds a new form of science, Contact Science, involving contacting ghosts of the storm to learn more of them, reap their benefits, and hopefully avoid their consequences.

### TG Proc/File Changes:

- N/A
<!-- If you edited any core procs, you should list them here. You should specify the files and procs you changed.
E.g:
- `code/modules/mob/living.dm`: `proc/overriden_proc`, `var/overriden_var`
  -->

### Modular Overrides:

- N/A
<!-- If you added a new modular override (file or code-wise) for your module, you should list it here. Code files should specify what procs they changed, in case of multiple modules using the same file.
E.g:
- `modular_oculis/master_files/sound/my_cool_sound.ogg`
- `modular_oculis/master_files/code/my_modular_override.dm`: `proc/overriden_proc`, `var/overriden_var`
  -->

### Defines:

- modular_oculis\modules\contact_science\equipment\contact_research.dm, #define TECHWEB_NODE_CONTACT_SCIENCE "contact_science"
- code\DEFINES\traits\declarations.dm, #define TRAIT_CURSED_SUPPRESS "curse suppression"
- code\DEFINES\research\slimes.dm, #define SLIME_TYPE_PARASITE "parasite"
<!-- If you needed to add any defines, mention the files you added those defines in, along with the name of the defines. -->

### Included files that are not contained in this module:

- N/A
<!-- Likewise, be it a non-modular file or a modular one that's not contained within the folder belonging to this specific module, it should be mentioned here. Good examples are icons or sounds that are used between multiple modules, or other such edge-cases. -->

### Credits:

keygenpie - Coding/spriting
