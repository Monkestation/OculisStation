#define NO_ADMINS_ONLINE_MESSAGE "Adminhelps are also sent through TGS to services like IRC and Discord. If no admins are available in game, sending an adminhelp might still be noticed and responded to."

/client
	/// Number of times this client has adminwho'd since the last logging cooldown
	var/awho_count_since = 0
	COOLDOWN_DECLARE(adminwho_alert_cooldown)

GAME_VERB(/client, adminwho, "Adminwho", "Admin")
	var/list/lines = list()
	var/payload_string = generate_adminwho_string()
	var/header = (payload_string == NO_ADMINS_ONLINE_MESSAGE) ? "No Admins Currently Online" : "Current Admins"

	lines += span_bold(header)
	lines += payload_string

	to_chat(src, fieldset_block(span_bold(header), jointext(lines, "\n"), "boxed_message"), type = MESSAGE_TYPE_INFO)

	if(COOLDOWN_FINISHED(src, adminwho_alert_cooldown) && !is_admin(src))
		var/laststring = "has checked adminwho."
		if(awho_count_since > 0)
			laststring += " ([awho_count_since] checks since last cooldown)"
		awho_count_since = 0
		message_admins("[ADMIN_STEALTHLOOKUPFLW(mob)] [laststring]")
		log_admin_private("[key_name(src)] [laststring]")
		COOLDOWN_START(src, adminwho_alert_cooldown, 1 MINUTES)

	awho_count_since++

#undef NO_ADMINS_ONLINE_MESSAGE
