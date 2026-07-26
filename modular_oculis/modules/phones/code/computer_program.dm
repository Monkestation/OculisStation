/datum/computer_file/program/phone_call
	filetype = "PRG"
	/// File name. FILE NAME MUST BE UNIQUE IF YOU WANT THE PROGRAM TO BE DOWNLOADABLE FROM NTNET!
	filename = "phone_call_program"
	can_run_on_flags = PROGRAM_LAPTOP | PROGRAM_PDA
	program_flags = PROGRAM_REQUIRES_NTNET
	tgui_id = "phone_call_program"
	program_icon = FA_ICON_COMMENT_ALT
	alert_able = TRUE
	// Cooldown for the phone call sound.
	COOLDOWN_DECLARE(ringer_cooldown)
	// Contacts the phone has saved.
	var/list/contacts = list()
	// Contacts the phone has blocked.
	var/list/blocked_contacts = list()
	// The phone history of the phone.
	var/list/phone_history_list = list()
	// Phone flags, for things like if its open or if it has no sim card.
	var/phone_flags = NONE
	// The phone's current state.
	VAR_PRIVATE/current_state = PHONE_AVAILABLE
	// The number the phone has dialed.
	var/dialed_number
	// The frequency in use for a phone call.
	var/secure_frequency
	// Current sound to play when the phone is ringing.
	var/call_sound = 'modular_oculis/modules/phones/sounds/call.ogg'
	// If the phone should play a sound when ringing.
	var/ringer = TRUE
	// If the phone shows balloon alerts when ringing.
	var/vibration = TRUE
	// If the phone's microphone is muted.
	var/muted = FALSE
	// ID of the timer that the phone uses for ringing. Deleted once the user denies a phone call or misses it.
	var/phone_ringing_timer = null
	// The phone number of the phone calling us. If any.
	var/incoming_phone_number = null

	/// A list of associative lists with three indeces: NETWORK_ID, OUR_ROLE and USE_JOB_TITLE. So that contact_networks is populated on init.
	var/list/contact_networks_pre_init = null
	/// A list of contact networks to be added in. Order matters, as if members overlap they will only get the first contact.
	var/list/contact_networks = null
	var/important_contact_of = null


/datum/computer_file/program/phone_call/ui_data(mob/living/user)
	var/list/data = list()
	data["my_number"] = computer.sim_card ? computer.sim_card.phone_number : "No SIM card inserted."
	data["no_sim_card"] = (phone_flags & PHONE_NO_SIM) ? TRUE : FALSE
	data["phone_in_call"] = (current_state == PHONE_IN_CALL) ? TRUE : FALSE
	data["phone_ringing"] = (current_state == PHONE_RINGING) ? TRUE : FALSE
	data["phone_calling"] = (current_state == PHONE_CALLING) ? TRUE : FALSE
	data["ringer"] = ringer
	data["vibration"] = vibration
	data["speaker_mode"] = (computer.phone_radio.canhear_range == 3) ? TRUE : FALSE
	data["muted"] = muted

	var/list/our_contacts = list()
	for(var/datum/phonecontact/contact in contacts)
		UNTYPED_LIST_ADD(our_contacts, list(
			"name" = contact.name,
			"number" = contact.number,
		))
	our_contacts = sort_list(our_contacts)
	data["our_contacts"] = our_contacts

	var/list/our_blocked_contacts = list()
	for(var/datum/phonecontact/contact in blocked_contacts)
		UNTYPED_LIST_ADD(our_blocked_contacts, list(
			"name" = contact.name,
			"number" = contact.number,
		))
	our_blocked_contacts = sort_list(our_blocked_contacts)
	data["our_blocked_contacts"] = our_blocked_contacts

	var/list/phone_history = list()
	for(var/datum/phone_history/PH in phone_history_list)
		UNTYPED_LIST_ADD(phone_history, list(
			"type" = PH.call_type,
			"type_tooltip" = PH.call_type_tooltip,
			"name" = PH.name,
			"number" = PH.number,
			"time" = PH.time
		))
	data["phone_history"] = phone_history

	var/calling_user = incoming_phone_number ? incoming_phone_number : dialed_number
	if(calling_user)
		data["calling_user"] = get_number_contact_name(calling_user)
	else
		data["calling_user"] = ""
	return data

