// TODO: If the sound mixer is ever added, add the following to get_channel_name of code/game/sound/sound.dm
/*
	if(CHANNEL_RINGTONES)
		return "Ringtones (Modlinks/PDA)"
*/
// and of course, add CHANNEL_RINGTONES to code/game/sound/sound_channels.dm

// To add sounds to the PDA, all you need to do is add the following define ex:
// #define PDA_RINGTONE_WOOF "Woof"
// Then Add the PDA_RINGTONE_WOOF to the global list pda_ringtone_sounds, with its associative sound path
/// List of available ringtone sounds
#define PDA_RINGTONE_ALERT1 "Alert 1"
#define PDA_RINGTONE_ALERT2 "Alert 2"
#define PDA_RINGTONE_ALERT3 "Alert 3"
#define PDA_RINGTONE_ALERT4 "Alert 4"
#define PDA_RINGTONE_BELL "Bell"
#define PDA_RINGTONE_BEEP "Beep"
#define PDA_RINGTONE_BUZZ "BUZZ"
#define PDA_RINGTONE_BYONDPAGER "BYOND Pager"
#define PDA_RINGTONE_BYONDPAGERDOWN "BYOND Pager Down"
#define PDA_RINGTONE_BIKEHORN "Bikehorn"
#define PDA_RINGTONE_CHIME "Chime"
#define PDA_RINGTONE_CHORD1 "Chord 1"
#define PDA_RINGTONE_CHORD2 "Chord 2"
#define PDA_RINGTONE_CHORD3 "Chord 3"
#define PDA_RINGTONE_CODEC "Codec"
#define PDA_RINGTONE_DING "Ding"
#define PDA_RINGTONE_HORN "Horn"
#define PDA_RINGTONE_MAUS "Maus"
#define PDA_RINGTONE_MEOW1 "Meow 1"
#define PDA_RINGTONE_MEOW2 "Meow 2"
#define PDA_RINGTONE_MEOW3 "Meow 3"
#define PDA_RINGTONE_MEOW4 "Meow 4"
#define PDA_RINGTONE_MEOW_ELECTRIC "Meow (Electric)"
#define PDA_RINGTONE_MORSE "Morse"
#define PDA_RINGTONE_OHHIMARK "Oh Hi Mark"
#define PDA_RINGTONE_JINGLE "Mysterious Jingle"
#define PDA_RINGTONE_NORMALIZE "Normalize"
#define PDA_RINGTONE_NOT_ALPHYS "Not Alphys"
#define PDA_RINGTONE_PHONE_CHIME "Phone Chime"
#define PDA_RINGTONE_PIANO "Piano"
#define PDA_RINGTONE_PING "Ping"
#define PDA_RINGTONE_SPEAKING "Speaking"
#define PDA_RINGTONE_SPLAT "Splat"
#define PDA_RINGTONE_TARGET "Target"
#define PDA_RINGTONE_TERMINAL_NOTIF1 "Terminal Notif 1"
#define PDA_RINGTONE_WEH "Weh"

/// Default ringtone sound
#define PDA_RINGTONE_SOUND_DEFAULT PDA_RINGTONE_BEEP

// Map ringtone names to sound files
GLOBAL_LIST_INIT(pda_ringtone_sounds, list(
	PDA_RINGTONE_ALERT1 = 'modular_oculis/modules/pda_ringtones/sound/alert1.ogg',
	PDA_RINGTONE_ALERT2 = 'modular_oculis/modules/pda_ringtones/sound/alert2.ogg',
	PDA_RINGTONE_ALERT3 = 'modular_oculis/modules/pda_ringtones/sound/alert3.ogg',
	PDA_RINGTONE_ALERT4 = 'modular_oculis/modules/pda_ringtones/sound/alert4.ogg',
	PDA_RINGTONE_BEEP = 'modular_oculis/modules/pda_ringtones/sound/terminal_success.ogg',
	PDA_RINGTONE_BELL = 'modular_oculis/modules/pda_ringtones/sound/bell.ogg',
	PDA_RINGTONE_BIKEHORN = 'modular_oculis/modules/pda_ringtones/sound/bikehorn.ogg',
	PDA_RINGTONE_BYONDPAGER = 'modular_oculis/modules/pda_ringtones/sound/byond_pager.ogg',
	PDA_RINGTONE_BYONDPAGERDOWN = 'modular_oculis/modules/pda_ringtones/sound/byond_pager_down.ogg',
	PDA_RINGTONE_CHIME = 'modular_oculis/modules/pda_ringtones/sound/chime.ogg',
	PDA_RINGTONE_CHORD1 = 'modular_oculis/modules/pda_ringtones/sound/chord1.ogg',
	PDA_RINGTONE_CHORD2 = 'modular_oculis/modules/pda_ringtones/sound/chord2.ogg',
	PDA_RINGTONE_CHORD3 = 'modular_oculis/modules/pda_ringtones/sound/chord3.ogg',
	PDA_RINGTONE_CODEC = 'modular_oculis/modules/pda_ringtones/sound/codec.ogg',
	PDA_RINGTONE_DING = 'modular_oculis/modules/pda_ringtones/sound/ding.ogg',
	PDA_RINGTONE_HORN = 'modular_oculis/modules/pda_ringtones/sound/horn.ogg',
	PDA_RINGTONE_MAUS = 'modular_oculis/modules/pda_ringtones/sound/maus.ogg',
	PDA_RINGTONE_MEOW1 = 'modular_oculis/modules/pda_ringtones/sound/meow1.ogg',
	PDA_RINGTONE_MEOW2 = 'modular_oculis/modules/pda_ringtones/sound/meow2.ogg',
	PDA_RINGTONE_MEOW3 = 'modular_oculis/modules/pda_ringtones/sound/meow3.ogg',
	PDA_RINGTONE_MEOW4 = 'modular_oculis/modules/pda_ringtones/sound/meow4.ogg',
	PDA_RINGTONE_MEOW_ELECTRIC = 'modular_oculis/modules/pda_ringtones/sound/meow_electric.ogg',
	PDA_RINGTONE_MORSE = 'modular_oculis/modules/pda_ringtones/sound/morse.ogg',
	PDA_RINGTONE_OHHIMARK = 'modular_oculis/modules/pda_ringtones/sound/oh_hi_mark.ogg',
	PDA_RINGTONE_JINGLE = 'modular_oculis/modules/pda_ringtones/sound/jingle.ogg',
	PDA_RINGTONE_BUZZ = 'modular_oculis/modules/pda_ringtones/sound/buzz.ogg',
	PDA_RINGTONE_NOT_ALPHYS = 'modular_oculis/modules/pda_ringtones/sound/not_alphys.ogg',
	PDA_RINGTONE_PHONE_CHIME = 'modular_oculis/modules/pda_ringtones/sound/phone_chime.ogg',
	PDA_RINGTONE_PIANO = 'modular_oculis/modules/pda_ringtones/sound/piano.ogg',
	PDA_RINGTONE_PING = 'modular_oculis/modules/pda_ringtones/sound/ping.ogg',
	PDA_RINGTONE_SPEAKING = 'modular_oculis/modules/pda_ringtones/sound/speaking.ogg',
	PDA_RINGTONE_SPLAT = 'modular_oculis/modules/pda_ringtones/sound/splat.ogg',
	PDA_RINGTONE_TARGET = 'modular_oculis/modules/pda_ringtones/sound/target.ogg',
	PDA_RINGTONE_TERMINAL_NOTIF1 = 'modular_oculis/modules/pda_ringtones/sound/terminal_notif1.ogg',
	PDA_RINGTONE_WEH = 'modular_oculis/modules/pda_ringtones/sound/weh.ogg',
))

