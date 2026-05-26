#define TRAIT_PINNED "pinned"

/// Element which lets mobs be pinned against this wall with an aggressive grab.
/datum/element/wall_pin

/datum/element/wall_pin/Attach(datum/target)
	. = ..()
	if(!istype(target, /turf/closed/wall))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_interaction))

/datum/element/wall_pin/Detach(datum/source, ...)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_ATTACK_HAND)

/// Called when someone clicks on our wall.
/datum/element/wall_pin/proc/on_interaction(turf/closed/wall/wall, mob/user)
	SIGNAL_HANDLER

	if(!isliving(user) || !wall.Adjacent(user) || !user.pulling)
		return

	if(!isliving(user.pulling))
		return

	INVOKE_ASYNC(src, PROC_REF(perform_wall_pin), wall, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/// We have a mob pressed to a wall, but only an harm aggressive grab can hold them there.
/datum/element/wall_pin/proc/perform_wall_pin(turf/closed/wall/wall, mob/living/user)
	if(!wall.Adjacent(user) || !isliving(user.pulling) || !user.combat_mode)
		return

	var/wall_dir = get_dir(user, wall)
	if(!(wall_dir in GLOB.cardinals))
		to_chat(user, span_warning("You need to be directly beside [wall] to pin someone against it!"))
		return

	var/turf/pin_turf = get_step(wall, REVERSE_DIR(wall_dir))
	if(get_turf(user) != pin_turf)
		return

	var/mob/living/pinned_mob = user.pulling
	if(user.grab_state < GRAB_AGGRESSIVE)
		to_chat(user, span_warning("You need a better grip to pin [pinned_mob] against [wall]!"))
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
	pinned_mob.AddComponent(/datum/component/wall_pin, user, wall)

	user.changeNext_move(CLICK_CD_MELEE)
	user.visible_message(
		span_danger("[user] pins [pinned_mob] against [wall]!"),
		span_danger("You pin [pinned_mob] against [wall]!"),
		span_hear("You hear aggressive shuffling against a wall."),
		COMBAT_MESSAGE_RANGE,
		list(pinned_mob),
	)
	to_chat(pinned_mob, span_userdanger("[user] pins you against [wall]!"))
	playsound(wall, 'sound/effects/hit_kick.ogg', 40, TRUE)
	pinned_mob.apply_damage(5, BRUTE)
	wall.add_fingerprint(user)
	log_combat(user, pinned_mob, "pinned", null, "against [wall]")

/// Keeps a grabbed mob pinned in place until the grab is released, broken, or otherwise invalidated.
/datum/component/wall_pin
	dupe_mode = COMPONENT_DUPE_HIGHLANDER
	/// Mob maintaining the pin.
	var/mob/living/aggressor
	/// Wall the parent is being pinned against.
	var/turf/closed/wall/pinning_wall
	/// Direction from the aggressor to the wall when the pin started.
	var/pin_dir
	/// Trait source used for the extra immobilization while pinned.
	var/trait_source

/datum/component/wall_pin/Initialize(mob/living/aggressor, turf/closed/wall/pinning_wall)
	if(!isliving(parent) || !istype(aggressor) || !istype(pinning_wall))
		return COMPONENT_INCOMPATIBLE

	src.aggressor = aggressor
	src.pinning_wall = pinning_wall
	pin_dir = get_dir(aggressor, pinning_wall)
	trait_source = REF(src)

/datum/component/wall_pin/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_pinned_pre_move))
	RegisterSignal(parent, COMSIG_LIVING_SET_PULL_OFFSET, PROC_REF(on_pull_offset_set))
	RegisterSignals(parent, list(COMSIG_ATOM_NO_LONGER_PULLED, COMSIG_MOVABLE_MOVED, COMSIG_QDELETING, COMSIG_LIVING_DEATH), PROC_REF(check_pin))
	RegisterSignal(aggressor, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_aggressor_pre_move))
	RegisterSignal(aggressor, COMSIG_MOVABLE_SET_GRAB_STATE, PROC_REF(on_aggressor_grab_state_change))
	RegisterSignals(aggressor, list(COMSIG_ATOM_NO_LONGER_PULLING, COMSIG_MOVABLE_MOVED, COMSIG_QDELETING, COMSIG_LIVING_HEALTH_UPDATE, COMSIG_LIVING_DEATH), PROC_REF(check_pin))

	var/mob/living/pinned_mob = parent
	ADD_TRAIT(pinned_mob, TRAIT_FORCED_STANDING, trait_source)
	ADD_TRAIT(pinned_mob, TRAIT_IMMOBILIZED, trait_source)
	ADD_TRAIT(pinned_mob, TRAIT_GRABWEAKNESS, trait_source)
	ADD_TRAIT(pinned_mob, TRAIT_HANDS_BLOCKED, trait_source)
	ADD_TRAIT(pinned_mob, TRAIT_PULL_BLOCKED, trait_source)
	ADD_TRAIT(pinned_mob, TRAIT_PINNED, trait_source)
	refresh_offsets(FALSE)

