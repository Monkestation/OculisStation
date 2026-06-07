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

// We just use the same spawn points as assistants. This means I don't have to map shit, which means I retain 0.01% of sanity
/datum/job/pai/get_default_roundstart_spawn_point()
	for(var/obj/effect/landmark/start/spawn_point as anything in GLOB.start_landmarks_list)
		if(spawn_point.name != "Assistant")
			continue
		. = spawn_point
		if(spawn_point.used)
			continue
		spawn_point.used = TRUE
		break
	if(!.)
		. = ..()
	if(!.)
		log_mapping("Job [title] ([type]) couldn't find a round start spawn point.")
