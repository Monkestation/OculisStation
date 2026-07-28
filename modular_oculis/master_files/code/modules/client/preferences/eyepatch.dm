/datum/preference/choiced/eyepatch
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "eyepatch"
	savefile_identifier = PREFERENCE_CHARACTER
	should_generate_icons = TRUE

/datum/preference/choiced/eyepatch/create_default_value()
	return "Random"

/datum/preference/choiced/eyepatch/init_possible_values()
	return assoc_to_keys(GLOB.eyepatch) + "Random" + "None"

/datum/preference/choiced/eyepatch/icon_for(value)
	if (value == "Random")
		return uni_icon('icons/effects/random_spawners.dmi', "questionmark")
	else if (value == "None")
		return uni_icon('icons/effects/crayondecal.dmi', "nay")
	else
		var/obj/item/clothing/glasses/selected_type = GLOB.eyepatch[value]
		return uni_icon(selected_type::icon, selected_type::icon_state)

/datum/preference/choiced/eyepatch/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Scarred Eye" in preferences.all_quirks

/datum/preference/choiced/eyepatch/apply_to_human(mob/living/carbon/human/target, value)
	return
