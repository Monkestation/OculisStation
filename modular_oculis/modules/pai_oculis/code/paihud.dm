
/datum/hud/pai_oculis
	ui_style = 'modular_oculis/modules/pai_oculis/icons/screen_pai.dmi' // Custom file in case someone wants to add sprites that are more fitting for the theme later on

/datum/hud/pai_oculis/initialize_screen_objects()
	. = ..()
	add_screen_object(/atom/movable/screen/language_menu, HUD_MOB_LANGUAGE_MENU, ui_style, ui_pai_language_menu)
	add_screen_object(/atom/movable/screen/navigate, HUD_MOB_NAVIGATE_MENU, ui_style, ui_pai_navigate_menu)
	add_screen_object(/atom/movable/screen/memories, HUD_MOB_MEMORIES, HUD_GROUP_STATIC, ui_style, ui_pai_memories_menu)
	add_screen_object(/atom/movable/screen/pai/software, HUD_PAI_SOFTWARE)
	add_screen_object(/atom/movable/screen/pai/shell, HUD_PAI_SHELL) // TODO: Make custom screen objects that use the word 'chassis' rather than 'holo-'
	add_screen_object(/atom/movable/screen/pai/chassis, HUD_PAI_CHASSIS) // See comment for shell screen object above
	add_screen_object(/atom/movable/screen/pai/rest, HUD_MOB_REST)
	add_screen_object(/atom/movable/screen/pai/light, HUD_CYBORG_LAMP)
	add_screen_object(/atom/movable/screen/pai/newscaster, HUD_PAI_NEWSCASTER)
	add_screen_object(/atom/movable/screen/pai/host_monitor, HUD_PAI_HOST_MONITOR)
	add_screen_object(/atom/movable/screen/pai/crew_manifest, HUD_AI_CREW_MANIFEST)
	add_screen_object(/atom/movable/screen/pai/internal_gps, HUD_PAI_GPS)
	add_screen_object(/atom/movable/screen/pai/image_take, HUD_AI_TAKE_IMAGE)
	add_screen_object(/atom/movable/screen/pai/image_view, HUD_AI_IMAGE_VIEW)
	add_screen_object(/atom/movable/screen/pai/radio, HUD_CYBORG_RADIO)
	add_screen_object(/atom/movable/screen/pai/modpc, HUD_SILICON_TABLET)
	add_screen_object(/atom/movable/screen/healths/robot, HUD_MOB_HEALTH, HUD_GROUP_INFO)

	update_software_buttons()

/datum/hud/pai_oculis/proc/update_software_buttons()
	var/mob/living/silicon/pai/owner = mymob
	for(var/button_key in screen_objects)
		var/atom/movable/screen/pai/button = screen_objects[button_key]
		if(istype(button) && button.required_software)
			button.color = owner.installed_software.Find(button.required_software) ? null : COLOR_GRAY
