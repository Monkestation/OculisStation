/datum/preference/name/pai
	savefile_key = "pai_name"

	allow_numbers = TRUE
	explanation = "pAI name"
	group = "silicons"
	relevant_job = /datum/job/pai

/datum/preference/name/pai/create_default_value()
	return pick(GLOB.ai_names)
