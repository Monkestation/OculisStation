// pAI screen image datums

/datum/pai_screen_oculis
	var/name
	var/icon/icon = 'modular_oculis/modules/pai_oculis/icons/pai_old.dmi'
	var/icon_state

	name = "Off"
/datum/pai_screen_oculis/off
	name = "Off"
	icon_state = "pai-off"

/datum/pai_screen_oculis/on
	name = "On"
	icon_state = "pai-on"

/datum/pai_screen_oculis/dead
	name = "Dead"
	icon_state = "pai-dead"

/datum/pai_screen_oculis/what
	name = "What"
	icon_state = "pai-what"

/datum/pai_screen_oculis/sad
	name = "Sad"
	icon_state = "pai-sad"

/datum/pai_screen_oculis/laugh
	name = "Laugh"
	icon_state = "pai-laugh"

/datum/pai_screen_oculis/happy
	name = "Happy"
	icon_state = "pai-happy"

/datum/pai_screen_oculis/extremely_happy
	name = "Extremely Happy"
	icon_state = "pai-extremely-happy"

/datum/pai_screen_oculis/cat
	name = "Cat"
	icon_state = "pai-cat"

/datum/pai_screen_oculis/angry
	name = "Angry"
	icon_state = "pai-angry"

/obj/item/pai_card_oculis/update_overlays()
	. = ..()
	. += image(icon = screen_image.icon, icon_state = screen_image.icon_state)

// Updates the screen appearance if the card's screen image is VV'd
/obj/item/pai_card_oculis/vv_edit_var(vname, vval)
	. = ..()
	if(vname == NAMEOF(src, screen_image))
		update_appearance()
