/datum/species/jelly
	smoker_lungs = /obj/item/organ/lungs/slime/slime_smoker

	// Ability to allow them to clean themselves and their stuff.
	var/datum/action/cooldown/slime_washing/slime_washing
	/// Ability to allow them to resist the effects of water.
	var/datum/action/cooldown/slime_hydrophobia/slime_hydrophobia

	/// Cooldown for balloon alerts when being melted from water exposure.
	COOLDOWN_DECLARE(water_alert_cooldown)
	/// Cooldown for balloon alerts when being melted from being dripping wet.
	COOLDOWN_DECLARE(wet_alert_cooldown)
	/// Water exposure cool down. Hopefully makes extinguiser exposure more consistent.
	COOLDOWN_DECLARE(water_exposure_cooldown)

	/// List of organ types we should move to the chest.
	var/static/list/organs_to_move = list(
		/obj/item/organ/ears,
		/obj/item/organ/eyes,
		/obj/item/organ/tongue,
	)

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

	RegisterSignal(new_jellyperson, COMSIG_ATOM_EXPOSE_REAGENTS, PROC_REF(on_reagent_expose))
	RegisterSignal(new_jellyperson, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_organ_gain))
	RegisterSignal(new_jellyperson, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(on_organ_loss))

	for(var/obj/item/organ/organ as anything in new_jellyperson.organs)
		if(is_type_in_list(organ, organs_to_move))
			organ.zone = BODY_ZONE_CHEST

/datum/species/jelly/on_species_loss(mob/living/carbon/former_jellyperson, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(former_jellyperson, list(COMSIG_ATOM_EXPOSE_REAGENTS, COMSIG_CARBON_GAIN_ORGAN, COMSIG_CARBON_LOSE_ORGAN))
	if(slime_washing)
		slime_washing.Remove(former_jellyperson)
		QDEL_NULL(slime_washing)
	if(slime_hydrophobia)
		slime_hydrophobia.Remove(former_jellyperson)
		QDEL_NULL(slime_hydrophobia)

	for(var/obj/item/organ/organ as anything in former_jellyperson.organs)
		if(is_type_in_list(organ, organs_to_move))
			organ.zone = initial(organ.zone)

#define WATER_PROTECTION_HEAD 0.3
#define WATER_PROTECTION_CHEST 0.2
#define WATER_PROTECTION_GROIN 0.1
#define WATER_PROTECTION_LEG (0.075 * 2)
#define WATER_PROTECTION_FOOT (0.025 * 2)
#define WATER_PROTECTION_ARM (0.075 * 2)
#define WATER_PROTECTION_HAND (0.025 * 2)

/// Multiplier for how much blood is lost when sprayed with water.
/datum/species/jelly/proc/water_damage_multiplier(mob/living/carbon/human/slime)
	. = 1

	var/protection_flags = NONE
	for(var/obj/item/clothing/worn in slime.get_equipped_items())
		if(worn.clothing_flags & THICKMATERIAL)
			protection_flags |= worn.body_parts_covered

	if(protection_flags)
		if(protection_flags & HEAD)
			. -= WATER_PROTECTION_HEAD
		if(protection_flags & CHEST)
			. -= WATER_PROTECTION_CHEST
		if(protection_flags & GROIN)
			. -= WATER_PROTECTION_GROIN
		if(protection_flags & LEGS)
			. -= WATER_PROTECTION_LEG
		if(protection_flags & FEET)
			. -= WATER_PROTECTION_FOOT
		if(protection_flags & ARMS)
			. -= WATER_PROTECTION_ARM
		if(protection_flags & HANDS)
			. -= WATER_PROTECTION_HAND

	return CLAMP01(FLOOR(., 0.1))


#undef WATER_PROTECTION_HEAD
#undef WATER_PROTECTION_CHEST
#undef WATER_PROTECTION_GROIN
#undef WATER_PROTECTION_LEG
#undef WATER_PROTECTION_FOOT
#undef WATER_PROTECTION_ARM
#undef WATER_PROTECTION_HAND


/datum/species/jelly/proc/water_exposure(mob/living/carbon/human/slime, check_clothes = TRUE, quiet_if_protected = FALSE)
	var/water_multiplier = 1
	// thick clothing won't protect you if you just drink or inject tho
	if(check_clothes)
		// if all your limbs are covered by thickmaterial clothing, then it will protect you from water.
		water_multiplier = water_damage_multiplier(slime)
		if(water_multiplier <= 0)
			if(!quiet_if_protected)
				to_chat(slime, span_warning("The water fails to penetrate your thick clothing!"))
			return FALSE
	if(HAS_TRAIT(slime, TRAIT_SLIME_HYDROPHOBIA))
		if(!quiet_if_protected)
			to_chat(slime, span_warning("Water splashes against your oily membrane and rolls right off your body!"))
		return FALSE
	if(!COOLDOWN_FINISHED(src, water_exposure_cooldown))
		return FALSE
	COOLDOWN_START(src, water_exposure_cooldown, 0.1 SECONDS)
	slime.adjust_blood_volume(-30 * water_multiplier)
	if(COOLDOWN_FINISHED(src, water_alert_cooldown))
		slime.visible_message(
			span_warning("[slime]'s form melts away from the water!"),
			span_danger("The water causes you to melt away!"),
		)
		slime.balloon_alert_to_viewers("melts away from water!", "water melts you!")
		COOLDOWN_START(src, water_alert_cooldown, 1 SECONDS)
	return TRUE

/datum/species/jelly/proc/on_reagent_expose(mob/living/carbon/human/slime, list/reagents, datum/reagents/source, methods, volume_modifier, show_message)
	SIGNAL_HANDLER
	if(!(locate(/datum/reagent/water) in reagents)) // we only care if we're exposed to water (duh)
		return NONE
	if(HAS_TRAIT(slime, TRAIT_GODMODE)) // we're [title card]
		return NONE
	// thick clothing won't protect you if you just drink or inject tho
	var/check_clothes = methods & ~(INGEST|INJECT)
	if(!water_exposure(slime, check_clothes))
		return COMPONENT_NO_EXPOSE_REAGENTS
	return NONE

// This ensures that tongues always get moved to their chest.
/datum/species/jelly/proc/on_organ_gain(mob/living/carbon/slime, obj/item/organ/organ)
	SIGNAL_HANDLER
	if(is_type_in_list(organ, organs_to_move))
		organ.zone = BODY_ZONE_CHEST

/datum/species/jelly/proc/on_organ_loss(mob/living/carbon/slime, obj/item/organ/organ)
	SIGNAL_HANDLER
	if(is_type_in_list(organ, organs_to_move))
		organ.zone = initial(organ.zone)
