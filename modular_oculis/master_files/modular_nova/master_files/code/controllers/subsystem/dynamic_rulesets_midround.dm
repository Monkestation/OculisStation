/datum/dynamic_ruleset/midround/from_living/traitor/collect_candidates()
	var/list/candidates = ..()
	return poll_candidates_for_one(trim_candidates(candidates))

/datum/dynamic_ruleset/midround/from_living/traitor/proc/poll_candidates_for_one(list/candidates)
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
		if(poll_for_traitor(candidate, yes_candidates))
			log_dynamic("[name]: Candidate [key_name(candidate)] has accepted being a Sleeper Agent")
		else
			log_dynamic("[name]: Candidate [key_name(candidate)] has declined to be a Sleeper Agent")

	log_dynamic("[name]: [length(yes_candidates)] candidates accepted")
	return yes_candidates

/datum/dynamic_ruleset/midround/from_living/traitor/proc/poll_for_traitor(mob/living/candidate, list/yes_candidates)
	var/list/response = SSpolling.poll_candidates(
		question = "Do you want to be syndicate sleeper agent?",
		group = list(candidate),
		poll_time = 15 SECONDS,
		flash_window = TRUE,
		start_signed_up = FALSE,
		announce_chosen = FALSE,
		role_name_text = "Sleeper Agent",
		alert_pic = /obj/structure/sign/poster/contraband/gorlex_recruitment,
		custom_response_messages = list(
			POLL_RESPONSE_SIGNUP = "You have signed up to be a traitor!",
			POLL_RESPONSE_ALREADY_SIGNED = "You are already signed up to be a traitor.",
			POLL_RESPONSE_NOT_SIGNED = "You aren't signed up to be a traitor.",
			POLL_RESPONSE_TOO_LATE_TO_UNREGISTER = "It's too late to decide against being a traitor.",
			POLL_RESPONSE_UNREGISTERED = "You decide against being a traitor.",
		),
		chat_text_border_icon = /obj/structure/sign/poster/contraband/gorlex_recruitment,
	)
	if(response)
		yes_candidates += response
		return TRUE
	else
		return FALSE
