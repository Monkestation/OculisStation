/datum/keybinding/client/communication/do_emote
	hotkey_keys = list("K")
	name = DO_CHANNEL
	full_name = "Do"
	keybind_signal = COMSIG_KB_CLIENT_DO_DOWN

/datum/keybinding/client/communication/do_emote/down(client/user)
	. = ..()
	if(.)
		return
	DEFAULT_QUEUE_OR_CALL_VERB(VERB_CALLBACK(user.mob, TYPE_PROC_REF(/mob, emote), "do_emote"))
	return TRUE

/mob/verb/do_verb()
	set name = "Do"
	set category = "IC"
	if(GLOB.say_disabled) // This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return
	DEFAULT_QUEUE_OR_CALL_VERB(VERB_CALLBACK(src, PROC_REF(emote), "do_emote"), SSspeech_controller)

/datum/emote/living/do_emote
	key = "do_emote"
	key_third_person = "do_emote"
	message = null
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/do_emote/run_emote(mob/user, params, type_override, intentional)
	if(!can_run_emote(user))
		to_chat(user, span_warning("You can't emote at this time."))
		return FALSE
	if(SSdbcore.IsConnected() && is_banned_from(user, "Emote"))
		to_chat(user, span_warning("You cannot send emotes (banned)."))
		return FALSE
	else if(user.client?.prefs.muted & MUTE_IC)
		to_chat(user, span_warning("You cannot send IC messages (muted)."))
		return FALSE

	var/message = tgui_input_text(user, "Write your do emote.", "Do Emote", null, max_length = MAX_MESSAGE_LEN, multiline = TRUE)
	if (!message)
		return

	if (!user.try_speak(message, mute_bypass = TRUE)) // ensure we pass the vibe check (filters, etc)
		return

	var/name_stub = " (<b>[user.name]</b>)"
	message = trim(copytext_char(message, 1, (MAX_MESSAGE_LEN - length(name_stub))))
	var/message_with_name = message + name_stub

	user.log_message(message, LOG_EMOTE)

	var/list/viewers = get_hearers_in_view(DEFAULT_MESSAGE_RANGE, user)

	for(var/mob/ghost as anything in GLOB.dead_mob_list)
		name_stub = " (<b>[GET_GUESTBOOK_NAME(ghost, user)]</b>)"
		message_with_name = message + name_stub
		if((ghost.client?.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(ghost in viewers))
			to_chat(ghost, "[FOLLOW_LINK(ghost, user)] [span_emote(message_with_name)]")

	for(var/mob/reciever in viewers)
		name_stub = " (<b>[GET_GUESTBOOK_NAME(reciever, user)]</b>)"
		message_with_name = message + name_stub
		reciever.show_message(span_emote(message_with_name), alt_msg = span_emote(message_with_name))
		if (reciever.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
			reciever.create_chat_message(user, null, message, null, EMOTE_MESSAGE)
