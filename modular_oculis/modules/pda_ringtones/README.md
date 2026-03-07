<!-- This should be copy-pasted into the root of your module folder as readme.md -->

https://github.com/Monkestation/OculisStation/pull/<!--PR Number-->

## PDA Ringtones <!--Title of your addition.-->

Module ID: pda_ringtones <!-- Uppercase, UNDERSCORE_CONNECTED name of your module, that you use to mark files. This is so people can case-sensitive search for your edits, if any. -->

### Description:

- Ported from https://github.com/Monkestation/Monkestation2.0/pull/9871

### TG Proc/File Changes:

- N/A
<!-- If you edited any core procs, you should list them here. You should specify the files and procs you changed.
E.g:
- `code/modules/mob/living.dm`: `proc/overriden_proc`, `var/overriden_var`
  -->
- `code/__DEFINES/sound.dm`: `CHANNEL_RINGTONES`
- `code/modules/modular_computers/computers/item/pda.dm`: `update_pda_prefs`
- `code/modules/modular_computers/computers/item/computer.dm`: `ring`, `send_sound`

### Modular Overrides:

- N/A
<!-- If you added a new modular override (file or code-wise) for your module, you should list it here. Code files should specify what procs they changed, in case of multi	ple modules using the same file.
E.g:
- `modular_oculis/master_files/sound/my_cool_sound.ogg`
- `modular_oculis/master_files/code/my_modular_override.dm`: `proc/overriden_proc`, `var/overriden_var`
  -->

### Defines:

- `code/__DEFINES/sound.dm`: `CHANNEL_RINGTONES`

<!-- If you needed to add any defines, mention the files you added those defines in, along with the name of the defines. -->

### Included files that are not contained in this module:

- N/A
<!-- Likewise, be it a non-modular file or a modular one that's not contained within the folder belonging to this specific module, it should be mentioned here. Good examples are icons or sounds that are used between multiple modules, or other such edge-cases. -->

### Credits:

<!-- Here go the credits to you, dear coder, and in case of collaborative work or ports, credits to the original source of the code. -->
