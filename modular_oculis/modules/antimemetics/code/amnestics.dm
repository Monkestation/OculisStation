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

/datum/reagent/medicine/amnestic/on_mob_metabolize(mob/living/carbon/affected_carbon)
	. = ..()
	if(!HAS_TRAIT(affected_carbon, TRAIT_MNESTICS))
		to_chat(affected_carbon, span_big(span_hypnophrase("You feel your memories slipping away.")))

/datum/reagent/medicine/amnestic/on_mob_end_metabolize(mob/living/carbon/affected_carbon)
	. = ..()
	if(!HAS_TRAIT(affected_carbon, TRAIT_MNESTICS))
		to_chat(affected_carbon, span_big(span_hypnophrase("You can't seem to remember what happened...")))

/datum/reagent/medicine/amnestic/overdose_process(mob/living/affected_carbon, seconds_per_tick, metabolization_ratio)
	if(SPT_PROB(25, seconds_per_tick))
		affected_carbon.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.25 * seconds_per_tick * metabolization_ratio, required_organ_flag = affected_organ_flags)
		affected_carbon.adjust_confusion(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio)
		affected_carbon.adjust_staggered(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio)
	return TRUE
