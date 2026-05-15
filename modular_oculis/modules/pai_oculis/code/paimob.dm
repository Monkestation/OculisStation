//////////////////////
///Oculis pAI cards///
//////////////////////

/*
tl;dr an 'older' model of pAIs that aren't seen as much anymore, but still exist. Heavily inspired by baycode pAIs
*/

/datum/language_holder/pai_oculis
	understood_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
								/datum/language/machine = list(LANGUAGE_ATOM))

	spoken_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
							/datum/language/machine = list(LANGUAGE_ATOM))

/mob/living/silicon/pai_oculis
	name = "\proper pAI"
	desc = "The original pAI implementation, initially created by Morpheus Cyberkinetics. Rather than a simple holographic image projected by the card, these older models instead have a fully functional chassis. They just don't make them like they used to..."
	health = 100
	maxHealth = 100
	hud_type = /datum/hud/pai_oculis
	icon = 'icons/mob/silicon/pai.dmi'
	held_lh = 'icons/mob/inhands/pai_item_lh.dmi'
	held_rh = 'icons/mob/inhands/pai_item_rh.dmi'
	head_icon = 'icons/mob/clothing/head/pai_head.dmi'
	icon_state = "cat"
	layer = LOW_MOB_LAYER
	light_color = COLOR_PAI_GREEN
	light_flags = LIGHT_ATTACHED
	light_on = FALSE
	light_range = 3
	light_system = OVERLAY_LIGHT
	can_be_held = TRUE
	can_buckle_to = FALSE
	density = FALSE
	mob_size = MOB_SIZE_TINY
	worn_slot_flags = ITEM_SLOT_HEAD
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	mouse_opacity = MOUSE_OPACITY_ICON
	move_force = 0
	move_resist = 0
	pass_flags = PASSTABLE | PASSMOB
	pull_force = 0 //might come back to this and allow tiny objects (papers/pens/etc) to be pulled
	radio = /obj/item/radio/headset/silicon/pai
	initial_language_holder = /datum/language_holder/pai_oculis

	// Whether we can pilot exosuits. Currently for testing, will likely be removed once the robotics upgrade is implemented.
	var/can_pilot_mechs = TRUE
	// Whether we have the ability to fold out into chassis mode
	var/can_unfold = TRUE
	// Whether we're in card form or not
	var/is_in_card = TRUE
	// The card we inhabit
	var/obj/item/pai_card_oculis/card
	// The current chassis that will appear when in mobile form
	var/chassis = "cat"
	// The amount of storage we have for modules.
	var/storage = 100
	// The software we have installed
	var/list/installed_software = list()
	// Cable used when hacking doors
	var/obj/item/pai_cable/hacking_cable
	// What we have access to. Updated whenever someone swipes an ID card over us.
	var/list/pai_access = list()
	// List of available chassis
	var/static/list/possible_chassis = list(
		"bat" = TRUE,
		"bee" = TRUE,
		"butterfly" = TRUE,
		"carp" = TRUE,
		"cat" = TRUE,
		"chicken" = FALSE,
		"corgi" = TRUE,
		"crow" = TRUE,
		"duffel" = TRUE,
		"fox" = TRUE,
		"frog" = TRUE,
		"giant enemy spider" = TRUE,
		"hawk" = TRUE,
		"kitten" = FALSE,
		"lizard" = TRUE,
		"monkey" = TRUE,
		"mothroach" = TRUE,
		"mouse" = TRUE,
		"mushroom" = TRUE,
		"phantom" = TRUE,
		"puppy" = FALSE,
		"rabbit" = TRUE,
		"repairbot" = TRUE,
		"snake" = TRUE,
		"spider" = TRUE,
	)

/mob/living/silicon/pai_oculis/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSfastprocess, src)

	real_name = name
	// Make a card and shove us into it if one doesn't exist when spawning
	var/obj/item/pai_card_oculis/pai_card_oculis = loc
	if(!istype(pai_card_oculis))
		var/newcardloc = pai_card_oculis
		pai_card_oculis = new(newcardloc)
	card = pai_card_oculis
	forceMove(pai_card_oculis)
	card.pai = src

	// We don't get silicon level access
	REMOVE_TRAIT(src, TRAIT_SILICON_ACCESS, ROUNDSTART_TRAIT)

/mob/living/silicon/pai_oculis/update_icon_state()
	icon_state = resting ? "[chassis]_rest" : "[chassis]"
	held_state = "[chassis]"
	return ..()

/mob/living/silicon/pai_oculis/update_resting()
	. = ..()
	update_appearance(UPDATE_ICON_STATE)
	if(loc != card)
		visible_message(span_notice("[src] [resting? "lays down for a moment..." : "perks up from the ground."]"))

/mob/living/silicon/pai_oculis/proc/check_menu(atom/anchor)
	if(incapacitated)
		return FALSE
	if(get_turf(src) != get_turf(anchor))
		return FALSE
	if(!isturf(loc) && loc != card)
		balloon_alert(src, "can't do that here")
		return FALSE
	return TRUE

/mob/living/silicon/pai_oculis/get_access()
	return pai_access

/mob/living/silicon/pai_oculis/attackby(obj/item/item, mob/user, list/modifiers, list/attack_modifiers)
	// When someone swipes their ID card over us, we gain their access. This access does not stack.
	if(istype(item, /obj/item/card/id/advanced))
		pai_access = item.GetAccess()
		visible_message(span_alert("[user] swipes their ID card over [src], updating their access."))
		balloon_alert(src, "ACCESS UPDATED")
		return

/mob/living/silicon/pai_oculis/attack_hand(mob/living/carbon/human/user, list/modifiers)
	if(!user.combat_mode)
		visible_message(span_notice("[user] gently pats [src] on the head."))
		return

/mob/living/silicon/pai_oculis/emp_act(severity)
	. = ..()
	to_chat(src, span_danger("Warning: Electromagnetic pulse detected!"))
	if(. & EMP_PROTECT_SELF || QDELETED(src))
		return
	switch(severity)
		if(1)
			src.take_bodypart_damage(burn = 50)
			fold_in(forced = TRUE)
			return
		if(2)
			src.take_bodypart_damage(burn = 30)
			fold_in(forced = TRUE)
			return

// We have no laws, so we don't need to check for them or create new ones.
/mob/living/silicon/pai_oculis/show_laws()
	balloon_alert(src, "You have no laws!")
	return

/mob/living/silicon/pai_oculis/checklaws()
	balloon_alert(src, "You have no laws!")
	return

/mob/living/silicon/pai_oculis/death(gibbed)
	if(stat == DEAD)
		return
	set_stat(DEAD)
	update_sight()
	clear_fullscreens()
	update_health_hud()
	if(light_on)
		toggle_integrated_light()
	if(!is_in_card)
		fold_in(TRUE)
		can_unfold = FALSE
	ghostize()
