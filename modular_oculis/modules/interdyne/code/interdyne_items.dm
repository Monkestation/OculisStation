// ITEM

/obj/item/modular_computer/pda/interdyne
	name = "Interdyne PDA"
	greyscale_config = /datum/greyscale_config/tablet/stripe_thick
	greyscale_colors = "#1A1A1A#1B5E20#2E8B57"
	device_theme = PDA_THEME_TERMINAL
	saved_identification = "Interdyne Employee"

/obj/item/modular_computer/pda/interdyne/Initialize(mapload)
	. = ..()
	var/datum/computer_file/program/messenger/msg = locate() in stored_files
	if(msg)
		msg.invisible = TRUE
