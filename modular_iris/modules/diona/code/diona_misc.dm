// Language shenanigens!
/datum/language_holder/diona
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/sylvan = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/sylvan = list(LANGUAGE_ATOM),
	)

/datum/language/sylvan
	name = "Sylvan"
	desc = "A complicated, ancient language spoken by sentient plants."
	key = "h"
	space_chance = 20
	syllables = list(
		"fii", "sii", "rii", "rel", "maa", "ala", "san", "tol", "tok", "dia", "eres",
		"fal", "tis", "bis", "qel", "aras", "losk", "rasa", "eob", "hil", "tanl", "aere",
		"fer", "bal", "pii", "dala", "ban", "foe", "doa", "cii", "uis", "mel", "wex",
		"incas", "int", "elc", "ent", "aws", "qip", "nas", "vil", "jens", "dila", "fa",
		"la", "re", "do", "ji", "ae", "so", "qe", "ce", "na", "mo", "ha", "yu"
	)
	icon_state = "plant"
	default_priority = 90

/datum/language/sylvan/get_random_name(
	gender = NEUTER,
	name_count = default_name_count,
	syllable_min = default_name_syllable_min,
	syllable_max = default_name_syllable_max,
	force_use_syllables = FALSE,
)
	if(force_use_syllables)
		return ..()

	return "[pick(GLOB.diona_names)]"

// Diona movespeed modifier, used to make them slower
/datum/movespeed_modifier/diona
	multiplicative_slowdown = 1.5

// Diona meat!
/obj/item/food/meat/slab/human/mutant/diona
	name = "diona meat"
	icon_state = "plantmeat"
	desc = "All the joys of healthy eating with all the fun of cannibalism."
	tastes = list("salad" = 1, "wood" = 1, "bitterness" = 1)
	foodtypes = VEGETABLES
	venue_value = FOOD_MEAT_MUTANT

/obj/item/food/meat/slab/human/mutant/diona/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain/human/diona, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/human/mutant/diona/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dryable, /obj/item/food/sosjerky/healthy/diona)

/obj/item/food/meat/steak/plain/human/diona
	name = "diona steak"
	tastes = list("salad" = 3, "plant fibre" = 1)
	foodtypes = VEGETABLES

/obj/item/food/sosjerky/healthy/diona
	name = "vegetable jerky"
	desc = "Homemade meat-imitating vegetable jerky. \nThis product has NOT been approved by the ethics commitee. \nMay be offensive to some plant-based crewmembers."
	icon = 'modular_iris/modules/diona/icons/diona_food.dmi'
	icon_state = "sosjerky_vegan"
	tastes = list("dried beets" = 3, "fermented tomatoes" = 2, "lettuce" = 2, "vegetarian guilt" = 1)
	foodtypes = JUNKFOOD | VEGETABLES
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6	//very healthy! go butcher your diona coworker!
	)

// Diona bloodtypes!
/datum/blood_type/chlorophyll
	name = BLOOD_TYPE_DIONA
	dna_string = "Chlorophyll"
	color = BLOOD_COLOR_XENO // Close enough.
	reagent_type = /datum/reagent/consumable/chlorophyll
	restoration_chem = /datum/reagent/consumable/chlorophyll
	blood_flags = BLOOD_COVER_ALL

/datum/blood_type/chlorophyll/set_up_blood(obj/effect/decal/cleanable/blood/blood, new_splat = FALSE)
	. = ..()
	if (!new_splat)
		return

	// Always force our decals to have our reagent, we don't want liquid gibs from oily guts
	blood.decal_reagent = reagent_type

/datum/reagent/consumable/chlorophyll
	name = "Liquid Chlorophyll"
	description = "A plant-specific elixir of life."
	nutriment_factor = 5 * REAGENTS_METABOLISM
	color = "#00df30"
	taste_description = "bitter, dry, broccoli soup"
