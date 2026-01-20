/obj/item/organ/eyes/diona
	name = "receptor node"
	desc = "A combination of plant matter and neurons used to produce visual feedback."
	icon_state = "diona_eyeballs"
	organ_flags = ORGAN_UNREMOVABLE
	flash_protect = FLASH_PROTECTION_SENSITIVE

/obj/item/organ/tongue/diona
	name = "diona tongue"
	desc = "It's an odd tongue, seemingly made of plant matter."
	icon_state = "diona_tongue"
	say_mod = "rustles"
	modifies_speech = TRUE
	disliked_foodtypes = DAIRY | FRUIT | GRAIN | CLOTH | VEGETABLES
	liked_foodtypes = MEAT | RAW

/obj/item/organ/tongue/diona/on_mob_insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	set_say_modifiers(signer, "quivers", "ripples", "swishes", "shrieks")

/obj/item/organ/tongue/diona/on_mob_remove(mob/living/carbon/speaker, special = FALSE)
	. = ..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_yell = initial(verb_yell)

/obj/item/organ/brain/diona
	name = "diona nymph"
	desc = "A small mass of roots and plant matter, it looks to be moving."
	icon_state = "diona_brain"
	decoy_override = TRUE

/obj/item/organ/brain/diona/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	if(special)
		return
	organ_owner.death(FALSE)
	QDEL_NULL(src)

/obj/item/organ/liver/diona
	name = "liverwort"
	desc = "A mass of plant vines and leaves, seeming to be responsible for chemical digestion."
	icon_state = "diona_liver"

/obj/item/organ/liver/diona/handle_chemical(mob/living/carbon/organ_owner, datum/reagent/chem, seconds_per_tick, times_fired)
	. = ..()
	// parent returned COMSIG_MOB_STOP_REAGENT_TICK or we are failing
	if((. & COMSIG_MOB_STOP_REAGENT_TICK) || (organ_flags & ORGAN_FAILING))
		return
	if(istype(chem, /datum/reagent/toxin/plantbgone))
		organ_owner.adjust_tox_loss(3)
		organ_owner.reagents.remove_reagent(chem.type, chem.metabolization_rate)
	if(istype(chem, /datum/reagent/toxin/mutagen))
		organ_owner.adjust_tox_loss(-3)
		organ_owner.reagents.remove_reagent(chem.type, chem.metabolization_rate)
	if(istype(chem, /datum/reagent/plantnutriment))
		organ_owner.adjust_brute_loss(-1)
		organ_owner.adjust_fire_loss(-1)
		organ_owner.reagents.remove_reagent(chem.type, chem.metabolization_rate)
	return

/obj/item/organ/lungs/diona
	name = "diona leaves"
	desc = "A small mass concentrated leaves, used for breathing."
	icon_state = "diona_lungs"

/obj/item/organ/stomach/diona
	name = "nutrient vessel"
	desc = "A group of plant matter and vines, useful for digestion of light and radiation."
	icon_state = "diona_stomach"

/obj/item/organ/ears/diona
	name = "trichomes"
	icon_state = "diona_ears"
	desc = "A pair of plant matter based ears."

/obj/item/organ/heart/diona
	name = "polypment segment"
	desc = "A segment of plant matter that is resposible for pumping nutrients around the body."
	icon_state = "diona_heart"
