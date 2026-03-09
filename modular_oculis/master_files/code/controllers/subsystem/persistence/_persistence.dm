/datum/controller/subsystem/persistence
	var/collected = FALSE

/datum/controller/subsystem/persistence/collect_data()
	. = ..()
	collected = TRUE

/datum/controller/subsystem/persistence/Shutdown()
	if(!collected)
		collect_data()
