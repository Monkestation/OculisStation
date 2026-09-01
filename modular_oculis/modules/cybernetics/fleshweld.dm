/obj/item/organ/fleshwelder
	name = "Fleshwelding gland"
	desc = "This bioengineered circulatory organ stimulates immune responses to tissue damage, especially improving coagulation capabilities. Overstressing the gland may lead to pain, fatigue, or tissue damage."
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
	food_reagents = list(/datum/reagent/consumable/nutriment/organ_tissue = 5, /datum/reagent/medicine/coagulant = 5, /datum/reagent/medicine/spaceacillin = 2.5)
	var/power = 1
	var/bloodfix = 2
	var/burnfix = 0.25
	var/damage_modifier = 1

/obj/item/organ/fleshwelder/on_life(seconds_per_tick)
	. = ..()
	for(var/datum/wound/toweld as anything in owner.all_wounds)
		var/self_damage = toweld.on_fleshweld(power, bloodfix, burnfix)
		if(self_damage)
			apply_organ_damage(self_damage * damage_modifier)


/datum/wound/proc/on_fleshweld(power, bloodfix, burnfix)
	return 0

/datum/wound/burn/on_fleshweld(power, bloodfix, burnfix)
	return 0
