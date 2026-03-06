#define POWER_IDLE 0
#define POWER_UP 1
#define POWER_DOWN 2

#define ANCHOR_NEEDS_SCREWDRIVER 0
#define ANCHOR_NEEDS_WELDING 1
#define ANCHOR_NEEDS_PLASTEEL 2
#define ANCHOR_NEEDS_WRENCH 3

/obj/machinery/redspace_anchor
	name = "redspace anchor"
	icon = 'modular_oculis/modules/storm/icons/redspace_anchor.dmi'
	icon_state = "anchor_off"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 1000 // Lotta fucking power to keep the storm at bay.
	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 100 // Slightly less power to keep it idle.

	// 3x2 offset by one row
	pixel_x = -32
	pixel_y = -32
	bound_height = 64
	bound_width = 96
	bound_x = -32
	bound_y = 0
	density = TRUE
	move_resist = INFINITY

	/// Whether the redspace anchor is currently active.
	var/on = TRUE
	/// If the main breaker is on/off, to enable/disable the anchor.
	var/breaker = TRUE
	/// If the generator is idle, charging, or down.
	var/charging_state = POWER_IDLE
	/// How much charge the redspace anchor has, goes down when breaker is shut, and shuts down at 0.
	var/charge_count = 100

	/// The overlay currently used.
	var/current_overlay = null
	/// When broken, what stage it is at.
	var/broken_state = ANCHOR_NEEDS_SCREWDRIVER

	/// Audio for when the redspace anchor is on
	var/datum/looping_sound/redspace_anchor/soundloop

	/// How much excess violetspace energy the redspace anchor has, which can cause it to fail once it reaches 100.
	VAR_PROTECTED/violetspace_energy = 0

/obj/machinery/redspace_anchor/Initialize(mapload)
	. = ..()
	SSeidolon_storm.register_anchor(src)
	soundloop = new(src, start_immediately = FALSE)
	if(on)
		add_overlay("activated")

/obj/machinery/redspace_anchor/examine(mob/user)
	if(HAS_TRAIT(user, TRAIT_MINDSHIELD))
		desc = "The most important machine on the station. You feel more... Stable, near it."
		return ..()
	desc = "The most important machine on the station. \n \
			[span_danger("Looking directly at it gives you a headache.")]
	return ..()

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

// You aren't allowed to move.
/obj/machinery/redspace_anchor/Move()
	. = ..()
	qdel(src)

/obj/machinery/redspace_anchor/proc/set_broken()
	atom_break()
	update_appearance()

/obj/machinery/redspace_anchor/proc/set_fix()
	set_machine_stat(machine_stat & ~BROKEN)
	update_appearance()

/obj/machinery/redspace_anchor/update_icon_state()
	. = ..()
	if(on)
		icon_state = "anchor_on"
	else
		icon_state = "anchor_off"

// Interactions
/obj/machinery/redspace_anchor/examine(mob/user)
	. = ..()
	if(!(machine_stat & BROKEN))
		return
	switch(broken_state)
		if(ANCHOR_NEEDS_SCREWDRIVER)
			. += span_notice("The entire frame is barely holding together, the <b>screws</b> need to be refastened.")
		if(ANCHOR_NEEDS_WELDING)
			. += span_notice("There's lots of broken seals on the framework, it could use some <b>welding</b>.")
		if(ANCHOR_NEEDS_PLASTEEL)
			. += span_notice("Some of this damaged plating needs full replacement. <b>10 plasteel</> should be enough.")
		if(ANCHOR_NEEDS_WRENCH)
			. += span_notice("The new plating just needs to be <b>bolted</b> into place now.")

