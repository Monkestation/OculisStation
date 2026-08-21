/datum/species/ethereal
	mutanteyes = /obj/item/organ/eyes/ethereal
	hair_alpha = 180
	facial_hair_alpha = 180

/datum/species/ethereal/get_default_mutant_bodyparts()
	return list(
		FEATURE_HORNS_ETHEREAL = MUTPART_BLUEPRINT("Short", is_randomizable = TRUE),
	)
