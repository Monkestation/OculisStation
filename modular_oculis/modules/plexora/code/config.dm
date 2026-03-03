/datum/config_entry/flag/plexora_enabled

/datum/config_entry/string/plexora_url
	default = "http://127.0.0.1:1330"

/datum/config_entry/string/plexora_url/ValidateAndSet(str_val)
	if(!is_http_protocol(str_val))
		return FALSE
	return ..()

/datum/config_entry/flag/require_discord_verification

// Role ID to check if a user has in order for them to be let in.
/datum/config_entry/string/plexora_verification_required_roleid

// If enabled, allows mentors and admins to bypass verification.
/datum/config_entry/flag/plexora_verification_whitelist_staff
	protection = CONFIG_ENTRY_LOCKED