/datum/preference/choiced/pda_ringtone_sound
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "pda_ringtone_sound"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference_middleware/pda_ringtone_sound
	COOLDOWN_DECLARE(ringtone_cooldown)
	action_delegations = list(
		"play_ringtone_sound" = PROC_REF(play_ringtone_sound),
	)

/datum/preference_middleware/pda_ringtone_sound/proc/play_ringtone_sound(list/params, mob/user)
	if(!COOLDOWN_FINISHED(src, ringtone_cooldown))
		return TRUE
	user.playsound_local(
		turf_source = get_turf(user),
		soundin = GLOB.pda_ringtone_sounds[preferences.read_preference(/datum/preference/choiced/pda_ringtone_sound)],
		vol = 90,
		vary = TRUE,
		frequency = null,
		falloff_exponent = 7,
		pressure_affected = FALSE,
		use_reverb = FALSE,
		// mixer_channel = CHANNEL_MACHINERY
	)
	COOLDOWN_START(src, ringtone_cooldown, 0.5 SECONDS)
	return TRUE

/datum/preference/choiced/pda_ringtone_sound/init_possible_values()
	return GLOB.pda_ringtone_sounds

/datum/preference/choiced/pda_ringtone_sound/create_default_value()
	return PDA_RINGTONE_SOUND_DEFAULT

// Returning false here because this pref is handled a little differently, due to its dependency on the existence of a PDA.
/datum/preference/choiced/pda_ringtone_sound/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

#undef PDA_RINGTONE_ALERT1
#undef PDA_RINGTONE_ALERT2
#undef PDA_RINGTONE_ALERT3
#undef PDA_RINGTONE_ALERT4
#undef PDA_RINGTONE_BELL
// #undef PDA_RINGTONE_BEEP
#undef PDA_RINGTONE_BUZZ
#undef PDA_RINGTONE_BYONDPAGER
#undef PDA_RINGTONE_BYONDPAGERDOWN
#undef PDA_RINGTONE_BIKEHORN
#undef PDA_RINGTONE_CHIME
#undef PDA_RINGTONE_CHORD1
#undef PDA_RINGTONE_CHORD2
#undef PDA_RINGTONE_CHORD3
#undef PDA_RINGTONE_CODEC
#undef PDA_RINGTONE_DING
#undef PDA_RINGTONE_HORN
#undef PDA_RINGTONE_MAUS
#undef PDA_RINGTONE_MEOW1
#undef PDA_RINGTONE_MEOW2
#undef PDA_RINGTONE_MEOW3
#undef PDA_RINGTONE_MEOW4
#undef PDA_RINGTONE_MEOW_ELECTRIC
#undef PDA_RINGTONE_MORSE
#undef PDA_RINGTONE_OHHIMARK
#undef PDA_RINGTONE_JINGLE
#undef PDA_RINGTONE_NORMALIZE
#undef PDA_RINGTONE_NOT_ALPHYS
#undef PDA_RINGTONE_PHONE_CHIME
#undef PDA_RINGTONE_PIANO
#undef PDA_RINGTONE_PING
#undef PDA_RINGTONE_SPEAKING
#undef PDA_RINGTONE_SPLAT
#undef PDA_RINGTONE_TARGET
#undef PDA_RINGTONE_TERMINAL_NOTIF1
#undef PDA_RINGTONE_WEH
