/obj/machinery/redspace_anchor
	name = "redspace anchor"
	desc = "The most important machine on the station. It keeps the storm outside of the station from encroaching closer."
	icon = 'icons/effects/96x96.dmi'
	icon_state = "apoc"
	density = TRUE
	move_resist = INFINITY
	use_power = NO_POWER_USE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/redspace_anchor/safe_throw_at(atom/target, range, speed, mob/thrower, spin = TRUE, diagonals_first = FALSE, datum/callback/callback, force = MOVE_FORCE_STRONG, gentle = FALSE)
	return FALSE

/obj/machinery/redspace_anchor/ex_act(severity, target)
	if(severity >= EXPLODE_DEVASTATE) // Very sturdy.
		set_broken()
		return TRUE
	return FALSE

/obj/machinery/redspace_anchor/blob_act(obj/structure/blob/B)
	if(prob(20))
		set_broken()

/obj/machinery/redspace_anchor/zap_act(power, zap_flags)
	. = ..()
	if(zap_flags & ZAP_MACHINE_EXPLOSIVE)
		qdel(src) //like the singulo, tesla deletes it. stops it from exploding over and over

/obj/machinery/redspace_anchor/update_icon_state()
	//icon_state = "[get_status()]_[sprite_number]"
	return ..()

// You aren't allowed to move.
/obj/machinery/redspace_anchor/Move()
	. = ..()
	qdel(src)

/obj/machinery/redspace_anchor/proc/set_broken()
	atom_break()

/obj/machinery/redspace_anchor/proc/set_fix()
	set_machine_stat(machine_stat & ~BROKEN)

