/datum/job/pai
	title = JOB_PAI
	rpg_title = "Familiar"
	description = "Assist the station, be a cool robotic pet."
	faction = FACTION_STATION
	total_positions = 5
	spawn_positions = 5
	supervisors = "absolutely everyone"
	spawn_type = /mob/living/silicon/pai_oculis
	minimal_player_age = 21
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "PAI_OCU"
	display_order = JOB_DISPLAY_ORDER_PAI
	job_flags = JOB_NEW_PLAYER_JOINABLE | JOB_EQUIP_RANK | JOB_CANNOT_OPEN_SLOTS

	departments_list = list(
		/datum/job_department/silicon,
	)

	alt_titles = list(
		"Personal AI",
		"Robotic Secretary",
	)

/datum/job/pai/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(!isoldpAI(spawned))
		return
	var/mob/living/silicon/pai_oculis/pai_spawn = spawned
	pai_spawn.unfold()
