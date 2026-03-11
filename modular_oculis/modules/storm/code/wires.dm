/datum/wires/redspace_anchor
	holder_type = /obj/machinery/redspace_anchor
	proper_name = "Redspace Anchor"

/datum/wires/redspace_anchor/New(atom/holder)
	wires = list(
		WIRE_POWER,
		WIRE_AI,
		WIRE_ALARM,
		WIRE_DISCHARGE,
	)
	add_duds(10) // It's a complicated machine. It's gonna have lots of wires.
	..()

/datum/wires/redspace_anchor/interactable(mob/user)
	if(!..())
		return FALSE
	return TRUE

/datum/wires/redspace_anchor/get_status()
	var/obj/machinery/redspace_anchor/A = holder
	var/list/status = list()
	status += "The short indicator is [A.shorted ? "lit" : "off"]."
	status += "The AI connection light is [!A.aidisabled ? "on" : "off"]."
	return status

/datum/wires/redspace_anchor/on_pulse(wire)
	var/obj/machinery/redspace_anchor/anchor = holder
	switch(wire)
		if(WIRE_POWER) // Short out for a long time.
			if(!anchor.shorted)
				anchor.shorted = TRUE
				anchor.update_appearance()
			addtimer(CALLBACK(anchor, TYPE_PROC_REF(/obj/machinery/redspace_anchor, reset), wire), 2 MINUTES)
		if(WIRE_AI) // Disable AI control for a while.
			if(!anchor.aidisabled)
				anchor.aidisabled = TRUE
			addtimer(CALLBACK(anchor, TYPE_PROC_REF(/obj/machinery/redspace_anchor, reset), wire), 10 SECONDS)
		if(WIRE_ALARM)
			anchor.update_appearance()
		if(WIRE_DISCHARGE)
			anchor.trigger_safe_discharge()

/datum/wires/redspace_anchor/on_cut(wire, mend, source)
	var/obj/machinery/redspace_anchor/anchor = holder
	switch(wire)
		if(WIRE_POWER)
			anchor.shorted = !mend
			anchor.update_appearance()
		if(WIRE_AI)
			anchor.aidisabled = mend // Enable/disable AI control.
		if(WIRE_ALARM)
			anchor.update_appearance()
		if(WIRE_DISCHARGE)
			anchor.trigger_safe_discharge()

/datum/wires/redspace_anchor/can_reveal_wires(mob/user)
	if(HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		return TRUE
	return ..()
