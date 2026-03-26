/datum/quirk/echolocation
	name = "Echolocation"
	desc = "Though your eyes no longer function, you accommodate for it by some means of extrasensory echolocation and sensitive hearing. Beware: if you're ever deafened, you'll also lose your echolocation until you recover!"
	gain_text = span_notice("The slightest sounds map your surroundings.")
	lose_text = span_notice("The world resolves into colour and clarity.")
	value = -16 //IRIS EDIT: 0 to -16, Arguably worse than being blind because it's very tiring on the eyes (it even says so in one of the comments below and in one of the abilities)
	icon = FA_ICON_EAR_LISTEN
	mob_trait = TRAIT_GOOD_HEARING
	medical_record_text = "Patient's eyes are biologically nonfunctional. Hearing tests indicate almost supernatural acuity."
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	mail_goodies = list(/obj/item/clothing/glasses/sunglasses, /obj/item/cane/white)
	/// where we store easy access to the character's echolocation component (for stuff like drugs)
	var/datum/component/echolocation/esp
	/// where we store access to the client colour we make
	var/datum/client_colour/echolocation_custom/esp_color

/datum/quirk/echolocation/is_species_appropriate(datum/species/mob_species)
	if(ispath(mob_species, /datum/species/dullahan))
		return FALSE
	return ..()

/datum/quirk/echolocation/add(client/client_source)
	// echolocation component handles blinding us already so we don't need to worry about that
	var/mob/living/carbon/human/human_holder = quirk_holder
	// set up the desired echo group from our quirk preferences
	var/client_use_echo = client_source?.prefs.read_preference(/datum/preference/toggle/echolocation_overlay)
	if (isnull(client_use_echo))
		client_use_echo = TRUE

	human_holder.AddComponent(/datum/component/echolocation, echo_range = 5, use_echo = client_use_echo)
	esp = human_holder.GetComponent(/datum/component/echolocation)

	//IRIS EDIT ADDITION BEGIN - SLOWER_ECHOLOCATION_PREF
	var/client_echo_render_mult = client_source?.prefs.read_preference(/datum/preference/numeric/echolocation_mult)
	if(client_echo_render_mult)
		//esp.fade_in_time *= client_echo_render_mult
		esp.image_expiry_time *= client_echo_render_mult
		//esp.fade_out_time *= client_echo_render_mult
	//IRIS EDIT ADDITION END

	// HEY! we probably need something to make sure they don't set a color that's too dark or their UI could be totally invisible.
	// GOOD NEWS! we can re-use the runechat colour stuff for this (probably)
	var/datum/status_effect/grouped/blindness/blindness_status_effect = human_holder.has_status_effect(/datum/status_effect/grouped/blindness)
	if(blindness_status_effect)
		human_holder.remove_client_colour(REF(blindness_status_effect)) // get rid of the existing blind one
	esp_color = human_holder.add_client_colour(/datum/client_colour/echolocation_custom, REF(src))
	var/col = process_chat_color(client_source?.prefs.read_preference(/datum/preference/color/echolocation_outline))
	esp_color.priority = 1 // mirrors PRIORITY_ABSOLUTE def inside client_color.dm, stops pipes and stuff showing as different colours
	esp_color.update_color(col)

	// double the ear/hearing damage multiplier from any source.
	var/obj/item/organ/ears/echo_ears = human_holder.get_organ_slot(ORGAN_SLOT_EARS)
	if (!istype(echo_ears))
		return

	echo_ears.damage_multiplier *= 2

/datum/quirk/echolocation/remove()
	QDEL_NULL(esp) // echolocation component removal handles graceful disposal of everything above except the ears
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/ears/echo_ears = human_holder.get_organ_slot(ORGAN_SLOT_EARS)
	if (!istype(echo_ears))
		return
	echo_ears.damage_multiplier = initial(echo_ears.damage_multiplier)
	human_holder.remove_client_colour(REF(src)) // clean up the custom colour override we added

/datum/client_colour/echolocation_custom

/datum/quirk_constant_data/echolocation
	associated_typepath = /datum/quirk/echolocation
	customization_options = list(/datum/preference/color/echolocation_outline, /datum/preference/toggle/echolocation_overlay)

// Client preference for echolocation outline colour
/datum/preference/color/echolocation_outline
	savefile_key = "echolocation_outline"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED

/datum/preference/color/echolocation_outline/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Echolocation" in preferences.all_quirks

/datum/preference/color/echolocation_outline/apply_to_human(mob/living/carbon/human/target, value)
	return

// Client preference for whether we display the echolocation overlay or not
/datum/preference/toggle/echolocation_overlay
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "echolocation_use_echo"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/toggle/echolocation_overlay/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Echolocation" in preferences.all_quirks

/datum/preference/toggle/echolocation_overlay/apply_to_human(mob/living/carbon/human/target, value)
	return

//IRIS EDIT ADDITION BEGIN - SLOWER_ECHOLOCATION_PREF
/// Used to change delay between echolation auto-pulses, measured in seconds
/datum/preference/numeric/echolocation_speed
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "echolocation_speed"
	savefile_identifier = PREFERENCE_CHARACTER
	minimum = 1
	maximum = 15

/datum/preference/numeric/echolocation_speed/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Echolocation" in preferences.all_quirks

/datum/preference/numeric/echolocation_speed/create_default_value()
	return 5

/datum/preference/numeric/echolocation_speed/apply_to_human(mob/living/carbon/human/target, value)
	return

/// Used to stretch fadein, presence and fadeout times of each echolocation image
/datum/preference/numeric/echolocation_mult
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "echolocation_mult"
	savefile_identifier = PREFERENCE_CHARACTER
	minimum = 1
	maximum = 15

/datum/preference/numeric/echolocation_mult/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Echolocation" in preferences.all_quirks

/datum/preference/numeric/echolocation_mult/create_default_value()
	return 1

/datum/preference/numeric/echolocation_mult/apply_to_human(mob/living/carbon/human/target, value)
	return
//IRIS EDIT ADDITION END
