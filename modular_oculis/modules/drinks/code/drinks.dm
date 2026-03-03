// Neptune's Tear

/datum/chemical_reaction/drink/neptunes_tear
	results = list(/datum/reagent/consumable/ethanol/neptunes_tear = 5)
	required_reagents = list(/datum/reagent/bluespace = 1, /datum/reagent/consumable/ethanol/pod_tesla = 2, /datum/reagent/consumable/ethanol/blue_blazer = 2)

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
	required_reagents = list(/datum/reagent/consumable/ethanol/quintuple_sec = 1, /datum/reagent/consumable/ethanol/pod_tesla = 1, /datum/reagent/consumable/ethanol/narsour = 1, /datum/reagent/consumable/ethanol/threemileisland = 1, /datum/reagent/consumable/ethanol/phil_stone = 1)

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
	required_reagents = list(/datum/reagent/consumable/ethanol/beer = 1, /datum/reagent/consumable/pineapplejuice = 1, /datum/reagent/gold = 2, /datum/reagent/consumable/ethanol/wine_voltaic = 1)

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
