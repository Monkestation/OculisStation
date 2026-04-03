/datum/dynamic_ruleset/midround/from_living/heretic
	name = "Heretic"
	config_tag = "Midround Heretic"
	preview_antag_datum = /datum/antagonist/heretic
	midround_type = HEAVY_MIDROUND
	pref_flag = ROLE_FORBIDDENCALLING
	jobban_flag = ROLE_HERETIC
	// ruleset_flags = RULESET_VARIATION
	weight = 3
	min_pop = 25
	ruleset_lazy_templates = list(LAZY_TEMPLATE_KEY_HERETIC_SACRIFICE)
	blacklisted_roles = list(
		JOB_HEAD_OF_PERSONNEL,
	)

	/// Prevents can_be_selected from returning false after we've already started polling.
	var/locked_in = FALSE

/datum/dynamic_ruleset/midround/from_living/heretic/collect_candidates()
	var/list/candidates = ..()
	return poll_candidates_for_one(trim_candidates(candidates))

/datum/dynamic_ruleset/midround/from_living/heretic/proc/poll_candidates_for_one(list/candidates)
	locked_in = TRUE
	var/max_candidates = get_antag_cap(length(GLOB.alive_player_list), max_antag_cap || min_antag_cap)
	message_admins("[name]: Attempting to poll [length(candidates)] people individually, trying to select [max_candidates]")
	log_dynamic("[name]: Attempting to poll [length(candidates)] people individually, trying to select [max_candidates]")
	var/list/yes_candidates = list()
	var/sanity = max(5, length(candidates))
	while((length(yes_candidates) < max_candidates) && length(candidates) && sanity > 0)
		sanity--
		var/mob/living/candidate = pick_n_take(candidates)
		if(QDELETED(candidate) || candidate.stat == DEAD || !candidate.client)
			continue
		log_dynamic("[name]: Polling candidate [key_name(candidate)]")
		if(poll_for_heretic(candidate, yes_candidates))
			log_dynamic("[name]: Candidate [key_name(candidate)] has accepted being a Heretic")
		else
			log_dynamic("[name]: Candidate [key_name(candidate)] has declined to be a Heretic")

	log_dynamic("[name]: [length(yes_candidates)] candidates accepted")
	return yes_candidates

/datum/dynamic_ruleset/midround/from_living/heretic/proc/poll_for_heretic(mob/living/candidate, list/yes_candidates)
	var/list/response = SSpolling.poll_candidates(
		question = "Do you want to awaken to a forbidden calling (become a Heretic)?",
		group = list(candidate),
		poll_time = 15 SECONDS,
		flash_window = TRUE,
		start_signed_up = FALSE,
		announce_chosen = FALSE,
		role_name_text = "Forbidden Calling (Heretics)",
		alert_pic = /obj/item/codex_cicatrix,
		custom_response_messages = list(
			POLL_RESPONSE_SIGNUP = "You have signed up to be a heretic!",
			POLL_RESPONSE_ALREADY_SIGNED = "You are already signed up to be a heretic.",
			POLL_RESPONSE_NOT_SIGNED = "You aren't signed up to be a heretic.",
			POLL_RESPONSE_TOO_LATE_TO_UNREGISTER = "It's too late to decide against being a heretic.",
			POLL_RESPONSE_UNREGISTERED = "You decide against being a heretic.",
		),
		chat_text_border_icon = /obj/item/codex_cicatrix,
	)
	if(response)
		yes_candidates += response
		return TRUE
	else
		return FALSE

/datum/dynamic_ruleset/midround/from_living/heretic/assign_role(datum/mind/candidate)
	give_midround_heretic_with_bonus_points(candidate)

/datum/dynamic_ruleset/midround/from_living/heretic/execute()
	. = ..()
	locked_in = FALSE

/datum/dynamic_ruleset/midround/from_living/heretic/can_be_selected()
	return locked_in || ensure_job_spread_for_heretics()
