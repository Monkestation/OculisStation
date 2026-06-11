/datum/species/arachnid
	name = "\improper Arachnid"
	plural_form = "Arachnids"
	id = SPECIES_ARACHNID
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID | MOB_BUG

	mutant_organs = list(/obj/item/organ/silkgland)

	//sexes = FALSE // arachnids are sexless, sadly this nukes the pronoun picker, which is sad so we have to comment it out =c
	meat = /obj/item/food/meat/slab/spider

	species_language_holder = /datum/language_holder/fly

	mutanttongue = /obj/item/organ/tongue/arachnid
	mutanteyes = /obj/item/organ/eyes/night_vision/arachnid
	mutantheart = /obj/item/organ/heart/arachnid

	exotic_bloodtype = /datum/blood_type/arachnid
	inherent_factions = list(FACTION_SPIDER)
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/arachnid,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/arachnid,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/arachnid,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/arachnid,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/arachnid,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/arachnid,
	)

/datum/species/arachnid/get_default_mutant_bodyparts()
	return list(
		FEATURE_ARACHNID_APPENDAGES = MUTPART_BLUEPRINT("Long", is_randomizable = TRUE),
		FEATURE_ARACHNID_CHELICERAE = MUTPART_BLUEPRINT("Basic", is_randomizable = TRUE),
	)

/datum/species/arachnid/randomize_features()
	var/list/features = ..()
	features[FEATURE_MUTANT_COLOR] = "#e9e9e9"
	return features

/datum/species/arachnid/get_scream_sound(mob/living/carbon/human/arachnid)
	return 'modular_oculis/modules/arachnids/sound/arachnid_scream.ogg'

/datum/species/arachnid/get_laugh_sound(mob/living/carbon/human/arachnid)
	return 'modular_oculis/modules/arachnids/sound/arachnid_laugh.ogg'



// TODO: make this shit work
/*
/datum/species/arachnid/handle_chemical(datum/reagent/chem, mob/living/carbon/human/H, seconds_per_tick, times_fired)
	if(chem.type == /datum/reagent/toxin/pestkiller)
		H.adjustToxLoss(3 * REM * seconds_per_tick)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM * seconds_per_tick)
		return TRUE
	return ..()
*/

/datum/species/arachnid/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load)
	. = ..()
	RegisterSignal(human_who_gained_species, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, PROC_REF(damage_weakness))

/datum/species/arachnid/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS)

/datum/species/arachnid/proc/damage_weakness(datum/source, list/damage_mods, damage_amount, damagetype, def_zone, sharpness, attack_direction, obj/item/attacking_item)
	SIGNAL_HANDLER

	if(istype(attacking_item, /obj/item/melee/flyswatter))
		damage_mods += 30 // Yes, a 30x damage modifier

/datum/species/arachnid/get_species_description()
	return "Arachnids are a species of humanoid spiders from a planet long lost to history. \
	They are known for their useful silks, which have saved lives in emergencies." // Allan please add details

/datum/species/arachnid/prepare_human_for_preview(mob/living/carbon/human/arachnid)
	arachnid.set_eye_color("#4c4c1c", "#4c4c1c")
	arachnid.dna.features[FEATURE_MUTANT_COLOR] = "#e9e9e9"
	arachnid.dna.mutant_bodyparts[FEATURE_ARACHNID_CHELICERAE] = build_mutant_part("Basic")
	arachnid.dna.mutant_bodyparts[FEATURE_ARACHNID_APPENDAGES] = build_mutant_part("Zigzag")
	regenerate_organs(arachnid, src, visual_only = TRUE)
	arachnid.update_body(is_creating = TRUE)

/datum/species/arachnid/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "spider",
			SPECIES_PERK_NAME = "Sericulture",
			SPECIES_PERK_DESC = "Arachnids have a silk gland organ that connects to their wrists, \
			allowing them to convert nutrition into silk related items and furniture.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bolt",
			SPECIES_PERK_NAME = "Agile",
			SPECIES_PERK_DESC = "Arachnids run slightly faster than other species, but are still outpaced by Goblins.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "spider",
			SPECIES_PERK_NAME = "Big Appendages",
			SPECIES_PERK_DESC = "Arachnids have appendages that are not hidden by space suits \
			or MODsuits. This can make concealing your identity harder.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "sun",
			SPECIES_PERK_NAME = "Maybe Too Many Eyes",
			SPECIES_PERK_DESC = "Arachnids cannot equip any kind of eyewear, requiring \
			alternatives like welding helmets or implants. Their eyes have night vision however.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fist-raised",
			SPECIES_PERK_NAME = "Arachnid Biology",
			SPECIES_PERK_DESC = "Fly swatters and pest killer will deal significantly higher amounts of damage to an Arachnid.",
		),
	)

	return to_add

/datum/reagent/mutationtoxin/arachnid
	name = "Arachnid Mutation Toxin"
	description = "A spidering toxin."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/arachnid
	taste_description = "webs"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/chemical_reaction/arachnid_mutationtoxin
	results = list(/datum/reagent/mutationtoxin/arachnid = 1)
	required_reagents = list(/datum/reagent/toxin = 1, /datum/reagent/mutationtoxin/lizard = 1)
	reaction_tags = REACTION_TAG_HARD


/mob/living/carbon/human/species/arachnid
	race = /datum/species/arachnid
