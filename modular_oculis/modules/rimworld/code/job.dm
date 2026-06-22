/datum/job/colonist
	title = "Colonist"
	description = "Survive."
	faction = FACTION_STATION
	total_positions = -1
	spawn_positions = -1
	supervisors = "absolutely noone"
	exp_granted_type = EXP_TYPE_CREW
	outfit = /datum/outfit/job/colonist
	plasmaman_outfit = /datum/outfit/job/colonist // No plasmamen allowed.
	paycheck = PAYCHECK_ZERO

	paycheck_department = ACCOUNT_CIV
	display_order = JOB_DISPLAY_ORDER_ASSISTANT

	liver_traits = list()

	department_for_prefs = /datum/job_department/assistant

	family_heirlooms = list()

	mail_goodies = list()

	job_flags = JOB_CREW_MANIFEST|JOB_CREW_MEMBER|JOB_NEW_PLAYER_JOINABLE|JOB_REOPEN_ON_ROUNDSTART_LOSS|JOB_ASSIGN_QUIRKS
	rpg_title = "Lout"
	config_tag = "COLONIST"

/datum/job/colonist/get_outfit(consistent)
	return /datum/outfit/job/colonist

/datum/outfit/job/colonist
	name = "Colonist"
	jobtype = /datum/job/colonist
	id_trim = null
	uniform = /obj/item/clothing/under/color/grey
	id = null
	ears = null
	belt = null
	back = null
	shoes = /obj/item/clothing/shoes/sneakers/black
	box = null
	pda_slot = null

/datum/outfit/job/colonist/pre_equip(mob/living/carbon/human/target)
	..()
	give_jumpsuit(target)

/datum/outfit/job/colonist/proc/give_jumpsuit(mob/living/carbon/human/target)
	if (target.jumpsuit_style == PREF_SUIT)
		uniform = /obj/item/clothing/under/color/grey
	else
		uniform = /obj/item/clothing/under/color/jumpskirt/grey
