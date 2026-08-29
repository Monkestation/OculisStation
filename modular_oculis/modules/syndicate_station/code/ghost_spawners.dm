/datum/job/octavia
	title = ROLE_OCTAVIA
	policy_index = ROLE_OCTAVIA
	paycheck = PAYCHECK_CREW
	bounty_types = DYNE_JOB_SCIENCE
	paycheck_department = ACCOUNT_DS2

/datum/job/octavia/prisoner
	title = ROLE_OCTAVIA
	policy_index = ROLE_OCTAVIA
	paycheck = PAYCHECK_ZERO
	bounty_types = CIV_JOB_RANDOM
	paycheck_department = null

/datum/job/octavia/command
	bounty_types = DS2_JOB_COMMAND
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_DS2
	head_announce = list(RADIO_CHANNEL_CYBERSUN)

/datum/job/octavia/engineer
	bounty_types = DS2_JOB_ENGINEER
	paycheck_department = ACCOUNT_DS2

/datum/job/octavia/science
	bounty_types = DS2_JOB_MECHANICAL
	paycheck_department = ACCOUNT_DS2

/datum/job/octavia/enforce
	bounty_types = DS2_JOB_ENFORCER
	paycheck_department = ACCOUNT_DS2

/datum/antagonist/octavia

/datum/antagonist/octavia/proc/spawn_rubicon()
	var/datum/map_template/shuttle/rubicon/ship = SSmapping.shuttle_templates["rubicon"]
	var/x = (world.maxx - TRANSITIONEDGE - ship.width)
	var/y = (world.maxy - TRANSITIONEDGE - ship.height)
	var/z
	if(SSmapping.empty_space)
		z = SSmapping.empty_space.z_value
	else
		for(var/datum/space_level/z_level as anything in SSmapping.z_list)
			if(z_level.traits.Find(ZTRAIT_RESERVED))
				z = z_level.z_value
				break

	var/turf/turf = locate(x,y,z)

	if(!turf)
		CRASH("Rubicon found no turf to load in")

	if(!ship.load(turf))
		CRASH("Rubicon has failed to load!")

	var/obj/docking_port/mobile/mobile_port = SSshuttle.getShuttle("rubicon")
	mobile_port.destination = SSshuttle.getDock("octavia_away")
	mobile_port.mode = SHUTTLE_IGNITING
	mobile_port.setTimer(mobile_port.ignitionTime)

