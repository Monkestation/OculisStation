// LOOC Module
GLOBAL_VAR_INIT(looc_allowed, TRUE)

/datum/config_entry/number/rockplanet_budget
	config_entry_value = 60
	integer = FALSE
	min_val = 0

/datum/config_entry/string/servertagline
	config_entry_value = "We forgot to set the server's tagline in config.txt"

/datum/config_entry/string/discord_link
	config_entry_value = "We forgot to set the server's discord link in config.txt"

/datum/config_entry/string/icecats_policy_link
	config_entry_value = "(It appears we have forgotten to set this link)" // "in config.txt" but the players don't need to see that


/datum/config_entry/flag/events_use_random

/datum/config_entry/flag/events_public_voting

/datum/config_entry/flag/log_event_votes

/datum/config_entry/flag/low_chaos_event_system

/datum/config_entry/flag/allow_consecutive_catastropic_events
/// Upper value for random events at highpop.
/datum/config_entry/number/event_frequency_upper
	default = 14 MINUTES
/// Lower value for random events at highpop.
/datum/config_entry/number/event_frequency_lower
	default = 7 MINUTES
/// Rate at which high intensity random events are limited to occur.
/datum/config_entry/number/intensity_credit_rate
	default = 45 MINUTES

/datum/config_entry/flag/admin_event_uses_chaos

/// Ticket ping frequency. Set 0 for disable that subsystem. 3000 - 5 minutes, 600 - 1 minute.
/datum/config_entry/number/ticket_ping_frequency

/datum/config_entry/number/size_collar_maximum
	default = 400

/datum/config_entry/number/size_collar_minimum
	default = 15

// Minimum alert level for pods to actually evacuate people
/datum/config_entry/number/minimum_alert_for_pods

// How much time arrivals shuttle should stay at station after its engines recharged before returning to interlink. In deciseconds. 150 - 15 seconds. 0 - disables autoreturn
/datum/config_entry/number/arrivals_wait

// Are borgs/silicons blacklisted from entering the gateway
/datum/config_entry/flag/borg_gateway_blacklist
