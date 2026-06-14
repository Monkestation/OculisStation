/obj/machinery/fax/Initialize(mapload)
	special_networks += list(
		castor_psych = list(fax_name = "Castor Psychologist's Office", fax_id = "castor_psych", color = "green", emag_needed = FALSE),
		castor_intern = list(fax_name = "Castor Intern's Office", fax_id = "castor_intern", color = "green", emag_needed = FALSE),
		castor_SC = list(fax_name = "Sectorial Commander's Office", fax_id = "castor_SC", color = "green", emag_needed = FALSE),
		castor_SPA = list(fax_name = "Sectorial Personnel Administrator's Office", fax_id = "castor_SPA", color = "green", emag_needed = FALSE),
		castor_SSA = list(fax_name = "Sectorial Security Administrator's Office", fax_id = "castor_SSA", color = "green", emag_needed = FALSE),
		castor_SRA = list(fax_name = "Sectorial Research Administrator's Office", fax_id = "castor_SRA", color = "green", emag_needed = FALSE),
		castor_SMA = list(fax_name = "Sectorial Medical Administrator's Office", fax_id = "castor_SMA", color = "green", emag_needed = FALSE),
		castor_SLA = list(fax_name = "Sectorial Logistics Administrator's Office", fax_id = "castor_SLA", color = "green", emag_needed = FALSE),
		castor_SEA = list(fax_name = "Sectorial Engineering Administrator's Office", fax_id = "castor_SEA", color = "green", emag_needed = FALSE),
		castor_SIAA = list(fax_name = "Sectorial Internal Affairs Administrator's Office", fax_id = "castor_SIAA", color = "green", emag_needed = FALSE),
	)
	return ..()

// Separate from the /admin type, to not collide with the conficting init. Requires a fax_id specified when mapping!
/obj/machinery/fax/castor
	name = "Castor Fax Machine"

/obj/machinery/fax/castor/Initialize(mapload)
	. = ..()
	if(!fax_id)
		return
	fax_name = special_networks[fax_id]["fax_name"]
	name = "[fax_name]'s Fax Machine"
