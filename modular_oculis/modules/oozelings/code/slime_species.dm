/datum/species/jelly
	// Ability to allow them to clean themselves and their stuff.
	var/datum/action/cooldown/slime_washing/slime_washing
	/// Ability to allow them to resist the effects of water.
	var/datum/action/cooldown/slime_hydrophobia/slime_hydrophobia

/datum/species/jelly/Destroy(force)
	QDEL_NULL(slime_washing)
	QDEL_NULL(slime_hydrophobia)
	return ..()

/datum/species/jelly/on_species_gain(mob/living/carbon/new_jellyperson, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	if(!ishuman(new_jellyperson))
		return
	if(QDELETED(slime_washing))
		slime_washing = new
	slime_washing.Grant(new_jellyperson)
	if(QDELETED(slime_hydrophobia))
		slime_hydrophobia = new
	slime_hydrophobia.Grant(new_jellyperson)

/datum/species/jelly/on_species_loss(mob/living/carbon/former_jellyperson, datum/species/new_species, pref_load)
	. = ..()
	if(slime_washing)
		slime_washing.Remove(former_jellyperson)
		QDEL_NULL(slime_washing)
	if(slime_hydrophobia)
		slime_hydrophobia.Remove(former_jellyperson)
		QDEL_NULL(slime_hydrophobia)
