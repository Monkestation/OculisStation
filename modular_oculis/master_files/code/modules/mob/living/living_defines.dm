/mob/living
	/// Multiplier for medicine effect strength. Does not change consumption speed.
	var/medicine_effect_modifier = 1
	/// Multiplier for toxin effect strength. Does not change consumption speed.
	var/toxin_effect_modifier = 1
	/// Multiplier for ALL reagent metabolization speed. Applied after REAGENT_REVERSE_METABOLISM logic,
	/// so it uniformly speeds up or slows down everything regardless of reagent type.
	var/reagent_metabolism_boost = 1