/datum/computer_file/program/phone_call/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	switch(action)
		if("call")
			start_phone_call(usr, params["number"])
			log_phone("[key_name(usr)] called [params["number"]].")
			return TRUE

		if("hang")
			if(current_state == PHONE_IN_CALL)
				end_phone_call()
			else
				hang_up_phone_call(dialed_number)
			return TRUE

		if("accept")
			accept_phone_call(usr)
			log_phone("[key_name(usr)] answered a phone call.")
			return TRUE

		if("decline")
			decline_phone_call()
			log_phone("[key_name(usr)] declined a phone call.")
			return TRUE

		if("add_contact")
			var/number = tgui_input_text(usr, "Input number", "Add Contact")
			if(length(number) > 15)
				to_chat(usr, span_danger("Entered number is too long"))
				return FALSE
			var/stripped_number = replacetext(number, " ", "") // remove spaces
			var/new_contact_name = tgui_input_text(usr, "Input name", "Add Contact")
			if(!new_contact_name || !number)
				to_chat(usr, span_danger("You must provide both a name and a number."))
				return FALSE

			var/datum/phonecontact/new_contact = new()
			new_contact.number = "[stripped_number]"
			new_contact.name = "[new_contact_name]"
			contacts += new_contact
			log_phone("[key_name(usr)] added a new contact: [new_contact_name] ([stripped_number])")
			return TRUE

		if("remove_contact")
			var/number = tgui_input_text(usr, "Input number", "Remove Contact")
			if(length(number) > 15)
				to_chat(usr, span_danger("Entered number is too long"))
				return FALSE
			for(var/datum/phonecontact/contact in contacts)
				if(contact.number == number)
					contacts -= contact
					log_phone("[key_name(usr)] removed a contact with number: [number]")
					return TRUE
			return FALSE

		if("block")
			var/block_number = tgui_input_text(usr, "Input number to block", "Block Contact")
			if(!block_number)
				to_chat(usr, span_warning("You must provide a number."))
				return FALSE
			if(length(block_number) > 15)
				to_chat(usr, span_warning("Invalid number."))
				return FALSE

			var/datum/phonecontact/blocked_contact = new()
			block_number = replacetext(block_number, " ", "")
			blocked_contact.number = "[block_number]"
			blocked_contact.name = "Blocked [length(blocked_contacts)+1]"
			blocked_contacts += blocked_contact
			return TRUE

		if("unblock")
			var/result = tgui_input_text(usr, "Input number to unblock", "Unblock Contact")
			if(!result)
				to_chat(usr, span_warning("You must provide a number."))
				return FALSE
			for(var/datum/phonecontact/unblocked_contact in blocked_contacts)
				if(unblocked_contact.name == result)
					blocked_contacts -= unblocked_contact
					return TRUE
			return FALSE

		if("delete_call_history")
			if(!length(phone_history_list))
				to_chat(usr, span_danger("You have no call history to delete."))
				return FALSE

			to_chat(usr, "Your total amount of history saved is: [length(phone_history_list)]")
			var/number_of_deletions = tgui_input_number(usr, "Input the amount that you want to delete", "Deletion Amount", max_value = length(phone_history_list))
			if(!number_of_deletions)
				return FALSE

			//Delete the call history depending on the amount inputed by the User
			if(number_of_deletions > length(phone_history_list))
				//Verify if the requested amount in bigger than the history list.
				to_chat(usr, "You cannot delete more items than the history contains.")
				return FALSE
			else
				for(var/i in 1 to number_of_deletions)
					//It will always delete the first item of the list, so the last logs are deleted first
					var/item_to_remove = phone_history_list[1]
					phone_history_list -= item_to_remove
			to_chat(usr, "[number_of_deletions] call history entries were deleted. Remaining: [length(phone_history_list)]")
			return TRUE

		if("terminal_sound")
			if(ringer)
				playsound(computer.loc, 'sound/machines/terminal/terminal_select.ogg', 15, TRUE)
			return TRUE

		if("silent")
			ringer = !ringer
			computer.balloon_alert(usr, "ringer [ringer ? "on" : "off"]!")
			return TRUE

		if("vibration")
			vibration = !vibration
			computer.balloon_alert(usr, "vibration [vibration ? "on" : "off"]!")
			return TRUE

		if("speaker")
			if(computer.phone_radio.canhear_range == 1)
				computer.phone_radio.canhear_range = 3
				computer.balloon_alert(usr, "speaker on!")
			else
				computer.phone_radio.canhear_range = 1
				computer.balloon_alert(usr, "speaker off!")
			return TRUE

		if("mute")
			muted = !muted
			computer.phone_radio.set_listening(!muted)
			computer.balloon_alert(usr, "[muted ? "muted" : "unmuted"]!")

	return FALSE

