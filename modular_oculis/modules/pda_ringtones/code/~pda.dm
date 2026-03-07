
/datum/computer_file/program/messenger
	/// Cooldown for changing ringtone sound
	COOLDOWN_DECLARE(ringtone_set_cooldown)
	/// The sound file to play when receiving a message
	var/ringtone_sound = PDA_RINGTONE_SOUND_DEFAULT

/// A simple proc to set the ringtone sound
/obj/item/modular_computer/pda/proc/update_ringtone_sound(new_sound)
	if(!istext(new_sound) || !(new_sound in GLOB.pda_ringtone_sounds))
		return
	var/datum/computer_file/program/messenger/messenger_app = locate() in stored_files
	if(messenger_app)
		messenger_app.ringtone_sound = new_sound

/datum/computer_file/program/messenger/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	switch(action)
		if("PDA_soundSet")
			var/new_sound = params["sound"]
			if(!(new_sound in GLOB.pda_ringtone_sounds))
				return FALSE

			ringtone_sound = new_sound

			// Plays a preview of the sound selected
			var/mob/living/usr_mob = usr
			if(in_range(computer, usr_mob) && COOLDOWN_FINISHED(src, ringtone_set_cooldown))
				// TODO: mixer_channel = CHANNEL_RINGTONES, when mixer panel added.
				playsound(computer, GLOB.pda_ringtone_sounds[new_sound], 30, TRUE, extrarange = - 4)
				COOLDOWN_START(src, ringtone_set_cooldown, 1 SECONDS)

			return TRUE


/datum/computer_file/program/messenger/ui_data(mob/user)
	. = ..()
	.["ringtone_sound"] = ringtone_sound
	.["available_sounds"] = list()
	for(var/sound_name in GLOB.pda_ringtone_sounds)
		.["available_sounds"] += sound_name
