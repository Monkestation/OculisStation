
/datum/hud/pai_oculis
	ui_style = 'modular_oculis/modules/pai_oculis/icons/screen_pai.dmi' // Custom file in case someone wants to add sprites that are more fitting for the theme later on

/datum/hud/pai_oculis/initialize_screen_objects()
	. = ..()
	add_screen_object(/atom/movable/screen/language_menu, HUD_MOB_LANGUAGE_MENU, ui_style, ui_pai_language_menu)
	add_screen_object(/atom/movable/screen/navigate, HUD_MOB_NAVIGATE_MENU, ui_style, ui_pai_navigate_menu)
	add_screen_object(/atom/movable/screen/memories, HUD_MOB_MEMORIES, HUD_GROUP_STATIC, ui_style, ui_pai_memories_menu)
	add_screen_object(/atom/movable/screen/pai_oculis/software, HUD_PAI_SOFTWARE)
	add_screen_object(/atom/movable/screen/pai_oculis/shell, HUD_PAIOCU_SHELL)
	add_screen_object(/atom/movable/screen/pai_oculis/chassis, HUD_PAIOCU_CHASSIS)
	add_screen_object(/atom/movable/screen/pai/rest, HUD_MOB_REST)
	add_screen_object(/atom/movable/screen/pai/light, HUD_CYBORG_LAMP)
	add_screen_object(/atom/movable/screen/pai/newscaster, HUD_PAI_NEWSCASTER)
	add_screen_object(/atom/movable/screen/pai/internal_gps, HUD_PAI_GPS)
	add_screen_object(/atom/movable/screen/pai/image_take, HUD_AI_TAKE_IMAGE)
	add_screen_object(/atom/movable/screen/pai/image_view, HUD_AI_IMAGE_VIEW)
	add_screen_object(/atom/movable/screen/pai/radio, HUD_CYBORG_RADIO)
	add_screen_object(/atom/movable/screen/healths/robot, HUD_MOB_HEALTH, HUD_GROUP_INFO)

	update_software_buttons()

/datum/hud/pai_oculis/proc/update_software_buttons()
	var/mob/living/silicon/pai/owner = mymob
	for(var/button_key in screen_objects)
		var/atom/movable/screen/pai/button = screen_objects[button_key]
		if(istype(button) && button.required_software)
			button.color = owner.installed_software.Find(button.required_software) ? null : COLOR_GRAY

/atom/movable/screen/pai_oculis
	icon = 'icons/hud/screen_pai.dmi'
	mouse_over_pointer = MOUSE_HAND_POINTER
	var/required_software

/atom/movable/screen/pai_oculis/Click()
	if(isobserver(usr) || usr.incapacitated)
		return FALSE
	var/mob/living/silicon/pai_oculis/user = usr
	if(required_software && !user.installed_software.Find(required_software))
		to_chat(user, "You must download the required software to use this.")
		return FALSE
	return TRUE

// Custom screen object for switching chassis mode
/atom/movable/screen/pai_oculis/shell
	name = "Toggle Chassis Mode"
	icon_state = "pai_holoform"
	screen_loc = ui_pai_shell

/atom/movable/screen/pai_oculis/shell/Click()
	if(!..())
		return
	var/mob/living/silicon/pai_oculis/pAI = usr
	if(pAI.is_in_card)
		pAI.unfold()
	else
		pAI.fold_in()

// Custom screen object for switching chassis appearance
/atom/movable/screen/pai_oculis/chassis
	name = "Change Chassis Appearance"
	icon_state = "pai_chassis"
	screen_loc = ui_pai_chassis

/atom/movable/screen/pai_oculis/chassis/Click()
	if(!..())
		return
	var/mob/living/silicon/pai_oculis/pAI = usr
	pAI.choose_chassis()

/atom/movable/screen/pai_oculis/software
	name = "Software Interface"
	icon_state = "pai"
	screen_loc = ui_pai_software

/atom/movable/screen/pai_oculis/software/Click()
	if(!..())
		return
	var/mob/living/silicon/pai_oculis/pAI = usr
	pAI.ui_interact(pAI)