// Updates the phone's contacts, for when a new contact joins the game.
/datum/computer_file/program/phone_call/proc/update_contacts()
	for(var/datum/contact_network/contact_network as anything in contact_networks)
		for(var/datum/contact/our_contact in contact_network.contacts)
			if(our_contact.number == computer.sim_card.phone_number)
				continue

			var/already_in_contact = FALSE
			for(var/datum/phonecontact/phone_contact as anything in contacts)
				if(our_contact.number == phone_contact.number)
					already_in_contact = TRUE
					break
			if(already_in_contact)
				continue

			var/contact_name = "[our_contact.name] - [our_contact.role]"
			var/new_phone_contact = new /datum/phonecontact(contact_name, our_contact.number)
			contacts |= new_phone_contact

// Gets the displayed contact's name if they are in contacts or published. If not, show the number.
/datum/computer_file/program/phone_call/proc/get_number_contact_name(contact_num)
	var/output_user
	if(!contact_num)
		CRASH("Trying to get a contact number with a bad input.")

	// Default to the contact name calling the phone.
	for(var/datum/phonecontact/contact in contacts)
		if(contact.number == contact_num)
			output_user = contact.name
	// Not in our contacts or published listings? Then resolve to showing the phone number.
	if(!output_user)
		output_user = "+" + contact_num
	return output_user

// Helper proc to add a history log to the phone's records.
/datum/computer_file/program/phone_call/proc/add_phone_call_history(call_type, call_type_tooltip)
	var/datum/phone_history/new_contact = new()
	var/caller_num = dialed_number ? dialed_number : incoming_phone_number
	new_contact.name = get_number_contact_name(caller_num)
	new_contact.number = caller_num
	new_contact.call_type = call_type
	new_contact.call_type_tooltip = call_type_tooltip
	new_contact.time = server_timestamp("hh:mm:ss", ic_time = TRUE)
	phone_history_list += new_contact

/datum/computer_file/program/phone_call/proc/set_phone_state(new_state)
	if(current_state == new_state)
		return
	current_state = new_state

	if(current_state == PHONE_AVAILABLE)
		dialed_number = null
		incoming_phone_number = null
	if(current_state == PHONE_RINGING)
		START_PROCESSING(SSprocessing, src)
		if(ringer)
			computer.setup_particles()

	if(current_state == PHONE_IN_CALL || current_state == PHONE_AVAILABLE)
		if(phone_ringing_timer)
			deltimer(phone_ringing_timer)
		if(computer.particle_generator)
			QDEL_NULL(computer.particle_generator)
		STOP_PROCESSING(SSprocessing, src)

/datum/computer_file/program/phone_call/proc/check_missing_sim_card(mob/user)
	if(phone_flags & PHONE_NO_SIM)
		computer.balloon_alert(user, "no SIM!")
		return TRUE
	return FALSE

