/obj/item/organ/cyberimp/mouth/tastebooster
	name = "gustatory hypersensitizer"
	desc = "This cybernetic implant increases the taste sensitivity of the implantee."
	w_class = WEIGHT_CLASS_TINY
	slot = ORGAN_SLOT_TASTEBOOSTER

/obj/item/organ/cyberimp/mouth/tastebooster/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	RegisterSignal(organ_owner, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(add_boost))
	RegisterSignal(organ_owner, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(remove_boost))
	var/obj/item/organ/tongue/thetongue = organ_owner.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(istype(thetongue))
		thetongue.taste_sensitivity = 1

/obj/item/organ/cyberimp/mouth/tastebooster/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(organ_owner, list(
		COMSIG_CARBON_GAIN_ORGAN,
		COMSIG_CARBON_LOSE_ORGAN))
	var/obj/item/organ/tongue/thetongue = organ_owner.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(istype(thetongue))
		thetongue.taste_sensitivity = initial(thetongue.taste_sensitivity)

/obj/item/organ/cyberimp/mouth/tastebooster/proc/add_boost(datum/source, obj/item/organ/tongue/unboosted_tongue)
	if(!istype(unboosted_tongue))
		return
	unboosted_tongue.taste_sensitivity = 1

/obj/item/organ/cyberimp/mouth/tastebooster/proc/remove_boost(datum/source, obj/item/organ/tongue/boosted_tongue)
	if(!istype(boosted_tongue))
		return
	boosted_tongue.taste_sensitivity = initial(boosted_tongue.taste_sensitivity)

/datum/augment_item/organ/mouth/tastebooster
	name = "Gustatory Hypersensitizer"
	extra_info = "Increases taste sensitivity."
	cost = 4
	path = /obj/item/organ/cyberimp/mouth/tastebooster

/datum/design/tastebooster
	name = "gustatory hypersensitizer"
	desc = "This cybernetic implant greatly increases the taste sensitivity of the implantee."
	id = "ci-tastebooster"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 6 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*5,
		/datum/material/silver =SMALL_MATERIAL_AMOUNT*2,
	)
	build_path = /obj/item/organ/cyberimp/mouth/tastebooster
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/techweb_node/tastebooster
	id = TECHWEB_NODE_TASTEBOOSTER
	display_name = "Gastrointestinal Thingamawidgetry"
	description = "Shove a microchip in your mouth, taste things better. Makes logical sense."
	prereq_ids = list(TECHWEB_NODE_FOOD_PROC, TECHWEB_NODE_CYBER_IMPLANTS)
	design_ids = list(
		"ci-tastebooster"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS / 2)
	announce_channels = list(RADIO_CHANNEL_SERVICE, RADIO_CHANNEL_MEDICAL, RADIO_CHANNEL_SCIENCE)

