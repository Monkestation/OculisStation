/datum/looping_sound/call_ringtone
	volume = 50
	// channel = CHANNEL_RINGTONES
	sound_channel = CHANNEL_RINGTONES

/datum/looping_sound/call_ringtone/New(_parent, start_immediately, _direct, _skip_starting_sounds, _channel = CHANNEL_RINGTONES, ringtone = CALL_RINGTONE_SOUND_DEFAULT)
	set_ringtone(ringtone)
	. = ..()

/datum/looping_sound/call_ringtone/stop(null_parent)
	. = ..()
	// TODO: , mixer_channel = CHANNEL_RINGTONES
	playsound(get_turf(parent), sound(null), vol = 0, channel = CHANNEL_RINGTONES)

/datum/looping_sound/call_ringtone/proc/set_ringtone(ringtone = CALL_RINGTONE_SOUND_DEFAULT)
	var/list/ringtone_set = GLOB.call_ringtones[ringtone]
	mid_sounds = ringtone_set[CALL_RINGTONE_I_SOUNDFILE]
	mid_length = ringtone_set[CALL_RINGTONE_I_LENGTH]
	if(loop_started)
		stop()
		start()
