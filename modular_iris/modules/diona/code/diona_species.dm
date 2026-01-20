/datum/species/diona
	name = "\improper Diona"
	plural_form = "Dionae"
	id = SPECIES_DIONA
	sexes = FALSE //no sex for bug/plant people!
	inherent_traits = list(
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RESISTCOLD,
		TRAIT_NOBREATH,
		TRAIT_NO_DNA_COPY,
	)
	inherent_biotypes = MOB_HUMANOID | MOB_ORGANIC | MOB_BUG
	mutant_bodyparts = list("diona_leaves", "diona_thorns", "diona_flowers", "diona_moss", "diona_mushroom", "diona_antennae", "diona_eyes", "diona_pbody")
	mutant_organs = list(/obj/item/organ/nymph_organ/r_arm, /obj/item/organ/nymph_organ/l_arm, /obj/item/organ/nymph_organ/l_leg, /obj/item/organ/nymph_organ/r_leg, /obj/item/organ/nymph_organ/chest)
	inherent_factions = list(FACTION_PLANTS, FACTION_VINES, FACTION_DIONA)
	meat = /obj/item/food/meat/slab/human/mutant/diona
	exotic_bloodtype = /datum/blood_type/chlorophyll
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP
	species_language_holder = /datum/language_holder/diona
	bodytemp_normal = (BODYTEMP_NORMAL - 22) // Body temperature for dionae is much lower then humans as they are plants, supposed to be 15 celsius
	inert_mutation = /datum/mutation/drone
	death_sound = 'modular_iris/modules/diona/sounds/death.ogg'

	mutanteyes = /obj/item/organ/eyes/diona //SS14 sprite
	mutanttongue = /obj/item/organ/tongue/diona //Dungeon's sprite
	mutantbrain = /obj/item/organ/brain/diona //SS14 sprite
	mutantliver = /obj/item/organ/liver/diona //Dungeon's sprite
	mutantlungs = /obj/item/organ/lungs/diona //Dungeon's sprite
	mutantstomach = /obj/item/organ/stomach/diona //SS14 sprite
	mutantears = /obj/item/organ/ears/diona //SS14 sprite
	mutantheart = /obj/item/organ/heart/diona //Dungeon's sprite
	mutantappendix = null

	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/diona,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/diona,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/diona,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/diona,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/diona,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/diona,
	)

	var/datum/action/diona/split/split_ability //All dionae start with this, this is for splitting apart completely.
	var/datum/action/cooldown/diona/partition/partition_ability //All dionae start with this as well, this is for splitting off a nymph from food.
	var/datum/weakref/drone_ref

	var/time_spent_in_light

/mob/living/carbon/human/species/diona
	race = /datum/species/diona

/datum/species/diona/spec_life(mob/living/carbon/human/H)
	. = ..()
	if(H.fire_stacks < 1)
		H.adjust_fire_stacks(1) //VERY flammable

	if(H.nutrition < NUTRITION_LEVEL_STARVING)
		H.take_overall_damage(1, 0)
	if(H.nutrition > NUTRITION_LEVEL_ALMOST_FULL)
		H.set_nutrition(NUTRITION_LEVEL_ALMOST_FULL)

	if((H.health <= H.crit_threshold)) //Shit, we're dying! Scatter!
		split_ability.split(FALSE, H)

/datum/species/diona/proc/refresh_health(mob/living/carbon/human/diona)
	SIGNAL_HANDLER

	var/mob/living/basic/nymph/drone = drone_ref?.resolve()
	if(diona.stat != CONSCIOUS && !diona.mind && drone) //If the home body is not fully conscious, they dont have a mind and have a drone
		INVOKE_ASYNC(drone, TYPE_PROC_REF(/datum/action/nymph/SwitchFrom, Trigger))

