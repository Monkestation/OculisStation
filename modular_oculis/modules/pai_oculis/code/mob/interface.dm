/mob/living/silicon/pai_oculis/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new (user, src, "PaiInterfaceOculis", "System Interface: [src]")
		ui.open()

/mob/living/silicon/pai_oculis/ui_data(mob/user)
	var/list/data = list()
	data["name"] = name
	data["health"] = health
	data["maxHealth"] = maxHealth

	return data

/mob/living/silicon/pai_oculis/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(action == "openpda")
		modularInterface?.interact(src)

	// Screen settings. There's probably a better way to do this, but uhhhhhhhhhhhhhhhhhhhhh
	if(action == "screenon")
		card.screen_image = /datum/pai_screen_oculis/on
		card.update_appearance()
	if(action == "screenwhat")
		card.screen_image = /datum/pai_screen_oculis/what
		card.update_appearance()
	if(action == "screensad")
		card.screen_image = /datum/pai_screen_oculis/sad
		card.update_appearance()
	if(action == "screenlaugh")
		card.screen_image = /datum/pai_screen_oculis/laugh
		card.update_appearance()
	if(action == "screenhappy")
		card.screen_image = /datum/pai_screen_oculis/happy
		card.update_appearance()
	if(action == "screenehappy")
		card.screen_image = /datum/pai_screen_oculis/extremely_happy
		card.update_appearance()
	if(action == "screencat")
		card.screen_image = /datum/pai_screen_oculis/cat
		card.update_appearance()
	if(action == "screenangry")
		card.screen_image = /datum/pai_screen_oculis/angry
		card.update_appearance()
