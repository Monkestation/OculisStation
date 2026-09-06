
// ---- Generic metabolism boost ----
// Applied after REAGENT_REVERSE_METABOLISM logic, so it uniformly
// speeds up or slows down ALL reagents regardless of type.

/datum/reagent/compute_metabolization(mob/living/carbon/affected_mob, seconds_per_tick)
	. = ..()
	. *= affected_mob.reagent_metabolism_boost

// ---- Per-category effect modifiers ----
// Scale effect strength independently of consumption speed.
// compute_metabolization() scales the returned volume (affecting metabolization_ratio → effects).
// metabolize_reagent() divides back to restore normal consumption speed.

/datum/reagent/medicine/compute_metabolization(mob/living/carbon/affected_mob, seconds_per_tick)
	. = ..()
	. *= affected_mob.medicine_effect_modifier

/datum/reagent/medicine/metabolize_reagent(mob/living/carbon/affected_mob, seconds_per_tick, metabolized_volume)
	return ..(affected_mob, seconds_per_tick, metabolized_volume / affected_mob.medicine_effect_modifier)

/datum/reagent/toxin/compute_metabolization(mob/living/carbon/affected_mob, seconds_per_tick)
	. = ..()
	. *= affected_mob.toxin_effect_modifier

/datum/reagent/toxin/metabolize_reagent(mob/living/carbon/affected_mob, seconds_per_tick, metabolized_volume)
	return ..(affected_mob, seconds_per_tick, metabolized_volume / affected_mob.toxin_effect_modifier)
