/// Returns TRUE if this atom type can ever be used as a wall pin surface.
/proc/is_wall_pin_surface_type(datum/target)
	return istype(target, /turf/closed/wall) || istype(target, /obj/structure/window) || istype(target, /obj/machinery/door)

/// Returns TRUE if this atom can be used as a wall pin surface.
/proc/is_wall_pin_surface(datum/target)
	if(istype(target, /turf/closed/wall))
		return TRUE

	if(istype(target, /obj/structure/window))
		var/obj/structure/window/window = target
		return window.anchored && window.density

	if(istype(target, /obj/machinery/door))
		var/obj/machinery/door/door = target
		return door.density

	return FALSE

/// Direction from the user toward the pinning surface.
/proc/get_wall_pin_dir(atom/pinning_surface, mob/user)
	. = get_dir(user, pinning_surface)
	if(.)
		return

	if(istype(pinning_surface, /obj/structure/window) && get_turf(user) == get_turf(pinning_surface))
		var/obj/structure/window/window = pinning_surface
		if(window.flags_1 & ON_BORDER_1)
			return window.dir

/// Element which lets mobs be pinned against this surface with an aggressive grab.
/datum/element/wall_pin

/datum/element/wall_pin/Attach(datum/target)
	. = ..()
	if(!is_wall_pin_surface_type(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_interaction))

/datum/element/wall_pin/Detach(datum/source, ...)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_ATTACK_HAND)

/// Called when someone clicks on our wall.
/datum/element/wall_pin/proc/on_interaction(atom/pinning_surface, mob/user)
	SIGNAL_HANDLER

	if(!isliving(user) || !pinning_surface.Adjacent(user) || !user.pulling)
		return

	if(!isliving(user.pulling))
		return

	if(!is_wall_pin_surface(pinning_surface))
		return

	INVOKE_ASYNC(src, PROC_REF(perform_wall_pin), pinning_surface, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/// We have a mob pressed to a surface, but only a harmful aggressive grab can hold them there.
/datum/element/wall_pin/proc/perform_wall_pin(atom/pinning_surface, mob/living/user)
	if(!pinning_surface.Adjacent(user) || !isliving(user.pulling) || !user.combat_mode || HAS_TRAIT(user.pulling, TRAIT_PINNED) || HAS_TRAIT(user, TRAIT_PACIFISM))
		return

	if(!is_wall_pin_surface(pinning_surface))
		return

	var/wall_dir = get_wall_pin_dir(pinning_surface, user)
	if(!(wall_dir in GLOB.cardinals))
		to_chat(user, span_warning("You need to be directly beside [pinning_surface] to pin someone against it!"))
		return

	var/turf/user_turf = get_turf(user)
	var/turf/pin_turf = user_turf == get_turf(pinning_surface) ? user_turf : get_step(pinning_surface, REVERSE_DIR(wall_dir))
	if(user_turf != pin_turf)
		return

	var/mob/living/pinned_mob = user.pulling
	if(user.grab_state < GRAB_AGGRESSIVE)
		to_chat(user, span_warning("You need a better grip to pin [pinned_mob] against [pinning_surface]!"))
		return

	if(pinned_mob.buckled)
		to_chat(user, span_warning("[pinned_mob] is buckled to [pinned_mob.buckled]!"))
		return

	user.setDir(wall_dir)
	pinned_mob.forceMove(pin_turf)
	if(!user.start_pulling(pinned_mob, supress_message = TRUE))
		return

	user.setGrabState(GRAB_AGGRESSIVE)
	pinned_mob.setDir(REVERSE_DIR(wall_dir))
	pinned_mob.AddComponent(/datum/component/wall_pin, user, pinning_surface)

	user.changeNext_move(CLICK_CD_MELEE)
	user.visible_message(
		span_danger("[user] pins [pinned_mob] against [pinning_surface]!"),
		span_danger("You pin [pinned_mob] against [pinning_surface]!"),
		span_hear("You hear aggressive shuffling against a wall."),
		COMBAT_MESSAGE_RANGE,
		list(pinned_mob),
	)
	to_chat(pinned_mob, span_userdanger("[user] pins you against [pinning_surface]!"))
	playsound(pinning_surface, 'sound/effects/hit_kick.ogg', 40, TRUE)
	pinned_mob.apply_damage(2, BRUTE)
	pinning_surface.add_fingerprint(user)
	pinning_surface.add_fingerprint(pinned_mob)

	log_combat(user, pinned_mob, "pinned", null, "against [pinning_surface]")

/// Keeps a grabbed mob pinned in place until the grab is released, broken, or otherwise invalidated.
/datum/component/wall_pin
	dupe_mode = COMPONENT_DUPE_HIGHLANDER
	/// Mob maintaining the pin.
	var/mob/living/aggressor
	/// Surface the parent is being pinned against.
	var/atom/pinning_surface
	/// Direction from the aggressor to the surface when the pin started.
	var/pin_dir
	/// Trait source used for the extra immobilization while pinned.
	var/trait_source
	/// Trip the aggresor and mob on removal.
	var/trip

/datum/component/wall_pin/Initialize(mob/living/aggressor, atom/pinning_surface)
	if(!isliving(parent) || !istype(aggressor) || !istype(pinning_surface))
		return COMPONENT_INCOMPATIBLE

	src.aggressor = aggressor
	src.pinning_surface = pinning_surface
	pin_dir = get_wall_pin_dir(pinning_surface, aggressor)
	if(!(pin_dir in GLOB.cardinals))
		return COMPONENT_INCOMPATIBLE
	trait_source = REF(src)

/datum/component/wall_pin/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_pinned_pre_move))
	RegisterSignal(parent, COMSIG_LIVING_SET_PULL_OFFSET, PROC_REF(on_pull_offset_set))
	RegisterSignals(parent, list(COMSIG_ATOM_NO_LONGER_PULLED, COMSIG_MOVABLE_MOVED, COMSIG_QDELETING, COMSIG_LIVING_DEATH), PROC_REF(check_pin))
	RegisterSignal(aggressor, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_aggressor_pre_move))
	RegisterSignal(aggressor, COMSIG_MOVABLE_SET_GRAB_STATE, PROC_REF(on_aggressor_grab_state_change))
	RegisterSignals(aggressor, list(COMSIG_ATOM_NO_LONGER_PULLING, COMSIG_MOVABLE_MOVED, COMSIG_QDELETING, COMSIG_LIVING_HEALTH_UPDATE, COMSIG_LIVING_DEATH), PROC_REF(check_pin))
	RegisterSignal(pinning_surface, COMSIG_ATOM_DENSITY_CHANGED, PROC_REF(check_pin))

	var/mob/living/pinned_mob = parent
	ADD_TRAIT(pinned_mob, TRAIT_FORCED_STANDING, trait_source)
	ADD_TRAIT(pinned_mob, TRAIT_IMMOBILIZED, trait_source)
	ADD_TRAIT(pinned_mob, TRAIT_HANDS_BLOCKED, trait_source)
	ADD_TRAIT(pinned_mob, TRAIT_PULL_BLOCKED, trait_source)
	ADD_TRAIT(pinned_mob, TRAIT_PINNED, trait_source)
	if(!aggressor.has_quirk(/datum/quirk/pushover))
		ADD_TRAIT(pinned_mob, TRAIT_GRABWEAKNESS, trait_source)

	ADD_TRAIT(aggressor, TRAIT_IMMOBILIZED, trait_source)
	refresh_offsets(TRUE)

