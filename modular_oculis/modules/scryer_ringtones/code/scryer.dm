// note: see /datum/station_trait/scryers/proc/on_job_after_spawn for ringtone selection
// and /datum/loadout_item/neck/modlink/post_equip_item

// defines in code/__DEFINES/~~oculis_defines/scryer.dm

// (soundfile, soundlength)
GLOBAL_LIST_INIT(call_ringtones, list(
	CALL_RINGTONE_ALLSTAR = list('modular_oculis/modules/scryer_ringtones/sound/allstar.ogg', 14.7 SECONDS),
	CALL_RINGTONE_BIGSHOT = list('modular_oculis/modules/scryer_ringtones/sound/bigshot.ogg', 21.1 SECONDS),
	CALL_RINGTONE_BADAPPLE = list('modular_oculis/modules/scryer_ringtones/sound/bad_apple.ogg', 21.1 SECONDS),
	CALL_RINGTONE_BONETROUSLE = list('modular_oculis/modules/scryer_ringtones/sound/bonetrousle.ogg', 20 SECONDS),
	CALL_RINGTONE_CATS = list('modular_oculis/modules/scryer_ringtones/sound/cats.ogg', 28 SECONDS),
	CALL_RINGTONE_COFFEE_SHOP = list('modular_oculis/modules/scryer_ringtones/sound/coffee_shop_in_yume.ogg', 19.2 SECONDS),
	CALL_RINGTONE_FLIP_FLAP = list('modular_oculis/modules/scryer_ringtones/sound/flip_flap.ogg', 18 SECONDS),
	CALL_RINGTONE_GRASS_SPACE = list('modular_oculis/modules/scryer_ringtones/sound/grass_space_chase.ogg', 15.7 SECONDS),
	CALL_RINGTONE_HALL_OF_MOUNTAIN_KING = list('modular_oculis/modules/scryer_ringtones/sound/hall_of_the_mountain_king.ogg', 19.4 SECONDS),
	CALL_RINGTONE_LANCER = list('modular_oculis/modules/scryer_ringtones/sound/lancer.ogg', 20.3 SECONDS),
	CALL_RINGTONE_SPIDER_DANCE = list('modular_oculis/modules/scryer_ringtones/sound/spider_dance.ogg', 16.1 SECONDS),
	CALL_RINGTONE_STYAOS = list('modular_oculis/modules/scryer_ringtones/sound/trillion_years_overnight_story.ogg', 11.9 SECONDS),
	CALL_RINGTONE_THIRD_SANCTUARY = list('modular_oculis/modules/scryer_ringtones/sound/third_sanctuary.ogg', 12.7 SECONDS),
	CALL_RINGTONE_YUMENO = list('modular_oculis/modules/scryer_ringtones/sound/yu_me_no.ogg', 28.2 SECONDS),
))


/datum/preference/choiced/call_ringtone
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "call_ringtone"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference_middleware/call_ringtone
	COOLDOWN_DECLARE(ringtone_cooldown)
	action_delegations = list(
		"play_call_ringtone_sound" = PROC_REF(play_call_ringtone_sound),
		"stop_call_ringtone_sound" = PROC_REF(stop_call_ringtone_sound)
	)

/datum/preference_middleware/call_ringtone/proc/play_call_ringtone_sound(list/params, mob/user)
	if(!COOLDOWN_FINISHED(src, ringtone_cooldown))
		return
	user.playsound_local(
		get_turf(user),
		sound_to_use = sound(GLOB.call_ringtones[preferences.read_preference(/datum/preference/choiced/call_ringtone)][CALL_RINGTONE_I_SOUNDFILE]),
		vol = 90,
		vary = FALSE,
		use_reverb = FALSE,
		pressure_affected = FALSE,
		channel = CHANNEL_RINGTONES,
		// mixer_channel = CHANNEL_RINGTONES
	)
	COOLDOWN_START(src, ringtone_cooldown, 0.5 SECONDS)

/datum/preference_middleware/call_ringtone/proc/stop_call_ringtone_sound(list/params, mob/user)
	SEND_SOUND(user, sound(null, channel = CHANNEL_RINGTONES, repeat = 0, wait = 0))

/datum/preference/choiced/call_ringtone/init_possible_values()
	return GLOB.call_ringtones

/datum/preference/choiced/call_ringtone/create_default_value()
	return CALL_RINGTONE_SOUND_DEFAULT

/datum/preference/choiced/call_ringtone/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
