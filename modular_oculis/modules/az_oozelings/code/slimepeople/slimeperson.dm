/datum/species/jelly/slime
	/// The manager instance used to link all of someone's slimeperson bodies.
	var/datum/slimeperson_manager/manager
	/// If TRUE, then the next `spec_life` will ensure that the slime body is added to the manager, if there is one.
	/// Mostly a simple workaround for ensuring cloned/recreated bodies are properly linked.
	var/needs_manager_update = FALSE

/datum/species/jelly/slime/Destroy(force)
	manager = null
	return ..()

/datum/species/jelly/slime/on_species_gain(mob/living/carbon/slime, datum/species/old_species)
	. = ..()
	if(slime.mind && isnull(manager))
		manager = GLOB.slimeperson_managers[slime.mind]
		if(isnull(manager)) // initialize a manager if one doesn't exist I guess
			manager = new(slime.mind)
	manager?.add_body(slime)

/datum/species/jelly/slime/on_species_loss(mob/living/carbon/slime)
	manager?.remove_body(slime)
	return ..()

/datum/species/jelly/slime/spec_life(mob/living/carbon/human/slime, seconds_per_tick)
	if(needs_manager_update && manager)
		manager.add_body(slime)
		needs_manager_update = FALSE
	return ..()

/datum/species/jelly/slime/proc/on_death_move_body(mob/living/carbon/human/slime, gibbed)
	SIGNAL_HANDLER
	if(manager && slime.mind?.active)
		var/list/available_bodies = manager.get_available_bodies() - slime
		if(length(available_bodies))
			manager.swap_to_dupe(pick(available_bodies))

/datum/species/jelly/slime/copy_properties_from(datum/species/jelly/slime/old_species)
	manager = old_species.manager
	needs_manager_update = TRUE

/datum/action/innate/swap_body
	name = "Swap Body"
	check_flags = NONE
	button_icon_state = "slimeswap"
	button_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"

/datum/action/innate/swap_body/Activate()
	var/datum/species/jelly/slime/slime = astype(astype(owner, /mob/living/carbon/human)?.dna?.species)
	if(isnull(slime))
		to_chat(owner, span_warning("You are not a slimeperson."))
		Remove(owner)
		return
	slime.manager?.ui_interact(owner)
