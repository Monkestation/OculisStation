// Neptune's Tear

/datum/chemical_reaction/drink/neptunes_tear
	results = list(/datum/reagent/consumable/ethanol/neptunes_tear = 5)
	required_reagents = list(
		/datum/reagent/bluespace = 1,
		/datum/reagent/consumable/ethanol/pod_tesla = 2,
		/datum/reagent/consumable/ethanol/blue_blazer = 2
	)

/datum/reagent/consumable/ethanol/neptunes_tear
	name = "Neptune's Tear"
	description = "A drink resembling an endless circular ocean."
	color = "#004dd4" // rgb: 0, 30, 83
	boozepwr = 60
	taste_description = "a tropical breeze"
	quality = DRINK_FANTASTIC
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/neptunes_tear
	required_drink_type = /datum/reagent/consumable/ethanol/neptunes_tear
	name = "Neptune's Tear"
	desc = "A drink resembling an endless circular ocean."
	icon = 'modular_oculis/modules/drinks/icons/drinks.dmi'
	icon_state =  "neptunes_tear"

// Drink of Legends

/datum/chemical_reaction/drink/drink_of_legends
	results = list(/datum/reagent/consumable/ethanol/drink_of_legends = 5)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/drink_of_virtue = 1,
		/datum/reagent/consumable/ethanol/pod_tesla = 1,
		/datum/reagent/consumable/ethanol/narsour = 1,
		/datum/reagent/consumable/ethanol/threemileisland = 1,
		/datum/reagent/consumable/ethanol/phil_stone = 1
	)

// See /datum/status_effect/drink_of_legends
/datum/reagent/consumable/ethanol/drink_of_legends
	name = "Drink of Legends"
	description = "A drink truly made for and by legends."
	color = "#00ff85" // rgb: 0, 100, 52
	boozepwr = 80
	taste_description = "a legendary burning sensation"
	quality = DRINK_FANTASTIC
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/drink_of_legends
	required_drink_type = /datum/reagent/consumable/ethanol/drink_of_legends
	name = "Drink of Legends"
	desc = "A drink truly made for and by legends."
	icon = 'modular_oculis/modules/drinks/icons/drinks.dmi'
	icon_state =  "drink_of_legends"

