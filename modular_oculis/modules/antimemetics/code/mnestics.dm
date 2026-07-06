/datum/reagent/medicine/mnestic
	name = "Class W Mnestics"
	description = "You can never forget a dose of mnestics."
	color = "#a5a5a5"
	overdose_threshold = 25
	ph = 7
	taste_description = "almonds"
	chemical_flags = REAGENT_NO_RANDOM_RECIPE
	purge_multiplier = 0.15
	metabolized_traits = list(TRAIT_MNESTICS)

/datum/reagent/medicine/mnestic/on_mob_metabolize(mob/living/carbon/affected_mob)
	. = ..()
	to_chat(affected_mob, span_big(span_boldnicegreen("You feel more in control of what you remember.")))

/datum/reagent/medicine/mnestic/on_mob_end_metabolize(mob/living/carbon/affected_mob)
	. = ..()
	to_chat(affected_mob, span_big(span_bolddanger("You lose the force you had on your memories.")))

/datum/reagent/medicine/mnestic/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.5 * seconds_per_tick * metabolization_ratio, required_organ_flag = affected_organ_flags)
	affected_mob.adjust_confusion_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)
	affected_mob.adjust_staggered_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)
	affected_mob.adjust_eye_blur_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)
	affected_mob.adjust_drowsiness_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)
	return TRUE

/obj/item/reagent_containers/cup/bottle/mnestic
	name = "class w mnestic bottle"
	desc = "A small bottle of mnestics."
	list_reagents = list(/datum/reagent/medicine/mnestic = 50)

/datum/reagent/medicine/mnestic_x
	name = "Class X Mnestics"
	description = "Retroactive memory repair."
	color = "#a5a5a5"
	overdose_threshold = 25
	ph = 7
	taste_description = "almonds"
	chemical_flags = REAGENT_NO_RANDOM_RECIPE
	purge_multiplier = 0.15

/datum/reagent/medicine/mnestic_x/on_mob_metabolize(mob/living/carbon/affected_mob)
	. = ..()
	to_chat(affected_mob, span_big(span_boldnicegreen("You start to remember that which you had forgotten.")))

/datum/reagent/medicine/mnestic_x/on_mob_end_metabolize(mob/living/carbon/affected_mob)
	. = ..()
	to_chat(affected_mob, span_big(span_bolddanger("You remember what shouldn't be remembered. It was real after all...")))

/datum/reagent/medicine/mnestic_x/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.5 * seconds_per_tick * metabolization_ratio, required_organ_flag = affected_organ_flags)
	affected_mob.adjust_confusion_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)
	affected_mob.adjust_staggered_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)
	affected_mob.adjust_eye_blur_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)
	affected_mob.adjust_drowsiness_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)
	return TRUE

/obj/item/reagent_containers/cup/bottle/mnestic_x
	name = "class x mnestic bottle"
	desc = "A small bottle of strong mnestics."
	list_reagents = list(/datum/reagent/medicine/mnestic_x = 50)
