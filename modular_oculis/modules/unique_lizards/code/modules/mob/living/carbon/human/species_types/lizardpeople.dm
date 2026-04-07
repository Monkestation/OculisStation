/*
/datum/species/lizard/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons, replace_missing)
	. = ..()

	RegisterSignal(human_who_gained_species, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_gained_organ))
	RegisterSignal(human_who_gained_species, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(on_removed_organ))

/datum/species/lizard/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)

	UnregisterSignal(human, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_gained_organ))
	UnregisterSignal(human, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(on_removed_organ))
	human.remove_client_colour(/datum/client_colour/monochrome/lizard)
	return ..()

/datum/species/lizard/proc/on_gained_organ(mob/living/receiver, obj/item/organ/tongue/lizard/forked)
	SIGNAL_HANDLER

	if(!istype(forked))
		return
	receiver.remove_client_colour(/datum/client_colour/monochrome/lizard, REF(src))

/datum/species/lizard/proc/on_removed_organ(mob/living/unreceiver, obj/item/organ/tongue/lizard/forked)
	SIGNAL_HANDLER

	var/obj/item/organ/brain/lizard/liz_brain = unreceiver.get_organ_by_type(/obj/item/organ/brain/lizard)

	if(liz_brain)
		if(!istype(forked))
			return
		unreceiver.add_client_colour(/datum/client_colour/monochrome/lizard)

/datum/client_colour/monochrome/lizard
*/
