/obj/item/pai_card_oculis
	name = "old personal AI device"
	desc = "An older model of the ever popular personal artificial intelligence system, originally made by Morpheus Cyberkinetics. They just don't make them like they used to..."
	icon = 'modular_oculis/modules/pai_oculis/icons/pai_old.dmi' //Sprites come from the ye olden days of pAIs, which I thought was fitting here. They also still look pretty good today.
	icon_state = "pai"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	resistance_flags = FIRE_PROOF | ACID_PROOF | INDESTRUCTIBLE
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP

	// The screen our pAI will be using
	var/datum/pai_screen_oculis/screen_image = /datum/pai_screen_oculis/on
	// The pAI the card belongs to
	var/mob/living/silicon/pai_oculis/pai
	// Whether the card's maintenance hatch is open
	var/in_maintenance = FALSE
	// Our minimum slots (magic numbers bad)
	var/minimum_upgrades = 0
	// How many upgrades we have
	var/installed_upgrades = 0
	// The maximum number of upgrades we can have
	var/max_upgrades = 3
	// The precise list of upgrades we have installed
	var/upgrades_list = list()

/obj/item/pai_card_oculis/Initialize(mapload)
	. = ..()
	update_appearance()
	ADD_TRAIT(src, TRAIT_CASTABLE_LOC, INNATE_TRAIT)

// Tools and how they interact with our card.

// Screwdriver to open the maintenance hatch.
/obj/item/pai_card_oculis/screwdriver_act(mob/living/user, obj/item/tool)
	user.visible_message(span_notice("[user] screws [in_maintenance? "closed" : "open"] [src]'s maintenance hatch."))
	tool.play_tool_sound(src)
	in_maintenance = !in_maintenance
	return

// Proc used to check whether the hatch is open.
/obj/item/pai_card_oculis/proc/is_open(mob/living/user)
	if(!in_maintenance)
		user.balloon_alert(user, "Open the maintenance hatch first!")
		return FALSE
	return TRUE

// Welding tool to handle brute repairs
/obj/item/pai_card_oculis/welder_act(mob/living/user, obj/item/tool)
	if(user.combat_mode && user != src)
		return NONE

	if(is_open(user))
		if(!pai.get_brute_loss())
			balloon_alert(user, "No damages to fix!")
			return ITEM_INTERACT_BLOCKING

		if(!tool.tool_start_check(user, amount=1, heat_required = HIGH_TEMPERATURE_REQUIRED))
			return ITEM_INTERACT_BLOCKING
		user.visible_message(span_notice("[user] begins to repair [pai]'s internal physical structure..."))
		if(!tool.use_tool(src, user, delay = 3 SECONDS, amount = 1, volume = 50))
			return ITEM_INTERACT_BLOCKING

		pai.adjust_brute_loss(-30)
		user.visible_message(span_notice("[user] repairs some of [pai]'s internal physical structure."))
		user.changeNext_move(CLICK_CD_MELEE)
		return ITEM_INTERACT_SUCCESS

// This is used for repairing burns with cable coil and applying pAI upgrades
/obj/item/pai_card_oculis/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/screwdriver))
		if(!is_open(user))
			return ITEM_INTERACT_BLOCKING
		if(istype(tool, /obj/item/stack/cable_coil))
			var/obj/item/stack/cable_coil/coil = tool
			if(!pai.get_fire_loss())
				balloon_alert(user, "No wire damage present!")
				return ITEM_INTERACT_BLOCKING
			if(!coil.use(1))
				balloon_alert(user, "Not enough cable!")
				return ITEM_INTERACT_BLOCKING
			pai.adjust_fire_loss(-30)
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			user.visible_message(span_notice("[user] repairs some of [pai]'s internal wiring."))
			user.changeNext_move(CLICK_CD_MELEE)
			return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/pai_upgrade))
		var/obj/item/pai_upgrade/L = tool
		L.upgrade_activate(src, user)
		return ITEM_INTERACT_SUCCESS

// Multitool to reboot if the pAI is dead
/obj/item/pai_card_oculis/multitool_act(mob/living/user, obj/item/multitool/tool)
	if(is_open(user))
		if(pai.stat == DEAD)
			if(!pai.get_brute_loss() && !pai.get_fire_loss())
				user.visible_message(span_notice("[user] starts to reboot [pai]..."))
				playsound(tool, 'sound/items/taperecorder/tape_flip.ogg', 50, TRUE)
				if(!do_after(user, 8 SECONDS, src))
					return
				pai.revive()
			else
				to_chat(user, span_alert("[pai] is too damaged to be re-activated! Fix them first."))
				return
		else
			to_chat(user, span_alert("[pai]'s systems are already active."))
			return

// Crowbar to remove all upgrades in the pAI
/obj/item/pai_card_oculis/crowbar_act(mob/living/user, obj/item/tool)
	if(is_open(user))
		for(var/obj/item/pai_upgrade/L as anything in upgrades_list)
			L.upgrade_remove()
		upgrades_list = list()
		installed_upgrades = minimum_upgrades
		to_chat(user, span_notice("You remove all of the upgrades inside [src]"))
		tool.play_tool_sound(src)

/obj/item/pai_card_oculis/Destroy()
	pai = null
	upgrades_list = null
	return ..()