/datum/computer_file/program/phone_call/proc/check_phone_busy(mob/user, datum/computer_file/program/phone_call/calling_smartphone)
	if(calling_smartphone.current_state > PHONE_AVAILABLE)
		computer.balloon_alert(user, "busy!")
		return TRUE
	if(calling_smartphone.computer.sim_card?.phone_number == computer.sim_card?.phone_number)
		computer.balloon_alert(user, "busy!")
		return TRUE
	return FALSE

///////////////////////////////////////////////////////////////////////////////////////////////////////////

// Used for when the calling phone starts a phone call.
/datum/computer_file/program/phone_call/proc/start_phone_call(mob/user, called_phone_number)
	if(check_missing_sim_card(user))
		return

	var/datum/computer_file/program/phone_call/calling_smartphone = SSphones.get_phone_from_number(called_phone_number)
	if(!calling_smartphone)
		return
	if(check_phone_busy(user, calling_smartphone))
		return
	dialed_number = called_phone_number
	calling_smartphone.incoming_phone_number = computer.sim_card.phone_number
	calling_smartphone.receive_phone_call()
	phone_ringing_timer = addtimer(CALLBACK(src, PROC_REF(set_phone_available)), TIME_TO_RING, TIMER_STOPPABLE | TIMER_DELETE_ME)
	add_phone_call_history(PHONE_CALL_SENT, PHONE_CALL_SENT_TOOLTIP)
	set_phone_state(PHONE_CALLING)

// Used for when the receiving phone picks up a phone call.
/datum/computer_file/program/phone_call/proc/accept_phone_call(mob/user)
	if(check_missing_sim_card(user))
		return
	add_phone_call_history(PHONE_CALL_ACCEPTED, PHONE_CALL_ACCEPTED_TOOLTIP)
	establish_call_connection(incoming_phone_number)

// Used for when the receiving phone declines a phone call.
/datum/computer_file/program/phone_call/proc/decline_phone_call()
	add_phone_call_history(PHONE_CALL_DECLINED, PHONE_CALL_DECLINED_TOOLTIP)
	terminate_call_connection()

// Used for when the receiving phone or the calling phone end the phone call after it has started.
/datum/computer_file/program/phone_call/proc/end_phone_call()
	add_phone_call_history(PHONE_CALL_ENDED, PHONE_CALL_ENDED_TOOLTIP)
	terminate_call_connection()

// Used for when the calling phone ends the phone call before the receiving phone picks up.
/datum/computer_file/program/phone_call/proc/hang_up_phone_call(called_phone_number)
	set_phone_state(PHONE_AVAILABLE)
	var/datum/computer_file/program/phone_call/calling_smartphone = SSphones.get_phone_from_number(called_phone_number)
	if(!calling_smartphone)
		return
	calling_smartphone.miss_phone_call()

// Used for when the receiving phone gets a notification that they are being called by incoming_phone_number.
/datum/computer_file/program/phone_call/proc/receive_phone_call()
	set_phone_state(PHONE_RINGING)
	phone_ringing_timer = addtimer(CALLBACK(src, PROC_REF(miss_phone_call)), TIME_TO_RING, TIMER_STOPPABLE | TIMER_DELETE_ME)
	add_phone_call_history(PHONE_CALL_RECEIVED, PHONE_CALL_RECEIVED_TOOLTIP)

// Used for when the receiving phone fails to pick up the phone call in time.
/datum/computer_file/program/phone_call/proc/miss_phone_call()
	add_phone_call_history(PHONE_CALL_MISSED, PHONE_CALL_MISSED_TOOLTIP)
	set_phone_state(PHONE_AVAILABLE)

// General purpose failsafe of setting it to its proper state.
/datum/computer_file/program/phone_call/proc/set_phone_available()
	set_phone_state(PHONE_AVAILABLE)

#define VIBRATION_LOOP_DURATION (1 SECONDS)

