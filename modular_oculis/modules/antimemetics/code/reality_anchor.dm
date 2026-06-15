/obj/item/circuitboard/machine/reality_anchor
	name = "Reality Anchor"
	greyscale_colors = COLOR_DARK_PURPLE
	build_path = /obj/machinery/power/reality_anchor
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/datum/stock_part/servo/tier4 = 2,
		/datum/stock_part/micro_laser/tier4 = 4,
		/datum/stock_part/matter_bin/tier4 = 2,
		/obj/item/stack/sheet/bluespace_crystal = 1,
		)

/obj/machinery/power/reality_anchor
	name = "dunmore reality anchor"
	desc = "A machine made to make reality more stable. A direct power connection is heavily recommended."
	icon = 'modular_oculis/modules/antimemetics/icons/reality_anchor.dmi'
	icon_state = "reality_anchor"
	base_icon_state = "reality_anchor"
	density = TRUE
	use_power = IDLE_POWER_USE
	circuit = /obj/item/circuitboard/machine/reality_anchor
	critical_machine = TRUE
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 10 // 1 MW
	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION

	/// Is it about to explode?
	VAR_PRIVATE/going_kaboom = FALSE

	var/on = FALSE

/obj/machinery/power/reality_anchor/Initialize(mapload)
	. = ..()
	connect_to_network()
	GLOB.reality_anchors += src

/obj/machinery/power/reality_anchor/Destroy()
	GLOB.reality_anchors -= src
	return ..()

/obj/machinery/power/reality_anchor/examine(mob/user)
	. = ..()
	if(on)
		. += span_purple("You feel stable.")

/obj/machinery/power/reality_anchor/update_icon_state()
	. = ..()
	if(panel_open)
		icon_state = "[base_icon_state]_open"
		return
	if(on)
		icon_state = "[base_icon_state]_on"
	else
		icon_state = "[base_icon_state]"

/obj/machinery/power/reality_anchor/screwdriver_act(mob/living/user, obj/item/tool)
	if(on)
		balloon_alert(user, "turn off first!")
		return ITEM_INTERACT_BLOCKING
	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/power/reality_anchor/crowbar_act(mob/living/user, obj/item/tool)
	if(on)
		balloon_alert(user, "turn off first!")
		return ITEM_INTERACT_BLOCKING
	return default_deconstruction_crowbar(user, tool)

/obj/machinery/power/reality_anchor/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(on)
		balloon_alert(user, "turn off first!")
		return ITEM_INTERACT_BLOCKING
	default_unfasten_wrench(user, tool)
	if(anchored)
		connect_to_network()
	else
		disconnect_from_network()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/reality_anchor/interact(mob/user)
	. = ..()
	if(!anchored)
		balloon_alert(user, "anchor first!")
		return FALSE
	toggle_power(user)

/obj/machinery/power/reality_anchor/proc/toggle_power(mob/user)
	if(!powered())
		balloon_alert(user, "no power!")
		return
	on = !on
	update_use_power(on ? ACTIVE_POWER_USE : IDLE_POWER_USE)
	update_current_power_usage()
	playsound(src, 'modular_nova/master_files/sound/effects/gmalfunction.ogg', 100, TRUE)
	balloon_alert_to_viewers("[on ? null : "de"]activated!")
	update_icon()

/obj/machinery/power/reality_anchor/power_change()
	. = ..()
	if((machine_stat & NOPOWER) && on)
		on = FALSE
		update_use_power(IDLE_POWER_USE)
		update_current_power_usage()
		playsound(src, 'modular_nova/master_files/sound/effects/gmalfunction.ogg', 100, TRUE)
		balloon_alert_to_viewers("deactivated!")
		update_appearance(UPDATE_ICON_STATE)

/obj/machinery/power/reality_anchor/proc/overload()
	if(!on)
		return
	if(going_kaboom)
		return
	going_kaboom = TRUE
	visible_message(
		message = span_danger("[src] lets out a shower of sparks as it starts to lose stability!"),
		blind_message = span_hear("You hear a loud electrical crack!"),
	)
	playsound(src, 'sound/effects/magic/lightningshock.ogg', 100, TRUE, extrarange = 5)
	tesla_zap(source = src, zap_range = 5, power = 20 KILO WATTS)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(explosion), src, 2, 3, 4, null, 8), 10 SECONDS) // Not a normal explosion.

/obj/machinery/power/reality_anchor/bullet_act(obj/projectile/proj)
	. = ..()
	if(!going_kaboom && istype(proj) && proj.damage > 0 && ((proj.damage_type == BURN) || (proj.damage_type == BRUTE)))
		log_bomber(proj.firer, "triggered a", src, "explosion via projectile")
		overload()

/obj/machinery/power/reality_anchor/blob_act(obj/structure/blob/B)
	if(on)
		overload()
		return TRUE
	return ..()

/obj/machinery/power/reality_anchor/ex_act()
	if(on)
		if(going_kaboom)
			qdel(src)
		else
			overload()
		return TRUE
	return ..()

/obj/machinery/power/reality_anchor/fire_act(exposed_temperature, exposed_volume)
	if(on)
		overload()
		return TRUE
	return ..()

/obj/machinery/power/reality_anchor/zap_act(power, zap_flags)
	. = ..() //extend the zap
	if(zap_flags & ZAP_MACHINE_EXPLOSIVE)
		overload()
