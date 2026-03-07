/datum/quirk/traditional_thinker
	name = "Traditional Thinker"
	desc = "Your brain is located in your head like most organics. Note: This quirk only works on synths."
	gain_text = span_danger("Your head feels fat.")
	lose_text = span_notice("Your head gets dumb.")
	medical_record_text = "Patient's processor is located in the head."
	value = 0
	mob_trait = TRAIT_TRADITIONAL_THINKER
	icon = FA_ICON_ELEVATOR
	quirk_flags = QUIRK_HUMAN_ONLY
	// So we don't have silicons being stunlocked forever.

/datum/quirk/traditional_thinker/add(client/client_source)	//move their brain into their head
	if(issynthetic(quirk_holder))
		var/obj/item/organ/brain/brain = quirk_holder.get_organ_slot(ORGAN_SLOT_BRAIN)
		if(brain)
			brain.Remove(quirk_holder, special = TRUE, movement_flags = NO_ID_TRANSFER)
			brain.zone = BODY_ZONE_HEAD
			brain.Insert(quirk_holder, special = TRUE, movement_flags = NO_ID_TRANSFER)

/datum/quirk/traditional_thinker/remove()	//move their brain into their chest
	var/obj/item/organ/brain/brain = quirk_holder.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(brain)
		brain.Remove(quirk_holder, special = TRUE, movement_flags = NO_ID_TRANSFER)
		brain.zone = BODY_ZONE_CHEST
		brain.Insert(quirk_holder, special = TRUE, movement_flags = NO_ID_TRANSFER)

/datum/quirk/traditional_thinker/is_species_appropriate(datum/species/mob_species)
	if (!ispath(mob_species, /datum/species/synthetic))
		return FALSE
	return ..()



