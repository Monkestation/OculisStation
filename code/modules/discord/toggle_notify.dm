/client
	COOLDOWN_DECLARE(notify_toggle_cooldown)

/// action must be one of PLEXORA_NOTIFYSIGNUP
/datum/controller/subsystem/plexora/proc/notify_signup(ckey, action)
	var/list/response = http_basicasync("notify_enroll", list(
		"ckey" = ckey(ckey),
		"action" = action
	), TRUE, TRUE)

	if (isnum(response))
		return response

	return response["result"]
/* IRIS EDIT REMOVAL - original:
// Verb to toggle restart notifications
/client/verb/notify_restart()
	set category = "OOC"
	set name = "Notify Restart"
	set desc = "Notifies you on Discord when the server restarts."

	// Safety checks
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(src, span_warning("This feature requires the SQL backend to be running."))
		return

	if(!SSdiscord) // SS is still starting
		to_chat(src, span_notice("The server is still starting up. Please wait before attempting to link your account "))
		return

	if(!SSdiscord.enabled)
		to_chat(src, span_warning("This feature requires the server is running on the TGS toolkit"))
		return

	var/stored_id = SSdiscord.lookup_id(usr.ckey)
	if(!stored_id) // Account is not linked
		to_chat(src, span_warning("This requires you to link your Discord account with the \"Link Discord Account\" verb."))
		return

	var/stored_mention = "<@[stored_id]>"
	for(var/member in SSdiscord.notify_members) // If they are in the list, take them out
		if(member == stored_mention)
			SSdiscord.notify_members -= stored_mention 
			to_chat(src, span_notice("You will no longer be notified when the server restarts"))
			return // This is necassary so it doesnt get added again, as it relies on the for loop being unsuccessful to tell us if they are in the list or not

	// If we got here, they arent in the list. Chuck 'em in!
	to_chat(src, span_notice("You will now be notified when the server restarts"))
	SSdiscord.notify_members += "[stored_mention]" 
*/

// IRIS EDIT ADDITION START
// Verb to toggle restart notifications
/client/verb/notify_restart()
	set category = "OOC"
	set name = "Notify Restart"
	set desc = "Notifies you on Discord when the server restarts."

	// Safety checks
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(src, span_warning("This feature requires the SQL backend to be running."))
		return

	if(!SSplexora) // SS is still starting
		to_chat(src, span_notice("The server is still starting up. Please wait before attempting to link your account "))
		return

	if(!CONFIG_GET(flag/plexora_enabled) || !SSplexora.enabled)
		to_chat(src, span_warning("This feature requires Plexora to be enabled."))
		return

	var/stored_id = SSplexora.lookup_id(ckey)
	if(!stored_id) // Account is not linked
		to_chat(src, span_warning("This requires you to link your Discord account with the \"Verify Discord Account\" verb."))
		return

	if (!COOLDOWN_FINISHED(src, notify_toggle_cooldown))
		to_chat(src, span_warning("Notify toggle on cooldown! ([COOLDOWN_TIMELEFT(src, notify_toggle_cooldown) * 0.1]s)"))
		return

	COOLDOWN_START(src, notify_toggle_cooldown, 5 SECONDS)

	var/result = SSplexora.notify_signup(ckey)

	if (!result)
		to_chat(src, span_warning("Failed to toggle your notify status!"))
		return

	if (isnum(result))
		if (result == 404)
			to_chat(src, "Plexora failed to find your Discord account. This actually shouldn't happen.")
		else if (result == 400)
			to_chat(src, "Plexora failed to give a proper response due to SSplexoras request. Make a ticket on the Discord")
		else
			to_chat(src, "Plexora gave an unexpected response ([result]). Uhm... Sorry, it shouldn't be this broken. Make a ticket on the Discord")
		return

	if (result == PLEXORA_NOTIFYSIGNUP_ENROLL)
		to_chat(src, span_notice("You will now be notified when the server restarts"))
	else if (result == PLEXORA_NOTIFYSIGNUP_UNENROLL)
		to_chat(src, span_notice("You will no longer be notified when the server restarts"))
	else
		to_chat(src, span_warning("Plexora gave unexpected response, and was unable to toggle your notify status"))
		stack_trace("Unexpected response for notify_signup, [result]")
// IRIS EDIT ADDITION END
