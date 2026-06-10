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