// Fixing the redspace anchor.
/obj/machinery/redspace_anchor/attackby(obj/item/weapon, mob/user, list/modifiers, list/attack_modifiers)
	if(!(machine_stat & BROKEN))
		return ..()
	switch(broken_state)
		if(ANCHOR_NEEDS_SCREWDRIVER)
			if(weapon.tool_behaviour == TOOL_SCREWDRIVER)
				to_chat(user, span_notice("You secure the screws of the framework."))
				weapon.play_tool_sound(src)
				broken_state++
				update_appearance()
				return
		if(ANCHOR_NEEDS_WELDING)
			if(weapon.tool_behaviour == TOOL_WELDER)
				if(weapon.use_tool(src, user, 0, volume = 50))
					to_chat(user, span_notice("You mend the damaged framework."))
					broken_state++
					update_appearance()
				return
		if(ANCHOR_NEEDS_PLASTEEL)
			if(istype(weapon, /obj/item/stack/sheet/plasteel))
				var/obj/item/stack/sheet/plasteel/plasteel_sheets = weapon
				if(plasteel_sheets.get_amount() >= 10)
					plasteel_sheets.use(10)
					to_chat(user, span_notice("You add the plating to the framework."))
					playsound(src.loc, 'sound/machines/click.ogg', 75, TRUE)
					broken_state++
					update_appearance()
				else
					to_chat(user, span_warning("You need 10 sheets of plasteel!"))
				return
		if(ANCHOR_NEEDS_WRENCH)
			if(weapon.tool_behaviour == TOOL_WRENCH)
				to_chat(user, span_notice("You secure the plating to the framework."))
				weapon.play_tool_sound(src)
				set_fix()
				return

/obj/machinery/redspace_anchor/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RedspaceAnchor", name)
		ui.open()

/obj/machinery/redspace_anchor/ui_data(mob/user)
	var/list/data = list()
	data["breaker"] = breaker
	data["charge_count"] = charge_count
	data["charging_state"] = charging_state
	data["on"] = on
	data["operational"] = (machine_stat & BROKEN) ? FALSE : TRUE
	data["violetspace_energy"] = violetspace_energy
	return data

/obj/machinery/redspace_anchor/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("gentoggle")
			breaker = !breaker
			investigate_log("was toggled [breaker ? "<font color='green'>ON</font>" : "<font color='red'>OFF</font>"] by [key_name(usr)].", INVESTIGATE_ENGINE)
			set_power()
			. = TRUE
		if("discharge_violetspace")
			if(violetspace_energy)
				investigate_log("has discharged violetspace energy by [key_name(usr)].", INVESTIGATE_ENGINE)
				trigger_safe_discharge()
				. = TRUE

// Power and Icon States
/obj/machinery/redspace_anchor/power_change()
	. = ..()
	if(SSticker.current_state == GAME_STATE_PLAYING)
		investigate_log("has [machine_stat & NOPOWER ? "lost" : "regained"] power.", INVESTIGATE_ENGINE)
	set_power()

// Set the charging state based on power/breaker.
/obj/machinery/redspace_anchor/proc/set_power()
	var/new_state = FALSE
	if(machine_stat & (NOPOWER|BROKEN) || !breaker)
		new_state = FALSE
	else if(breaker)
		new_state = TRUE

	charging_state = new_state ? POWER_UP : POWER_DOWN // Startup sequence animation.
	if(SSticker.current_state == GAME_STATE_PLAYING)
		investigate_log("is now [charging_state == POWER_UP ? "charging" : "discharging"].", INVESTIGATE_ENGINE)
	update_appearance()

/obj/machinery/redspace_anchor/proc/enable()
	charging_state = POWER_IDLE
	on = TRUE
	update_use_power(IDLE_POWER_USE)

	//soundloop.start()
	update_appearance()

	if(SSticker.current_state == GAME_STATE_PLAYING)
		investigate_log("was brought online and is now producing gravity for this level.", INVESTIGATE_ENGINE)
		message_admins("The redspace anchor was brought online [ADMIN_VERBOSEJMP(src)]")
	shake_everyone()

