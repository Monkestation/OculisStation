https://github.com/Monkestation/OculisStation/pull/<!--PR Number-->

## Alert Levels + 

Module ID: OCULIS_ALERTS

### Description:

Adds a bunch of new alert levels, and changed the definitions of some current ones.
New alerts levels are Crimson (red-equivalent orange), White (red-equivalent violet), and Black (shits fucked).
The definitions of Red, Orange, and Violet have been changed to match the new ones, Red having some minor changes to its downto announcement and the upto remaining the same. Violet and Orange have just been downgraded in severity, so they may be used more easily in more minor/moderate emergencies.

### TG Proc/File Changes:

- `code/__DEFINES/~nova_defines/security_alerts.dm`: renumbered a bunch of stuff: had to insert crimson/white/black, which made some of the existing alert levels be shifted up. I do not think this affected anything as from my searching the code only calls for the names of the alerts not the numbers, which are just used for 'whats above what'
- `code/modules/security_levels/keycard_authentication.dm`:
  - added `KEYCARD_WHITE_ALERT` / `KEYCARD_CRIMSON_ALERT` defines (and matching `#undef`s)
  - `/obj/machinery/keycard_auth/ui_act()`: added `white_alert` and `crimson_alert` actions
  - `/obj/machinery/keycard_auth/proc/trigger_event()`: added handlers calling `SSsecurity_level.set_level()`; Crimson alert also sets emerg. engineering access like orange does already
- `tgui/packages/tgui/interfaces/KeycardAuth.jsx`: added White Alert and Crimson Alert buttons; window height `190` -> `240`
- `tgui/packages/tgui-panel/styles/tgchat/chat-dark.scss` and `chat-light.scss`: added `crimson`, `white`, `black` entries to `$alert-stripe-colors`, `$alert-stripe-alternate-colors`, `$alert-major-header-colors` and `$alert-subheader-header-colors`

### Modular Overrides:

- `modular_oculis/modules/alerts/code/overrides.dm`: `/datum/security_level/violet`, `/datum/security_level/orange`, `/datum/security_level/red` — overrides `elevating_to_announcement` / `lowering_to_announcement` and gets rid of the old defs that come from config (which I didn't want to change, since I heard changing config directly can cause issues since the repo doesn't always have the same config as the server)

### Defines:

- `code/__DEFINES/~nova_defines/security_alerts.dm`: `SEC_LEVEL_WHITE`, `SEC_LEVEL_CRIMSON`, `SEC_LEVEL_BLACK` (added as part of the first tg proc/file change whatever, self explanatory

### Included files that are not contained in this module:

- `modular_iris/modules/alerts/sound/alerts/doomalarm.ogg` (if that counts)

### Credits:

UndiscoveredAnomaly made this PR! Yay!
