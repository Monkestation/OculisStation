/datum/chemical_reaction/amnestic
	results = list(/datum/reagent/medicine/amnestic = 5)
	required_reagents = list(
		/datum/reagent/medicine/ondansetron = 1,
		/datum/reagent/medicine/polypyr = 1,
		/datum/reagent/medicine/rezadone = 1,
		/datum/reagent/medicine/neurine = 1,
		/datum/reagent/toxin/amanitin = 1,
		)
	reaction_tags = NONE

/datum/reagent/medicine/amnestic
	name = "Class A Amnestics"
	description = "A standard for keeping secrets."
	color = "#a5a5a5"
	overdose_threshold = 25
	ph = 7
	taste_description = "almonds"
	chemical_flags = REAGENT_NO_RANDOM_RECIPE
	metabolized_traits = list(TRAIT_AMNESTICS)

/datum/reagent/medicine/amnestic/on_mob_metabolize(mob/living/carbon/affected_mob)
	. = ..()
	if(!HAS_TRAIT(affected_mob, TRAIT_MNESTICS))
		to_chat(affected_mob, span_big(span_hypnophrase("You feel specific memories slipping away.")))

/datum/reagent/medicine/amnestic/on_mob_end_metabolize(mob/living/carbon/affected_mob)
	. = ..()
	if(!HAS_TRAIT(affected_mob, TRAIT_MNESTICS))
		to_chat(affected_mob, span_big(span_hypnophrase("You can't seem to remember what you forgot...")))

/datum/reagent/medicine/amnestic/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(25, seconds_per_tick))
		affected_mob.adjust_drowsiness_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)
		affected_mob.adjust_staggered_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)

/datum/reagent/medicine/amnestic/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	if(SPT_PROB(25, seconds_per_tick))
		affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.25 * seconds_per_tick * metabolization_ratio, required_organ_flag = affected_organ_flags)
		affected_mob.adjust_confusion_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)
		affected_mob.adjust_staggered_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)
	return TRUE

/obj/item/reagent_containers/cup/bottle/amnestic
	name = "class a amnestic bottle"
	desc = "A small bottle of amnestics."
	list_reagents = list(/datum/reagent/medicine/amnestic = 50)

/datum/reagent/medicine/amnestic_b
	name = "Class B Amnestics"
	description = "Retrograde amnesiac medicine."
	color = "#a5a5a5"
	overdose_threshold = 25
	ph = 7
	taste_description = "almonds"
	chemical_flags = REAGENT_NO_RANDOM_RECIPE
	metabolized_traits = list(TRAIT_AMNESTICS)

/datum/reagent/medicine/amnestic_b/on_mob_metabolize(mob/living/carbon/affected_mob)
	. = ..()
	to_chat(affected_mob, span_big(span_hypnophrase("You feel your memories slipping away, starting with your most recent ones.")))

/datum/reagent/medicine/amnestic_b/on_mob_end_metabolize(mob/living/carbon/affected_mob)
	. = ..()
	to_chat(affected_mob, span_big(span_hypnophrase("You can't seem to remember what you forgot...")))

/datum/reagent/medicine/amnestic_b/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(25, seconds_per_tick))
		affected_mob.adjust_drowsiness_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)
		affected_mob.adjust_staggered_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)

/datum/reagent/medicine/amnestic_b/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	if(SPT_PROB(25, seconds_per_tick))
		affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.25 * seconds_per_tick * metabolization_ratio, required_organ_flag = affected_organ_flags)
		affected_mob.adjust_confusion_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)
		affected_mob.adjust_staggered_up_to(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio, 30 SECONDS)
	return TRUE

/obj/item/reagent_containers/cup/bottle/amnestic_b
	name = "class b amnestic bottle"
	desc = "A small bottle of strong amnestics."
	list_reagents = list(/datum/reagent/medicine/amnestic = 50)
