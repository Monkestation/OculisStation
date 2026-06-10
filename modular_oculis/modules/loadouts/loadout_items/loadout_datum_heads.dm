

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
