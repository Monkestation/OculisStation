/// Synths overheat instead of taking organ damage
/datum/reagent/drug/demoneye/proc/make_that_synth_sweat(mob/living/carbon/our_guy, seconds_per_tick, metabolization_ratio)
	var/heating = 3.8 * creation_purity * seconds_per_tick * metabolization_ratio
	our_guy.reagents?.chem_temp += heating
	our_guy.adjust_bodytemperature(heating * TEMPERATURE_DAMAGE_COEFFICIENT)
	our_guy.adjust_tox_loss(0.3 * seconds_per_tick * metabolization_ratio, updating_health = FALSE, required_biotype = ALL)
	if(ishuman(our_guy))
		var/mob/living/carbon/human/human = our_guy
		human.adjust_coretemperature(heating * TEMPERATURE_DAMAGE_COEFFICIENT)
