/datum/chemical_reaction/mnestic
	results = list(/datum/reagent/medicine/mnestic = 4)
	required_reagents = list(
		/datum/reagent/medicine/neurine = 1,
		/datum/reagent/medicine/rezadone = 1,
		/datum/reagent/medicine/psicodine = 1,
		/datum/reagent/medicine/modafinil = 1,
		)
	reaction_tags = NONE

/datum/reagent/medicine/mnestic
	name = "Class Y Mnestics"
	description = "You can never forget a dose of mnestics."
	color = "#a5a5a5"
	overdose_threshold = 25
	ph = 7
	taste_description = "almonds"
	chemical_flags = REAGENT_NO_RANDOM_RECIPE
	purge_multiplier = 0.15
	metabolized_traits = list(TRAIT_MNESTICS)

/datum/reagent/medicine/mnestic/on_mob_metabolize(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_big(span_hypnophrase("You feel more in control of what you remember.")))

/datum/reagent/medicine/mnestic/on_mob_end_metabolize(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_big(span_hypnophrase("You lose the force you had on your memories.")))

/datum/reagent/medicine/mnestic/overdose_process(mob/living/affected_carbon, seconds_per_tick, metabolization_ratio)
	affected_carbon.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.5 * seconds_per_tick * metabolization_ratio, required_organ_flag = affected_organ_flags)
	affected_carbon.adjust_confusion(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio)
	affected_carbon.adjust_staggered(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio)
	affected_carbon.adjust_eye_blur(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio)
	affected_carbon.adjust_drowsiness(0.5 SECONDS * normalise_creation_purity() * seconds_per_tick * metabolization_ratio)
	return TRUE


