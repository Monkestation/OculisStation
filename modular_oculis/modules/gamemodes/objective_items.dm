/datum/objective_item/steal/traitor/telebaton
	name = "a head of staff's telescopic baton"
	targetitem = list(
		/obj/item/melee/baton/telescopic/bronze,
		/obj/item/melee/baton/telescopic/silver,
		/obj/item/melee/baton/telescopic/gold,
	)
	excludefromjob = list(
		JOB_RESEARCH_DIRECTOR,
		JOB_CAPTAIN,
		JOB_HEAD_OF_SECURITY,
		JOB_HEAD_OF_PERSONNEL,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_QUARTERMASTER,
	)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "A self-defense weapon standard-issue for all heads of staffs barring the Head of Security. Rarely found off of their person."
