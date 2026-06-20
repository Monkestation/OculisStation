// tgui shenanigans

/obj/item/pai_card_oculis/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PaiCardOculis", "Debug Menu ([pai.name])")
		ui.open()

/obj/item/pai_card_oculis/ui_data(mob/user)
	var/list/data = list()
	data["health"] = pai.health
	data["maxHealth"] = pai.maxHealth
	data["name"] = pai.name

	return data

/obj/item/pai_card_oculis/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(action == "clearaccess")
		to_chat(usr, span_notice("You clear [pai.name]'s access credentials!"))
		pai.clear_access()
	if(action == "unfold")
		if(!pai.can_switch_forms)
			to_chat(usr,span_danger("[src] displays an error; something is preventing its internal mechanisms from functioning properly!"))
			return
		pai.unfold(TRUE)