/datum/component/wall_pin/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_MOVABLE_PRE_MOVE, COMSIG_LIVING_SET_PULL_OFFSET, COMSIG_ATOM_NO_LONGER_PULLED, COMSIG_MOVABLE_MOVED, COMSIG_QDELETING, COMSIG_LIVING_HEALTH_UPDATE, COMSIG_LIVING_DEATH))
	UnregisterSignal(pinning_surface, COMSIG_ATOM_DENSITY_CHANGED)
	var/mob/living/pinned_mob = parent
	var/release_damage = 0

	if(!QDELETED(aggressor) && (HAS_TRAIT(aggressor, TRAIT_OVERSIZED) || HAS_TRAIT(aggressor, TRAIT_HEAVYSET)))
		release_damage += 50

	if(!QDELETED(parent))
		REMOVE_TRAIT(pinned_mob, TRAIT_FORCED_STANDING, trait_source)
		REMOVE_TRAIT(pinned_mob, TRAIT_IMMOBILIZED, trait_source)
		REMOVE_TRAIT(pinned_mob, TRAIT_HANDS_BLOCKED, trait_source)
		REMOVE_TRAIT(pinned_mob, TRAIT_PULL_BLOCKED, trait_source)
		REMOVE_TRAIT(pinned_mob, TRAIT_PINNED, trait_source)
		REMOVE_TRAIT(pinned_mob, TRAIT_GRABWEAKNESS, trait_source)

		pinned_mob.remove_offsets(TRAIT_PINNED)

		if(trip)
			playsound(pinning_surface, 'sound/effects/bang.ogg', 40, TRUE)
			to_chat(pinned_mob, span_userdanger("[aggressor] slams into you as [aggressor.p_they()] lose[aggressor.p_s()] [aggressor.p_their()] grip!"))
			pinned_mob.apply_damage(1 + release_damage, BRUTE)
			pinned_mob.Move(get_step(pinned_mob, pin_dir))
			pinned_mob.Paralyze(3 SECONDS)

	if(!QDELETED(aggressor))
		UnregisterSignal(aggressor, list(COMSIG_MOVABLE_PRE_MOVE, COMSIG_ATOM_NO_LONGER_PULLING, COMSIG_MOVABLE_SET_GRAB_STATE, COMSIG_MOVABLE_MOVED, COMSIG_QDELETING, COMSIG_LIVING_HEALTH_UPDATE, COMSIG_LIVING_DEATH, COMSIG_ATOM_DENSITY_CHANGED))
		REMOVE_TRAIT(aggressor, TRAIT_IMMOBILIZED, trait_source)
		aggressor.remove_offsets(TRAIT_PINNED)

		if(trip)
			to_chat(aggressor, span_userdanger("You lose your footing and slam onto [pinned_mob]!"))
			aggressor.Move(get_step(aggressor, pin_dir))
			aggressor.Paralyze(0.5 SECONDS)

	if(trip)
		log_combat(aggressor, pinned_mob, "unpinned via falling", null)

	aggressor = null
	pinning_surface = null
	return ..()

