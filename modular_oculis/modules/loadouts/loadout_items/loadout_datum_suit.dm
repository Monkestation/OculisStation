/datum/loadout_item/suit/coat_chemistry
	name = "Winter Coat - Chemistry"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical/chemistry

/datum/loadout_item/suit/coat_coroner
	name = "Winter Coat - Coroner"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical/coroner

/datum/loadout_item/suit/coat_genetics
	name = "Winter Coat - Genetics"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/science/genetics

/datum/loadout_item/suit/coat_janitor
	name = "Winter Coat - Janitor"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/janitor

/datum/loadout_item/suit/coat_virology
	name = "Winter Coat - Virology"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical/viro

/*
*	JOB-LOCKED
*/

//SEC
/datum/loadout_item/suit/hc_police_bomber_jacket
	name = "Coalition Police Aerostatic Bomber Jacket"
	item_path = /obj/item/clothing/suit/armor/vest/hc_police_jacket
	restricted_roles = list(ALL_JOBS_SEC)
	group = "Job-Locked"

/datum/loadout_item/suit/hc_police_jacket
	name = "Coalition Police Official Jacket"
	item_path = /obj/item/clothing/suit/armor/vest/hc_police_jacket/suit
	restricted_roles = list(ALL_JOBS_SEC)
	group = "Job-Locked"


// HOS ONLY
/datum/loadout_item/suit/hos_armor
	name = "armored greatcoat"
	item_path = /obj/item/clothing/suit/armor/hos
	restricted_roles = list(JOB_HEAD_OF_SECURITY)
	group = "Job-Locked"

/datum/loadout_item/suit/hos_formal
	name = "Head of Security's parade jacket"
	item_path = /obj/item/clothing/suit/armor/hos/hos_formal
	restricted_roles = list(JOB_HEAD_OF_SECURITY)
	group = "Job-Locked"

/datum/loadout_item/suit/hos_trenchcoat
	name = "Head of Security's winter trenchcoat"
	item_path = /obj/item/clothing/suit/armor/hos/trenchcoat/winter
	restricted_roles = list(JOB_HEAD_OF_SECURITY)
	group = "Job-Locked"

/datum/loadout_item/suit/leather_armorvest
	name = "security overcoat"
	item_path = /obj/item/clothing/suit/armor/vest/leather
	restricted_roles = list(JOB_HEAD_OF_SECURITY)
	group = "Job-Locked"

//WARDEN

/datum/loadout_item/suit/warden_alt_armor
	name = "warden's armoured jacket"
	item_path = /obj/item/clothing/suit/armor/vest/warden/alt
	restricted_roles = list(JOB_WARDEN)
	group = "Job-Locked"

/datum/loadout_item/suit/warden_armor
	name = "warden's jacket"
	item_path = /obj/item/clothing/suit/armor/vest/warden
	restricted_roles = list(JOB_WARDEN)
	group = "Job-Locked"

/datum/loadout_item/suit/warden_blue_armor
	name = "warden's armoured jacket"
	item_path = /obj/item/clothing/suit/armor/vest/warden/blue
	restricted_roles = list(JOB_WARDEN)
	group = "Job-Locked"
