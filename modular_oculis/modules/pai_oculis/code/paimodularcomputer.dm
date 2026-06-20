/obj/item/modular_computer/pda/silicon/paioculis
	starting_programs = list(
		/datum/computer_file/program/filemanager,
		/datum/computer_file/program/crew_manifest,
		/datum/computer_file/program/messenger,
		/datum/computer_file/program/chatclient,
	)

// No need to turn off the system at any point, so we just don't do anything.
/obj/item/modular_computer/pda/silicon/paioculis/shutdown_computer(loud = TRUE)
	return
