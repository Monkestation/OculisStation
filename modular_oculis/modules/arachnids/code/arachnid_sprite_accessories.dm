/datum/sprite_accessory/arachnid_appendages
	icon = 'modular_oculis/modules/arachnids/icons/arachnid_appendages.dmi'
	key = FEATURE_ARACHNID_APPENDAGES
	organ_type = /obj/item/organ/arachnid_appendages
	color_src = USE_ONE_COLOR
	em_block = TRUE
	recommended_species = list(SPECIES_ARACHNID = 1)

/datum/sprite_accessory/arachnid_appendages/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/arachnid_appendages/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/arachnid_appendages/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/arachnid_appendages/sharp
	name = "Sharp"
	icon_state = "sharp"

/datum/sprite_accessory/arachnid_appendages/zigzag
	name = "Zigzag"
	icon_state = "zigzag"

/datum/sprite_accessory/arachnid_appendages/chipped
	name = "Chipped"
	icon_state = "chipped"

/datum/sprite_accessory/arachnid_appendages/curled
	name = "Curled"
	icon_state = "curled"

/datum/dna_block/feature/mutant/arachnid_appendages
	feature_key = FEATURE_ARACHNID_APPENDAGES


/datum/sprite_accessory/arachnid_chelicerae
	icon = 'modular_oculis/modules/arachnids/icons/arachnid_chelicerae.dmi'
	key = FEATURE_ARACHNID_CHELICERAE
	organ_type = /obj/item/organ/arachnid_chelicerae
	color_src = USE_ONE_COLOR
	em_block = TRUE
	recommended_species = list(SPECIES_ARACHNID = 1)

/datum/sprite_accessory/arachnid_chelicerae/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/arachnid_chelicerae/basic
	name = "Basic"
	icon_state = "basic"

/datum/dna_block/feature/mutant/arachnid_chelicerae
	feature_key = FEATURE_ARACHNID_CHELICERAE


/datum/preference/toggle/mutant_toggle/arachnid_appendages
	savefile_key = "arachnid_appendages_toggle"
	relevant_mutant_bodypart = FEATURE_ARACHNID_APPENDAGES

/datum/preference/choiced/mutant_choice/arachnid_appendages
	savefile_key = "feature_arachnid_appendages"
	relevant_mutant_bodypart = FEATURE_ARACHNID_APPENDAGES
	type_to_check = /datum/preference/toggle/mutant_toggle/arachnid_appendages
	default_accessory_type = /datum/sprite_accessory/arachnid_appendages/none


/datum/preference/toggle/mutant_toggle/arachnid_chelicerae
	savefile_key = "arachnid_chelicerae_toggle"
	relevant_mutant_bodypart = FEATURE_ARACHNID_CHELICERAE

/datum/preference/choiced/mutant_choice/arachnid_chelicerae
	savefile_key = "feature_arachnid_chelicerae"
	relevant_mutant_bodypart = FEATURE_ARACHNID_CHELICERAE
	type_to_check = /datum/preference/toggle/mutant_toggle/arachnid_chelicerae
	default_accessory_type = /datum/sprite_accessory/arachnid_chelicerae/none