/datum/reagent/consumable/ethanol/drink_of_legends/on_mob_metabolize(mob/living/drinker)
	. = ..()
	to_chat(drinker, span_notice("You feel as if you have become a legend!"))
	drinker.apply_status_effect(/datum/status_effect/drink_of_legends)
	var/need_mob_update
	var/heal_points = 20
	var/heal_amt = min(volume, heal_points)
	need_mob_update = drinker.adjust_brute_loss(-heal_amt, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += drinker.adjust_fire_loss(-heal_amt, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += drinker.adjust_stamina_loss(max(-heal_amt * 5, -20), updating_stamina = FALSE, required_biotype = affected_biotype)

/datum/reagent/consumable/ethanol/drink_of_legends/on_mob_life(mob/living/drinker, seconds_per_tick, times_fired)
	. = ..()
	if(drinker.health > 0)
		var/need_mob_update
		need_mob_update = drinker.adjust_brute_loss(-1 * REM * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_fire_loss(-1 * REM * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_stamina_loss(-5 * REM * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/drink_of_legends/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	to_chat(drinker, span_notice("You feel yourself blend back into the crowd..."))
	drinker.remove_status_effect(/datum/status_effect/drink_of_legends)

// Philosopher's Stone

/datum/chemical_reaction/drink/phil_stone
	results = list(/datum/reagent/consumable/ethanol/phil_stone = 5)
	required_reagents = list(/datum/reagent/gold = 1, /datum/reagent/iron = 1, /datum/reagent/consumable/ethanol/banzai_ti = 3)

/datum/reagent/consumable/ethanol/phil_stone
	name = "Philosopher's Stone"
	description = "A drink emanating the essence of alchemy."
	color = "#de0014" // rgb: 87, 0, 8
	boozepwr = 60
	taste_description = "a mix of metals"
	quality = DRINK_FANTASTIC
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/phil_stone
	required_drink_type = /datum/reagent/consumable/ethanol/phil_stone
	name = "Philosopher's Stone"
	desc = "A drink emanating the essence of alchemy."
	icon = 'modular_oculis/modules/drinks/icons/drinks.dmi'
	icon_state =  "phil_stone"

// Avarice

/datum/chemical_reaction/drink/drink_of_avarice
	results = list(/datum/reagent/consumable/ethanol/drink_of_avarice = 5)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/beer = 1,
		/datum/reagent/consumable/pineapplejuice = 1,
		/datum/reagent/gold = 2,
		/datum/reagent/consumable/ethanol/wine_voltaic = 1
	)

/datum/reagent/consumable/ethanol/drink_of_avarice
	name = "Avarice"
	description = "A mug of endless greed."
	color = "#ffcc00" // rgb: 100, 80, 0
	boozepwr = 60
	taste_description = "a greedy bitterness"
	quality = DRINK_FANTASTIC
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/drink_of_avarice
	required_drink_type = /datum/reagent/consumable/ethanol/drink_of_avarice
	name = "Avarice"
	desc = "A mug of endless greed."
	icon = 'modular_oculis/modules/drinks/icons/drinks.dmi'
	icon_state =  "drink_of_avarice"

// Fury

/datum/chemical_reaction/drink/drink_of_fury
	results = list(/datum/reagent/consumable/ethanol/drink_of_fury = 5)
	required_reagents = list(/datum/reagent/consumable/capsaicin = 2, /datum/reagent/blood = 2, /datum/reagent/consumable/ethanol/wine = 1)

/datum/reagent/consumable/ethanol/drink_of_fury
	name = "Fury"
	description = "A cup of endless wrath."
	color = "#ed0033" // rgb: 93, 0, 20
	boozepwr = 60
	taste_description = "an indescrible rage"
	quality = DRINK_FANTASTIC
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/drink_of_fury
	required_drink_type = /datum/reagent/consumable/ethanol/drink_of_fury
	name = "Fury"
	desc = "A cup of endless wrath."
	icon = 'modular_oculis/modules/drinks/icons/drinks.dmi'
	icon_state =  "drink_of_fury"

/datum/reagent/consumable/ethanol/drink_of_fury/on_mob_metabolize(mob/living/drinker)
	. = ..()
	drinker.overlay_fullscreen("fury_screen_overlay", /atom/movable/screen/fullscreen/color_vision/red)

/datum/reagent/consumable/ethanol/drink_of_voracity/on_mob_life(mob/living/carbon/drinker)
	. = ..()
	if(prob(25))
		drinker.emote("scream")

/datum/reagent/consumable/ethanol/drink_of_fury/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	drinker.clear_fullscreen("fury_screen_overlay")

// Ardor

/datum/chemical_reaction/drink/drink_of_ardor
	results = list(/datum/reagent/consumable/ethanol/drink_of_ardor = 5)
	required_reagents = list(
		/datum/reagent/consumable/berryjuice = 1,
		/datum/reagent/consumable/ethanol/plumwine = 2,
		/datum/reagent/consumable/ethanol/sugar_rush = 1,
		/datum/reagent/consumable/ethanol/admiralty = 1,
	)

/datum/reagent/consumable/ethanol/drink_of_ardor
	name = "Ardor"
	description = "A glass of endless passion."
	color = "#cf6bed" // rgb: 81, 42, 93
	boozepwr = 60
	taste_description = "a warm rush of enthusiasm"
	quality = DRINK_FANTASTIC
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/drink_of_ardor
	required_drink_type = /datum/reagent/consumable/ethanol/drink_of_ardor
	name = "Ardor"
	desc = "A glass of endless passion."
	icon = 'modular_oculis/modules/drinks/icons/drinks.dmi'
	icon_state =  "drink_of_ardor"

// Languor

/datum/chemical_reaction/drink/drink_of_languor
	results = list(/datum/reagent/consumable/ethanol/drink_of_languor = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/antifreeze = 2, /datum/reagent/consumable/ethanol/dreadnog = 3)

/datum/reagent/consumable/ethanol/drink_of_languor
	name = "Languor"
	description = "A cup of endless sloth."
	color = "#2b3b80" // rgb: 17, 23, 50
	boozepwr = 60
	taste_description = "a boring mellowness"
	quality = DRINK_FANTASTIC
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/drink_of_languor
	required_drink_type = /datum/reagent/consumable/ethanol/drink_of_languor
	name = "Languor"
	desc = "A cup of endless sloth."
	icon = 'modular_oculis/modules/drinks/icons/drinks.dmi'
	icon_state =  "drink_of_languor"

// Vainglory

/datum/chemical_reaction/drink/drink_of_vainglory
	results = list(/datum/reagent/consumable/ethanol/drink_of_vainglory = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/singulo = 2, /datum/reagent/consumable/ethanol/kings_ransom = 2, /datum/reagent/consumable/bluecherryshake = 1)

/datum/reagent/consumable/ethanol/drink_of_vainglory
	name = "Vainglory"
	description = "A cup of endless pride."
	color = "#6e00b3" // rgb: 43, 23, 70
	boozepwr = 60
	taste_description = "the best thing you have ever consumed"
	quality = DRINK_FANTASTIC
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/drink_of_vainglory
	required_drink_type = /datum/reagent/consumable/ethanol/drink_of_vainglory
	name = "Vainglory"
	desc = "A cup of endless pride."
	icon = 'modular_oculis/modules/drinks/icons/drinks.dmi'
	icon_state =  "drink_of_vainglory"

// Voracity - NOT DONE - NOT DONE - NOT DONE - NOT DONE - ADD VOMIT IF YOU CAN AND REPLACE MOONSHINE

/datum/chemical_reaction/drink/drink_of_voracity
	results = list(/datum/reagent/consumable/ethanol/drink_of_voracity = 10)
	required_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/ethanol/moonshine = 1,
		/datum/reagent/consumable/ethanol/acid_spit = 2,
		/datum/reagent/consumable/cucumberjuice = 3,
		/datum/reagent/consumable/soymilk = 1,
		/datum/reagent/consumable/ethanol/suffering_bastard = 1
	)

/datum/reagent/consumable/ethanol/drink_of_voracity
	name = "Voracity"
	description = "A cup of endless gluttony."
	color = "#42ff00" // rgb: 26, 100, 0
	boozepwr = 90
	taste_description = "something overwhelmingly disgusting"
	quality = DRINK_REVOLTING
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/drink_of_voracity
	required_drink_type = /datum/reagent/consumable/ethanol/drink_of_voracity
	name = "Voracity"
	desc = "A cup of endless gluttony."
	icon = 'modular_oculis/modules/drinks/icons/drinks.dmi'
	icon_state =  "drink_of_voracity"

/datum/reagent/consumable/ethanol/drink_of_voracity/on_mob_metabolize(mob/living/carbon/drinker)
	. = ..()
	to_chat(drinker, span_notice("WHY DID YOU DRINK THAT!!!"))
	drinker.vomit(MOB_VOMIT_KNOCKDOWN, lost_nutrition = 10)

/datum/reagent/consumable/ethanol/drink_of_voracity/on_mob_life(mob/living/carbon/drinker)
	. = ..()
	if(drinker.nutrition > 10)
		drinker.vomit(MOB_VOMIT_FORCE, lost_nutrition = 10)
	else
		drinker.vomit(MOB_VOMIT_BLOOD)
		drinker.adjust_blood_volume(-10)

// Desire

/datum/chemical_reaction/drink/drink_of_desire
	results = list(/datum/reagent/consumable/ethanol/drink_of_desire = 10)
	required_reagents = list(/datum/reagent/water = 8, /datum/reagent/consumable/ethanol/screwdrivercocktail = 1, /datum/reagent/consumable/ethanol/sidecar = 1)

/datum/reagent/consumable/ethanol/drink_of_desire
	name = "Desire"
	description = "A cup of endless envy."
	color = "#ff7800" // rgb: 100, 47, 0
	boozepwr = 20
	taste_description = "something is missing"
	quality = DRINK_FANTASTIC
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/drink_of_desire
	required_drink_type = /datum/reagent/consumable/ethanol/drink_of_desire
	name = "Desire"
	desc = "A cup of endless envy."
	icon = 'modular_oculis/modules/drinks/icons/drinks.dmi'
	icon_state =  "drink_of_desire"

// Commandment

/datum/chemical_reaction/drink/drink_of_commandment
	results = list(/datum/reagent/consumable/ethanol/drink_of_commandment = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/quadruple_sec = 1, /datum/reagent/consumable/ethanol/dark_and_stormy = 1, /datum/reagent/consumable/ethanol/tizirian_sour = 2)

/datum/reagent/consumable/ethanol/drink_of_commandment
	name = "Commandment"
	description = "A cup of endless authority."
	color = "#404040" // rgb: 25, 25, 25
	boozepwr = 40
	taste_description = "that it is too pure for you"
	quality = DRINK_FANTASTIC
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/drink_of_commandment
	required_drink_type = /datum/reagent/consumable/ethanol/drink_of_commandment
	name = "Commandment"
	desc = "A cup of endless authority."
	icon = 'modular_oculis/modules/drinks/icons/drinks.dmi'
	icon_state =  "drink_of_commandment"

/datum/reagent/consumable/ethanol/drink_of_commandment/on_mob_metabolize(mob/living/drinker)
	. = ..()
	to_chat(drinker, span_notice("This drink was not meant for me"))
	var/need_mob_update
	need_mob_update += drinker.adjust_fire_loss(1, updating_health = FALSE, required_bodytype = affected_bodytype)

/datum/reagent/consumable/ethanol/drink_of_commandment/on_mob_life(mob/living/drinker, seconds_per_tick, times_fired)
	. = ..()
	if(drinker.health > 0)
		var/need_mob_update
		need_mob_update += drinker.adjust_fire_loss(1, updating_health = FALSE, required_bodytype = affected_bodytype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

// Virtue

/datum/chemical_reaction/drink/drink_of_virtue
	results = list(/datum/reagent/consumable/ethanol/drink_of_virtue = 10)
	required_reagents = list(
		/datum/reagent/consumable/ethanol/drink_of_commandment = 3,
		/datum/reagent/consumable/ethanol/drink_of_desire = 1,
		/datum/reagent/consumable/ethanol/drink_of_voracity = 1,
		/datum/reagent/consumable/ethanol/drink_of_vainglory = 1,
		/datum/reagent/consumable/ethanol/drink_of_languor = 1,
		/datum/reagent/consumable/ethanol/drink_of_ardor = 1,
		/datum/reagent/consumable/ethanol/drink_of_fury = 1,
		/datum/reagent/consumable/ethanol/drink_of_avarice = 1
	)

/datum/reagent/consumable/ethanol/drink_of_virtue
	name = "Virtue"
	description = "A cup of endless divinity."
	color = "#4db8ff" // rgb: 30, 72, 100
	boozepwr = 70
	taste_description = "something heavenly"
	quality = DRINK_FANTASTIC
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/drink_of_virtue
	required_drink_type = /datum/reagent/consumable/ethanol/drink_of_virtue
	name = "Virtue"
	desc = "A cup of endless divinity."
	icon = 'modular_oculis/modules/drinks/icons/drinks.dmi'
	icon_state =  "drink_of_virtue"