/obj/machinery/redspace_anchor/proc/disable()
	charging_state = POWER_IDLE
	on = FALSE
	update_use_power(IDLE_POWER_USE)

	//soundloop.stop()
	update_appearance()

	if(SSticker.current_state == GAME_STATE_PLAYING)
		investigate_log("was brought offline.", INVESTIGATE_ENGINE)
		message_admins("The redspace anchor was brought offline. [ADMIN_VERBOSEJMP(src)]")
	shake_everyone()

// Charge/Discharge and turn on/off when you reach 0/100 percent.
/obj/machinery/redspace_anchor/process()
	if(machine_stat & BROKEN)
		cut_overlays()
		return

	var/overlay_state = null
	switch(charge_count)
		if(0 to 20)
			overlay_state = null
		if(21 to 40)
			overlay_state = "startup"
		if(41 to 60)
			overlay_state = "idle"
		if(61 to 80)
			overlay_state = "activating"
		if(81 to 100)
			overlay_state = "activated"

	if(overlay_state != current_overlay)
		cut_overlays()
		if(overlay_state)
			add_overlay(overlay_state)
		current_overlay = overlay_state

	if(charging_state == POWER_IDLE)
		return
	if((charging_state == POWER_UP) && charge_count >= 100)
		enable()
	else if((charging_state == POWER_DOWN) && charge_count <= 0)
		disable()
	else
		if(charging_state == POWER_UP)
			charge_count += 2
			update_use_power(ACTIVE_POWER_USE)
		else if(charging_state == POWER_DOWN)
			charge_count -= 2
			update_use_power(IDLE_POWER_USE)

		for(var/mob/mobs as anything in GLOB.mob_list)
			var/turf/mob_turf = get_turf(mobs)
			if(!istype(mob_turf))
				continue
			if(!is_valid_z_level(src, mob_turf))
				continue
			if(mobs.client)
				if(charge_count % 4 == 0 && prob(75)) // Let them know it is charging/discharging.
					if(charging_state == POWER_UP)
						mobs.playsound_local(mob_turf, 'sound/effects/magic/cosmic_expansion.ogg', 100, TRUE)
					else
						mobs.playsound_local(mob_turf, 'sound/effects/magic/swap.ogg', 100, TRUE)
				if((charge_count <= 50) && (charging_state == POWER_DOWN) && prob(5))
					to_chat(mobs, span_bolddanger("You feel a foreign presence encroaching around you."))


/// Shake everyone on the z level to let them know that the anchor was enagaged/disengaged.
/obj/machinery/redspace_anchor/proc/shake_everyone()
	var/turf/T = get_turf(src)
	var/sound/alert_sound = sound('sound/effects/alert.ogg')
	for(var/mob/mobs as anything in GLOB.mob_list)
		var/turf/mob_turf = get_turf(mobs)
		if(!istype(mob_turf))
			continue
		if(!is_valid_z_level(T, mob_turf))
			continue
		if(mobs.client)
			shake_camera(mobs, 15, 1)
			mobs.playsound_local(T, null, 100, 1, 0.5, sound_to_use = alert_sound)
	if(!SSmapping.level_has_any_trait(z, ZTRAIT_STATION))
		return
	if(on)
		priority_announce("Redspace Anchor activated. Storm dissipation in progress.", "Redspace Anchor")
	else
		priority_announce("Warning: Redspace Anchor has been disabled. Storm encroaching on station perimeter.", "Redspace Anchor")

/obj/machinery/redspace_anchor/proc/tick(intensity)
	if(charging_state != POWER_IDLE)
		return
	violetspace_energy += (rand(1,5) * intensity)
	if(violetspace_energy >= 100)
		violetspace_energy = 0
		breaker = FALSE
		set_power()
		trigger_unsafe_discharge()

/obj/machinery/redspace_anchor/proc/trigger_unsafe_discharge()
	priority_announce("Redspace Anchor failure! Unsafe shutdown in progress!", "Redspace Anchor")

/obj/machinery/redspace_anchor/proc/trigger_safe_discharge()
	priority_announce("Redspace Anchor safe discharge in progres.", "Redspace Anchor")
