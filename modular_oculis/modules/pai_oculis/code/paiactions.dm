// pAI fold/unfold procs

/mob/living/silicon/pai_oculis/proc/unfold()
	if(loc != card && !is_in_card)
		to_chat(usr, span_alert("You're already in mobile form!"))
		return

	if(!can_unfold)
		if(stat == DEAD)
			to_chat(usr, span_alert("You are dead!"))
			return
		to_chat(usr, span_alert("You can't do that right now!"))
		return

	forceMove(card.drop_location())
	card.forceMove(src)
	is_in_card = FALSE
	visible_message(span_notice("[src] folds outwards, expanding into a mobile form."))

/mob/living/silicon/pai_oculis/proc/fold_in(forced)
	if(loc == card && is_in_card)
		to_chat(usr, span_alert("You're already in card form!"))
		return
	if(istype(loc, /obj/vehicle/sealed/mecha))
		to_chat(usr, span_alert("You're connected to an exosuit, exit first!"))
		return
	if(forced)
		visible_message(span_alert("[src]'s chassis abruptly folds inward, compacting into a rectangulard card!"))
	else
		visible_message(span_notice("[src] neatly folds inwards, compacting down to a rectangular card."))

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
	set_chassis(choice)
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
