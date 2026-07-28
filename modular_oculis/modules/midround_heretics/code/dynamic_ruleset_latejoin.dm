/datum/dynamic_ruleset/latejoin/heretic
	name = "Heretic"
	config_tag = "Latejoin Heretic"
	preview_antag_datum = /datum/antagonist/heretic
	pref_flag = ROLE_HERETIC_SMUGGLER
	jobban_flag = ROLE_HERETIC
	weight = 3
	min_pop = 25 // Ensures good spread of sacrifice targets
	ruleset_lazy_templates = list(LAZY_TEMPLATE_KEY_HERETIC_SACRIFICE)
	blacklisted_roles = list(
		JOB_HEAD_OF_PERSONNEL,
	)

/datum/dynamic_ruleset/latejoin/heretic/assign_role(datum/mind/candidate)
	give_midround_heretic_with_bonus_points(candidate)

/datum/dynamic_ruleset/latejoin/heretic/can_be_selected()
	return ensure_job_spread_for_heretics()