/datum/species/diona/handle_radiation(mob/living/carbon/human/source, time_since_irradiated, seconds_per_tick)
	//Dionae heal and eat radiation for a living.
	source.adjust_nutrition(time_since_irradiated * 0.1 * seconds_per_tick)
	if(time_since_irradiated > RAD_MOB_HAIRLOSS)
		source.heal_overall_damage(brute = 1 * seconds_per_tick, burn = 1 * seconds_per_tick, required_bodytype = BODYTYPE_ORGANIC)
		source.adjust_tox_loss(-2 * seconds_per_tick)
		source.adjust_oxy_loss(-1 * seconds_per_tick)

/datum/species/diona/proc/on_projectile_hit(datum/source, atom/movable/firer, atom/target, angle)
	SIGNAL_HANDLER

	if(istype(source, /obj/projectile/energy/flora))
		var/mob/living/carbon/human/human_target = target
		human_target.set_nutrition(min(human_target.nutrition + 30, NUTRITION_LEVEL_FULL))

/datum/species/diona/proc/on_death(gibbed, mob/living/carbon/human/H)
	SIGNAL_HANDLER

	drone_ref = null
	if(gibbed)
		QDEL_NULL(H)
		return
	split_ability.split(gibbed, H)

/datum/species/diona/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons = TRUE, replace_missing = TRUE)
	. = ..()
	split_ability = new
	split_ability.Grant(human_who_gained_species)
	partition_ability = new
	partition_ability.Grant(human_who_gained_species)
	human_who_gained_species.update_mob_height()
	RegisterSignal(human_who_gained_species, COMSIG_LIVING_HEALTH_UPDATE, PROC_REF(refresh_health))
	RegisterSignal(human_who_gained_species, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	RegisterSignal(human_who_gained_species, COMSIG_PROJECTILE_ON_HIT, PROC_REF(on_projectile_hit))
	human_who_gained_species.add_movespeed_modifier(/datum/movespeed_modifier/diona, update = TRUE)

/datum/species/diona/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()
	split_ability.Remove(human)
	QDEL_NULL(split_ability)

	partition_ability.Remove(human)
	QDEL_NULL(partition_ability)

	qdel(drone_ref)
	UnregisterSignal(human, list(COMSIG_LIVING_HEALTH_UPDATE, COMSIG_LIVING_DEATH, COMSIG_PROJECTILE_ON_HIT))
	human.remove_movespeed_modifier(/datum/movespeed_modifier/diona, update = TRUE)
	human.update_mob_height()

// Diona are naturally taller than normal.
/datum/species/diona/update_species_heights(mob/living/carbon/human/holder)
	var/new_height = holder.get_mob_height()
	return new_height + 2

/datum/species/diona/help(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	. = ..()
	if(. && target != user && target.on_fire)
		user.balloon_alert(user, "[user] you hug [target]")
		target.visible_message(span_warning("[user] catches fire from hugging [target]!"), span_boldnotice("[user] catches fire hugging you!"), span_italics("You hear a fire crackling."))
		user.fire_stacks = target.fire_stacks
		if(user.fire_stacks > 0)
			user.ignite_mob()

//////////////////////////////////////// Action abilities ///////////////////////////////////////////////

/datum/action/diona/split
	name = "Split"
	desc = "Split into our seperate nymphs."
	background_icon_state = "bg_default"
	button_icon = 'modular_iris/modules/diona/icons/diona_actions.dmi'
	button_icon_state = "split"
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/diona/split/IsAvailable()
	return ..() && isdiona(owner)

/datum/action/diona/split/Trigger(mob/user, trigger_flags)
	. = ..()
	if(tgui_alert(usr, "Are we sure we wish to devolve ourselves and split into separated nymphs?",,list("Yes", "No")) != "Yes")
		return FALSE
	if(do_after(user, 8 SECONDS, user, hidden = TRUE))
		if(INCAPACITATED_IGNORING(user, INCAPABLE_RESTRAINTS)) //Second check incase the ability was activated RIGHT as we were being cuffed, and thus now in cuffs when this triggers
			return FALSE
		start_splitting(user) //This runs when you manually activate the ability.
		return TRUE
	return FALSE

/datum/action/diona/split/proc/start_splitting(mob/living/carbon/H)
	H.Stun(6 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(split), H), 5 SECONDS, TIMER_DELETE_ME)

/datum/action/diona/split/proc/split(mob/living/carbon/human/H)
	var/list/mob/living/basic/nymph/alive_nymphs = list()
	var/mob/living/basic/nymph/nymph = new(H.loc) //Spawn the player nymph, including this one, should be six total nymphs
	for(var/obj/item/bodypart/limb as anything in H.bodyparts)
		if(limb.limb_id != SPECIES_DIONA) //Robot limb? Ignore it.
			limb.drop_limb()
			continue

		// Exclude the head nymph from the alive_nymphs list, since that list is used for secondary consciousness transfer.
		if(istype(limb, /obj/item/bodypart/head))
			nymph.adjust_brute_loss(limb.brute_dam, updating_health = FALSE)
			nymph.adjust_fire_loss(limb.burn_dam, updating_health = FALSE)
			nymph.updatehealth()
			continue

		var/mob/living/basic/nymph/limb_nymph = new(H.loc)
		limb_nymph.adjust_brute_loss(limb.brute_dam, updating_health = FALSE)
		limb_nymph.adjust_fire_loss(limb.burn_dam, updating_health = FALSE)
		limb_nymph.updatehealth()
		if(limb_nymph.stat != DEAD)
			alive_nymphs += limb_nymph

	if(length(alive_nymphs))
		var/mob/living/basic/nymph/gambling_nymph = alive_nymphs[rand(1, length(alive_nymphs))] // Let's go gambling!
		gambling_nymph.adjust_brute_loss(50) // Aw dangit.
		alive_nymphs -= gambling_nymph //Remove it from the alive_nymphs list.

	if(nymph.stat == DEAD) //If the head nymph is dead, transfer all consciousness to the next best thing - an alive limb nymph!
		nymph = pick(alive_nymphs)
	for(var/obj/item/I in H.contents) //Drop the player's items on the ground
		H.dropItemToGround(I, TRUE)
		I.pixel_x = rand(-10, 10)
		I.pixel_y = rand(-10, 10)
	nymph.old_name = H.real_name
	nymph.features = H.dna.features
	H.mind?.transfer_to(nymph) //Move the player's mind datum to the player nymph
	H.mind?.grab_ghost() // Throw the fucking ghost back into the nymph.
	H.gib(TRUE, TRUE, TRUE)  //Gib the old corpse with nothing left of use

/datum/action/cooldown/diona/partition
	name = "Partition"
	desc = "Allow a nymph to partition from our gestalt self."
	background_icon_state = "bg_default"
	button_icon = 'modular_iris/modules/diona/icons/diona_actions.dmi'
	button_icon_state = "grow"
	cooldown_time = 5 MINUTES

/datum/action/cooldown/diona/partition/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/human/human_target = target
	StartCooldown()
	human_target.nutrition = NUTRITION_LEVEL_STARVING
	playsound(human_target, 'sound/mobs/non-humanoids/venus_trap/venus_trap_death.ogg', 25, 1)
	new /mob/living/basic/nymph(human_target.loc)

/datum/action/cooldown/diona/partition/IsAvailable(feedback)
	if(..())
		var/mob/living/carbon/human/H = owner
		if(H.nutrition >= NUTRITION_LEVEL_WELL_FED)
			return TRUE
		return FALSE

/////////////////////////////////// Dionae organs down here, special behavior stuffs ///////////////////////////////////////
/obj/item/organ/nymph_organ
	name = "diona nymph"
	desc = "You should not be seeing this, if you are, please contact a coder."
	icon = 'modular_iris/modules/diona/icons/nymph.dmi'
	icon_state = "nymph"

/obj/item/organ/nymph_organ/Remove(mob/living/carbon/organ_owner, special, pref_load)
	. = ..()
	if(istype(organ_owner, /mob/living/carbon/human/dummy) || special)
		return
	var/obj/item/bodypart/body_part = organ_owner.get_bodypart(zone)
	for(var/datum/surgery/organ_manipulation/surgery in organ_owner.surgeries)
		surgery.Destroy()
	if(istype(body_part, /obj/item/bodypart/chest)) //Does the same things as removing the brain would, since the torso is what keeps the diona together.
		organ_owner.death(FALSE)
		QDEL_NULL(src)
		return
	new /mob/living/basic/nymph(organ_owner.loc)
	QDEL_NULL(body_part)
	QDEL_NULL(src)
	organ_owner.update_body()

/obj/item/organ/nymph_organ/r_arm
	zone = BODY_ZONE_R_ARM
	slot = ORGAN_SLOT_R_ARM_NYMPH

/obj/item/organ/nymph_organ/l_arm
	zone = BODY_ZONE_L_ARM
	slot = ORGAN_SLOT_L_ARM_NYMPH

/obj/item/organ/nymph_organ/r_leg
	zone = BODY_ZONE_R_LEG
	slot = ORGAN_SLOT_R_LEG_NYMPH

/obj/item/organ/nymph_organ/l_leg
	zone = BODY_ZONE_L_LEG
	slot = ORGAN_SLOT_L_LEG_NYMPH

/obj/item/organ/nymph_organ/chest
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_CHEST_NYMPH


////////////////////////////////////// Preferences menu stuffs ////////////////////////////////////////////////////////////
/datum/species/diona/get_species_description()
	return "Dionae are the equivalent to a shambling mound of bug-like sentient plants \
	wearing a trenchoat and pretending to be a human. Commonly found basking in the \
	supermatter chamber during lunch breaks."

/datum/species/diona/get_species_lore()
	return list(
		"Dionae are a space-faring species of intensely curious sapient plant-bug-creatures, formed \
			by a collective of independent Diona, named 'Nymphs', gathering together to form a collective named a 'Gestalt', commonly \
			vaugely resembling a humanoid, although older collectives may grow into structures, or even floating asteroids in space.",

		"Dionae culture, for the most part, is nomadic, with Parent Gestalts splitting off a bud \
			that then goes off into the world to explore and gain knowledge for itself. Rarely, a handful of Gestalts may link up \
			in an agreed upon location to share knowledge, or to form a larger structure.",

		"As a collective of various individual nymphs with varying experiences,  \
			names can become rather tricky, thus, Dionae Gestalts settle upon a single core memory shared between all Nymphs \
			most commonly something from their younger years and expanding over time as they relook upon their memories, though \
			it's not unheard of for a Gestalt to fully change their name if they find a fresher memory represents them more."
	)

/datum/species/diona/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "sun-plant-wilt",
			SPECIES_PERK_NAME = "Photosynthetic",
			SPECIES_PERK_DESC = "You find radiation and light pretty tasty, but you can't live long without either!",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bugs",
			SPECIES_PERK_NAME = "Bugsplosion",
			SPECIES_PERK_DESC = "When you're about to die, you explode into a pile of bugs to escape, but you are very vulnerable in this state!",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "leaf",
			SPECIES_PERK_NAME = "Planty",
			SPECIES_PERK_DESC = "You're a plant! Bees quite like you, while you LOVE fertilizer and hate weedkiller.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fire",
			SPECIES_PERK_NAME = "Flammable",
			SPECIES_PERK_DESC = "The smallest flame can set you on fire, be careful!",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "weight-hanging",
			SPECIES_PERK_NAME = "Bulky",
			SPECIES_PERK_DESC = "As a plant, you aren't very nimble, walking takes more time for you.",
		),
	)
	return to_add

/datum/species/diona/get_laugh_sound(mob/living/carbon/user)
	return 'modular_iris/modules/diona/sounds/laugh.ogg'

/datum/species/diona/get_scream_sound(mob/living/carbon/user)
	return 'modular_iris/modules/diona/sounds/scream.ogg'

/datum/species/diona/get_sneeze_sound(mob/living/carbon/user)
	return 'modular_iris/modules/diona/sounds/sneeze.ogg'
