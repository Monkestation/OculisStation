/*
*	JOB-LOCKED
*/

//SEC
/datum/loadout_item/head/hc_police_cap_baseball
	name = "Coalition Police Baseball Cap"
	item_path = /obj/item/clothing/head/soft/hc_police
	restricted_roles = list(ALL_JOBS_SEC, ALL_JOBS_DEPTGUARD)
	group = "Job-Locked"

/datum/loadout_item/head/hc_police_cap
	name = "Coalition Police Cap"
	item_path = /obj/item/clothing/head/hats/colonial/hc_police
	restricted_roles = list(ALL_JOBS_SEC, ALL_JOBS_DEPTGUARD)
	group = "Job-Locked"

// HOS ONLY
/datum/loadout_item/head/hos_beret
	name = "Head of Security's beret"
	item_path = /obj/item/clothing/head/hats/hos/beret
	restricted_roles = list(JOB_HEAD_OF_SECURITY)
	group = "Job-Locked"

/datum/loadout_item/head/hos_cap
	name = "Head of Security's cap"
	item_path = /obj/item/clothing/head/hats/hos/cap
	restricted_roles = list(JOB_HEAD_OF_SECURITY)
	group = "Job-Locked"

// WARDEN ONLY

/datum/loadout_item/head/warden_drill
	name = "warden's campaign hat"
	item_path = /obj/item/clothing/head/hats/warden/drill
	restricted_roles = list(JOB_WARDEN)
	group = "Job-Locked"

/datum/loadout_item/head/warden_red
	name = "warden's hat"
	item_path = /obj/item/clothing/head/hats/warden/red
	restricted_roles = list(JOB_WARDEN)
	group = "Job-Locked"

/datum/loadout_item/head/warden
	name = "warden's hat"
	item_path = /obj/item/clothing/head/hats/warden
	restricted_roles = list(JOB_WARDEN)
	group = "Job-Locked"

/datum/loadout_item/head/warden_navyberet_nova
	name = "warden's beret"
	item_path = /obj/item/clothing/head/beret/sec/navywarden/nova
	restricted_roles = list(JOB_WARDEN)
	group = "Job-Locked"
