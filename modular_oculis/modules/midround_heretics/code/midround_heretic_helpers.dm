/// Checks to ensure there's at least some security and/or command for latejoin/midround heretics to spawn.
/proc/ensure_job_spread_for_heretics()
	var/command = 0
	var/security = 0
	for(var/datum/mind/crew as anything in get_crewmember_minds())
		if(QDELETED(crew.current) || crew.current.stat == DEAD || !crew.assigned_role)
			continue
		if(crew.assigned_role.job_flags & JOB_HEAD_OF_STAFF)
			command++
		else if(crew.assigned_role.departments_bitflags & DEPARTMENT_BITFLAG_SECURITY)
			security++

	// at least one command member and two security members.
	return command >= 1 && security >= 2

/proc/give_midround_heretic_with_bonus_points(datum/mind/target)
	var/datum/antagonist/heretic/heretic_datum = new
	// give some extra points, at a slightly less rate than just with passive points. maximum of 4 extra points
	var/extra_points = clamp(floor(STATION_TIME_PASSED() / (30 MINUTES)), 0, 4)
	if(extra_points > 0)
		heretic_datum.points_to_aura += round(extra_points / 2, 1)
		heretic_datum.adjust_knowledge_points(extra_points)
	target.add_antag_datum(heretic_datum)
