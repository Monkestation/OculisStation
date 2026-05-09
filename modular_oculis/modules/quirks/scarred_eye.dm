// Override of Scarred Eye quirk to use a preference for its provided clothing.
/datum/quirk_constant_data/eye_scarring
	associated_typepath = /datum/quirk/item_quirk/scarred_eye
	customization_options = list(/datum/preference/choiced/scarred_eye, /datum/preference/choiced/eyepatch)

/datum/quirk/item_quirk/scarred_eye/add_unique(client/client_source)
	// Could be called eyepatch_name or something, but blindfolds aren't really eyepatches.
	var/glasses_name = client_source?.prefs.read_preference(/datum/preference/choiced/eyepatch) || "Regular Eyepatch"
	var/obj/item/clothing/glasses/glasses_type
	if (client_source?.prefs.read_preference(/datum/preference/choiced/scarred_eye) == "Double" && glasses_name == "Random")
		// Chooses between the blindfolds if both eyes are scarred.
		glasses_name = pick("Blindfold", "Blindfold - Alt")
	else if (glasses_name == "Random")
		glasses_name = pick("Regular Eyepatch", "White Eyepatch", "Medical Eyepatch", "Wrap")
	// None option :)
	else if (glasses_name == "None")
		return
	glasses_type = GLOB.eyepatch[glasses_name]
	if (glasses_name == "Blindfold" || glasses_name == "Blindfold - Alt")
		give_item_to_holder(glasses_type, list(
			LOCATION_EYES,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		))
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/clothing/glasses/eyepatch/eyepatch = new glasses_type(get_turf(quirk_holder))
	if (human_holder.get_eye_scars() & LEFT_EYE_SCAR)
		eyepatch.flip_eyepatch()
	give_item_to_holder(eyepatch, list(
		LOCATION_EYES,
		LOCATION_BACKPACK,
		LOCATION_HANDS,
	))
