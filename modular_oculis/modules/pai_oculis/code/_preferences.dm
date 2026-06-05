// Things related to pAI character preferences stored here

GLOBAL_LIST_INIT(pai_chassis, sort_list(list(
	"bat",
	"bee",
	"butterfly",
	"carp",
	"cat",
	"chicken",
	"corgi",
	"crow",
	"duffel",
	"fox",
	"frog",
	"giant enemy spider",
	"hawk",
	"kitten",
	"lizard",
	"monkey",
	"mothroach",
	"mouse",
	"mushroom",
	"phantom",
	"puppy",
	"rabbit",
	"repairbot",
	"snake",
	"spider",
)))

/datum/preference/choiced/pai_chassis
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "preferred_pai_chassis"

/// Apply a pAIs preferred chassis
/mob/living/silicon/pai_oculis/proc/apply_pref_chassis(client/player_client)
	if(player_client.prefs?.read_preference(/datum/preference/choiced/pai_chassis))
		var/list/chassis_choice = player_client.prefs.read_preference(/datum/preference/choiced/pai_chassis)
		if(chassis_choice == "Random")
			chassis_choice = pick(GLOB.pai_chassis)

		set_chassis(GLOB.pai_chassis[chassis_choice])

/mob/living/silicon/pai_oculis/apply_prefs_job(client/player_client, datum/job/job)
	apply_pref_name(/datum/preference/name/pai, player_client)
	apply_pref_chassis(player_client)