/datum/component/wall_pin/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_MOVABLE_PRE_MOVE, COMSIG_LIVING_SET_PULL_OFFSET, COMSIG_ATOM_NO_LONGER_PULLED, COMSIG_MOVABLE_MOVED, COMSIG_QDELETING, COMSIG_LIVING_HEALTH_UPDATE, COMSIG_LIVING_DEATH))

	if(!QDELETED(parent))
		var/mob/living/pinned_mob = parent
		REMOVE_TRAIT(pinned_mob, TRAIT_FORCED_STANDING, trait_source)
		REMOVE_TRAIT(pinned_mob, TRAIT_IMMOBILIZED, trait_source)
		REMOVE_TRAIT(pinned_mob, TRAIT_GRABWEAKNESS, trait_source)
		REMOVE_TRAIT(pinned_mob, TRAIT_HANDS_BLOCKED, trait_source)
		REMOVE_TRAIT(pinned_mob, TRAIT_PULL_BLOCKED, trait_source)
		REMOVE_TRAIT(pinned_mob, TRAIT_PINNED, trait_source)
		pinned_mob.remove_offsets(TRAIT_PINNED)

	if(!QDELETED(aggressor))
		UnregisterSignal(aggressor, list(COMSIG_MOVABLE_PRE_MOVE, COMSIG_ATOM_NO_LONGER_PULLING, COMSIG_MOVABLE_SET_GRAB_STATE, COMSIG_MOVABLE_MOVED, COMSIG_QDELETING, COMSIG_LIVING_HEALTH_UPDATE, COMSIG_LIVING_DEATH))
		aggressor.remove_offsets(TRAIT_PINNED)

	aggressor = null
	pinning_wall = null
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
	var/new_x = 0
	var/new_y = 0

	switch(dir)
		if(SOUTH)
			new_y += offset
		if(NORTH)
			new_y -= offset
		if(WEST)
			new_x += offset
		if(EAST)
			new_x -= offset

	offset_mob.add_offsets(TRAIT_PINNED, x_add = new_x, y_add = new_y, animate = animate)

/datum/component/wall_pin/proc/pin_is_valid()
	var/mob/living/pinned_mob = parent
	if(QDELETED(pinned_mob) || QDELETED(aggressor) || QDELETED(pinning_wall))
		return FALSE

	if(pinned_mob.stat == DEAD || aggressor.stat == DEAD)
		return FALSE

	if(pinned_mob.pulledby != aggressor || aggressor.pulling != pinned_mob || aggressor.grab_state != GRAB_AGGRESSIVE)
		return FALSE

	if(get_turf(pinned_mob) != get_turf(aggressor))
		return FALSE

	if(!pinning_wall.Adjacent(aggressor) || !pinning_wall.Adjacent(pinned_mob))
		return FALSE

	return TRUE