/datum/component/wall_pin/proc/on_pinned_pre_move(mob/living/source, atom/new_location)
	SIGNAL_HANDLER

	if(!pin_is_valid())
		qdel(src)
		return NONE

	source.balloon_alert(source, "pinned!")
	return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/datum/component/wall_pin/proc/on_aggressor_pre_move(mob/living/source, atom/new_location)
	SIGNAL_HANDLER

	if(!pin_is_valid())
		qdel(src)
		return NONE

	source.balloon_alert(source, "holding pin!")
	return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/datum/component/wall_pin/proc/on_pull_offset_set(mob/living/source)
	SIGNAL_HANDLER

	if(!pin_is_valid())
		qdel(src)
		return

	refresh_offsets(FALSE)

/datum/component/wall_pin/proc/on_aggressor_grab_state_change(atom/movable/source, new_grab_state)
	SIGNAL_HANDLER

	if(new_grab_state != GRAB_AGGRESSIVE)
		qdel(src)

/datum/component/wall_pin/proc/check_pin(datum/source, ...)
	SIGNAL_HANDLER

	if(!pin_is_valid())
		qdel(src)

/datum/component/wall_pin/proc/refresh_offsets(animate = FALSE)
	var/mob/living/pinned_mob = parent
	if(QDELETED(pinned_mob) || QDELETED(aggressor))
		return

	aggressor.setDir(pin_dir)
	pinned_mob.setDir(REVERSE_DIR(pin_dir))
	pinned_mob.remove_offsets(GRABBING_TRAIT, animate)
	apply_pin_offset(aggressor, REVERSE_DIR(pin_dir), 4, animate)
	apply_pin_offset(pinned_mob, REVERSE_DIR(pin_dir), 16, animate)

/datum/component/wall_pin/proc/apply_pin_offset(mob/living/offset_mob, dir, offset, animate = FALSE)
	var/mob/living/pinned_mob = parent
	var/new_x = 0
	var/new_y = 0

	switch(dir)
		if(SOUTH)
			new_y += HAS_TRAIT(aggressor, TRAIT_OVERSIZED) && offset_mob == pinned_mob ? offset - 8 : offset
		if(NORTH)
			new_y -= HAS_TRAIT(aggressor, TRAIT_OVERSIZED) && offset_mob == pinned_mob ? offset + 8 : offset
		if(WEST)
			new_x += offset
			if(HAS_TRAIT(aggressor, TRAIT_OVERSIZED) && offset_mob == pinned_mob)
				new_y += 8
		if(EAST)
			new_x -= offset
			if(HAS_TRAIT(aggressor, TRAIT_OVERSIZED) && offset_mob == pinned_mob)
				new_y += 8

	offset_mob.add_offsets(TRAIT_PINNED, x_add = new_x, y_add = new_y, animate = animate)

/datum/component/wall_pin/proc/pin_is_valid()
	var/mob/living/pinned_mob = parent
	if(QDELETED(pinned_mob) || QDELETED(aggressor) || QDELETED(pinning_surface))
		return FALSE

	if(pinned_mob.stat == DEAD || aggressor.stat == DEAD)
		return FALSE

	if(pinned_mob.pulledby != aggressor || aggressor.pulling != pinned_mob || aggressor.grab_state != GRAB_AGGRESSIVE)
		return FALSE

	if(get_turf(pinned_mob) != get_turf(aggressor))
		return FALSE

	if(!pinning_surface.Adjacent(aggressor) || !pinning_surface.Adjacent(pinned_mob))
		return FALSE

	if(!pinning_surface.density)
		trip = TRUE
		return FALSE

	return TRUE

/turf/closed/wall/attack_hand(mob/user, list/modifiers)
	// Same as wall leaning, we only add the Element when we come interact with the wall, and not on Initialize() to not implode the map init time.
	if(user.ckey)
		AddElement(/datum/element/wall_pin)
	. = ..()