// Only used to indicate to the receiving phone that they are being called.
/datum/computer_file/program/phone_call/process(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, ringer_cooldown))
		return
	COOLDOWN_START(src, ringer_cooldown, 4 SECONDS)
	if(vibration)
		animate(src, pixel_w = 1, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
		for(var/i in 1 to VIBRATION_LOOP_DURATION / (0.2 SECONDS)) //desired total duration divided by the iteration duration to give the necessary iteration count
			animate(pixel_w = -2, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_CONTINUE)
			animate(pixel_w = 2, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_CONTINUE)
		animate(pixel_w = -1, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE)
		computer.balloon_alert_to_viewers(pick("zzZz!", "ZZZT!", "zZzZ!", "Zzz...", "zzZ...", "ZzZZT!"), vision_distance = COMBAT_MESSAGE_RANGE)
	if(ringer)
		playsound(src, call_sound, 50, TRUE, 0, 2)

// App really ought to be a datum. Whateverrrrr
/datum/computer_file/program/phone_call/proc/receive_notification(app, title, body)
	if(vibration)
		animate(src, pixel_w = 1, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
		for(var/i in 1 to VIBRATION_LOOP_DURATION / (0.2 SECONDS)) //desired total duration divided by the iteration duration to give the necessary iteration count
			animate(pixel_w = -2, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_CONTINUE)
			animate(pixel_w = 2, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_CONTINUE)
		animate(pixel_w = -1, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE)
	if(ringer)
		playsound(src, 'modular_oculis/modules/phones/sounds/text_receive.ogg', 50, TRUE, 0, 2) // This could prob use a better notification
	computer.balloon_alert_to_viewers("[app]:[title]", vision_distance = SAMETILE_MESSAGE_RANGE)

#undef VIBRATION_LOOP_DURATION

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Internal only proc, used for establlishing a call connection.
/datum/computer_file/program/phone_call/proc/establish_call_connection()
	PROTECTED_PROC(TRUE)

	var/datum/computer_file/program/phone_call/calling_smartphone = SSphones.get_phone_from_number(incoming_phone_number)
	if(!calling_smartphone)
		return

	// Establish a secure connection.
	secure_frequency = SSphones.establish_secure_frequency()
	calling_smartphone.secure_frequency = secure_frequency

	// Set the phone radios.
	set_phone_radio(TRUE)
	calling_smartphone.set_phone_radio(TRUE)

	// Set proper phone state.
	set_phone_state(PHONE_IN_CALL)
	calling_smartphone.set_phone_state(PHONE_IN_CALL)

	computer.phone_radio.canhear_range = 1
	calling_smartphone.computer.phone_radio.canhear_range = 1
	muted = FALSE
	calling_smartphone.muted = FALSE

// Internal only proc, used for ending a calll connection.
/datum/computer_file/program/phone_call/proc/terminate_call_connection()
	PROTECTED_PROC(TRUE)

	var/datum/computer_file/program/phone_call/calling_smartphone = SSphones.get_phone_from_number(incoming_phone_number)
	if(!calling_smartphone)
		calling_smartphone = SSphones.get_phone_from_number(dialed_number)
	if(!calling_smartphone)
		return

	// Free up the secure connection.
	SSphones.free_secure_frequency(secure_frequency)
	secure_frequency = null
	calling_smartphone.secure_frequency = null

	// Set the phone radios.
	set_phone_radio(FALSE)
	calling_smartphone.set_phone_radio(FALSE)

	// Set proper phone state.
	set_phone_state(PHONE_AVAILABLE)
	calling_smartphone.set_phone_state(PHONE_AVAILABLE)

// Internal only proc, used for setting a phone's internal radio.
/datum/computer_file/program/phone_call/proc/set_phone_radio(enabled)
	PROTECTED_PROC(TRUE)

	if(enabled)
		computer.phone_radio.set_frequency(secure_frequency)
		computer.phone_radio.set_broadcasting(TRUE)
		computer.phone_radio.set_listening(TRUE)
	else
		computer.phone_radio.set_frequency(0)
		computer.phone_radio.set_broadcasting(FALSE)
		computer.phone_radio.set_listening(FALSE)
	computer.phone_radio.recalculateChannels()

