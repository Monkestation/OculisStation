// pAI fold/unfold procs

/mob/living/silicon/pai_oculis/proc/unfold(forced = FALSE)
	if(loc != card && !is_in_card)
		to_chat(usr, span_alert("You're already in mobile form!"))
		return

	if(stat == DEAD)
		to_chat(usr, span_alert("You are dead!"))
		return

	if(!can_switch_forms)
		to_chat(usr, span_alert("System reconfiguring, please stand by..."))
		return

	playsound(src, 'sound/items/tools/ratchet.ogg', 50, TRUE)
	forceMove(card.drop_location())
	card.forceMove(src)
	is_in_card = FALSE
	can_switch_forms = FALSE
	if(forced)
		visible_message(span_danger("[src] abruptly folds outwards, forcefully entering their mobile form!"))
		to_chat(src, span_danger("DEBUG COMMAND 'FORCE CHASSIS' HAS BEEN RUN BY AN EXTERNAL SOURCE!"))
		addtimer(VARSET_CALLBACK(src, can_switch_forms, TRUE), CHASSIS_OVERLOAD_COOLDOWN)
		return
	visible_message(span_notice("[src] folds outwards, expanding into a mobile form."))
	addtimer(VARSET_CALLBACK(src, can_switch_forms, TRUE), CHASSIS_COOLDOWN)

/mob/living/silicon/pai_oculis/proc/fold_in(forced = FALSE)
	if(loc == card && is_in_card)
		to_chat(usr, span_alert("You're already in card form!"))
		return
	if(istype(loc, /obj/vehicle/sealed/mecha))
		to_chat(usr, span_alert("You're connected to an exosuit, exit first!"))
		return
	if(!can_switch_forms)
		to_chat(usr, span_danger("System reconfiguring, please stand by..."))
		return
	can_switch_forms = FALSE
	if(forced)
		visible_message(span_alert("[src]'s chassis abruptly folds inward, compacting into a rectangular card!"))
		to_chat(src, span_danger("ERROR: Chassis motor functions misalignment detected, entering maintenance mode..."))
		addtimer(VARSET_CALLBACK(src, can_switch_forms, TRUE), CHASSIS_OVERLOAD_COOLDOWN)
	else
		visible_message(span_notice("[src] neatly folds inwards, compacting down to a rectangular card."))
		addtimer(VARSET_CALLBACK(src, can_switch_forms, TRUE), CHASSIS_COOLDOWN)

	playsound(src, 'sound/items/tools/ratchet.ogg', 50, TRUE)
	stop_pulling()
	resting = FALSE
	anchored = FALSE
	card.forceMove(drop_location())
	forceMove(drop_location())
	forceMove(card)
	is_in_card = TRUE

// pAI chassis selection command
/mob/living/silicon/pai_oculis/proc/choose_chassis()
	var/list/skins = list()
	for(var/chassis_option in possible_chassis)
		var/image/item_image = image(icon = src.icon, icon_state = chassis_option)
		skins+= list ("[chassis_option]" = item_image)
	sort_list(skins)
	var/atom/anchor = get_atom_on_turf(src)
	var/choice = show_radial_menu(src, anchor, skins, custom_check = CALLBACK(src, PROC_REF(check_menu), anchor), radius = 40, require_near = TRUE)
	if(!choice)
		return FALSE

	//We aren't a holochassis that can switch at will, but a mechanical, robotic body. It takes a few seconds to transform into another shape.
	if(!do_after(src, 3 SECONDS, src))
		to_chat(src, span_alert("You need to stay still for this!"))
		return
	set_chassis(choice)
	playsound(src, 'sound/items/tools/rped.ogg', 50, TRUE)
	balloon_alert(src, "Now using the [choice] chassis form.")
	update_resting()
	return TRUE

/mob/living/silicon/pai_oculis/proc/set_chassis(choice)
	if(!choice)
		return FALSE
	chassis = choice
	update_appearance(UPDATE_DESC | UPDATE_ICON_STATE)
	return TRUE

/mob/living/silicon/pai_oculis/proc/toggle_integrated_light()
	set_light_on(!light_on)
	return TRUE
