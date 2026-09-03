/obj/item/organ
	var/bioboost_start_message = null
	var/bioboost_end_message = null

/obj/item/organ/proc/start_bioboost()
	organ_flags |= ORGAN_BIOBOOSTED

/obj/item/organ/proc/end_bioboost()
	organ_flags &= ~ORGAN_BIOBOOSTED

/obj/item/organ/bioimplant/fleshwelder
	name = "Fleshwelding gland"
	desc = "This bioengineered circulatory organ stimulates immune responses to tissue damage. Overstressing the gland may lead to pain, fatigue, or tissue damage."
	icon_state = "heart-on"

	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_FLESHWELD
	item_flags = NO_BLOOD_ON_ITEM
	healing_factor = STANDARD_ORGAN_HEALING

	low_threshold_passed = span_info("Your skin crawls and your gut sinks, like drinking far too much cold water.")
	high_threshold_passed = span_warning("There's a abrasive fuzz in your joints and a painful needling in your muscles.")
	now_fixed = span_info("The sense of decomposition fades.")
	now_failing = span_danger("Everything aches. Nothing moves like it should. It feels like you're falling apart!")
	high_threshold_cleared = span_info("The fuzz fades, and the needling retreats.")
	low_threshold_cleared = span_info("The crawling cold fades and your stomach settles down.")

	attack_verb_continuous = list("glands", "welds")
	attack_verb_simple = list("gland", "weld")

	// meds are stored in the... medicine sac i guess??
	food_reagents = list(/datum/reagent/consumable/nutriment/organ_tissue = 5, /datum/reagent/medicine/fleshsolder)
	var/power = 1
	var/bloodfix = 1
	var/burnfix = 1
	var/bonefix = 0
	var/damage_modifier = 1

/obj/item/organ/bioimplant/fleshwelder/on_life(seconds_per_tick)
	. = ..()
	if(organ_flags && ORGAN_FAILING)
		if(SPT_PROB(10, 5))
	for(var/datum/wound/toweld as anything in owner.all_wounds)
		var/self_damage = toweld.on_fleshweld(power, bloodfix, burnfix)
		if(self_damage)
			apply_organ_damage(self_damage * damage_modifier)


/datum/wound/proc/on_fleshweld(power, bloodfix, burnfix, bonefix)
	return 0

/datum/wound/burn/flesh/on_fleshweld(power, bloodfix, burnfix, bonefix)
	infection = min((infection - (0.05 * burnfix * power)), 0)
	flesh_damage = min((flesh_damage - (0.05 * burnfix * power)), 0)
	return 0.2

/datum/wound/slash/flesh/on_fleshweld(power, bloodfix, burnfix, bonefix)
	blood_flow = min((blood_flow -(0.05 * bloodfix * power)), 0)
	return 0.2

/datum/wound/pierce/on_fleshweld(power, bloodfix, burnfix, bonefix)
	blood_flow = min((blood_flow -(0.05 * bloodfix * power)), 0)
	return 0.4 //punctures are harder to clot

/datum/wound/blunt/bone/on_fleshweld(power, bloodfix, burnfix, bonefix)


/datum/reagent/medicine/fleshsolder
	name = "Fleshwelding Serum"
	description = "This experimental serum induces a powerful regenerative effect at the cost of long bouts of unconsciousness and exhaustion."
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/medicine/fleshsolder/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	metabolized
