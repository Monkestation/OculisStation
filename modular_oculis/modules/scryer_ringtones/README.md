<!-- This should be copy-pasted into the root of your module folder as readme.md -->

https://github.com/Monkestation/OculisStation/pull/<!--PR Number-->

## Scryer Ringtones

Module ID: scryer_ringtones

### Description:

ringtones for scryers.

### TG Proc/File Changes:

- `code/modules/mod/mod_link.dm`: `var/ringtone`, `proc/Initialize`, `proc/examine`, `proc/attack_self`, `proc/set_ringtone`, `/datum/mod_link/var/soundloop & attempting_target`, `/datum/mod_link/New`, `/datum/mod_link/Destroy`, `/datum/mod_link/proc/call_link`, `/proc/call_link` ok i give up, you can see the changes they're labeled with the module id
- `code/datums/station_traits/neutral_traits.dm`: `/datum/station_trait/scryers/proc/on_job_after_spawn`
- `modular_nova/modules/loadouts/loadout_items/loadout_datum_pocket.dm`: `/datum/loadout_item/pocket_items/link_scryer/post_equip_item`

### Modular Overrides:

<!-- If you added a new modular override (file or code-wise) for your module, you should list it here. Code files should specify what procs they changed, in case of multiple modules using the same file.
E.g:
- `modular_oculis/master_files/sound/my_cool_sound.ogg`
- `modular_oculis/master_files/code/my_modular_override.dm`: `proc/overriden_proc`, `var/overriden_var`
  -->

### Defines:

- `code/__DEFINES/sound.dm`: `CHANNEL_RINGTONES`
- `code/__DEFINES/~~oculis_defines/scryer.dm`
<!-- If you needed to add any defines, mention the files you added those defines in, along with the name of the defines. -->

### Included files that are not contained in this module:

- N/A
<!-- Likewise, be it a non-modular file or a modular one that's not contained within the folder belonging to this specific module, it should be mentioned here. Good examples are icons or sounds that are used between multiple modules, or other such edge-cases. -->

### Credits:

Flleeppyy, veth-s
