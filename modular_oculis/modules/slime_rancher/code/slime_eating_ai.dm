/datum/ai_controller/basic_controller/slime
	behavior_tree_json = "modular_oculis/modules/slime_rancher/code/slime.bt.json"

/// items the slime wants to eat, from BB_SLIME_WANTED_ITEMS, if it is set
/datum/target_source/slime_wanted_items

/datum/target_source/slime_wanted_items/collect_candidates(mob/living/pawn, datum/ai_controller/controller, range)
	var/list/wanted_types = controller.blackboard[BB_SLIME_WANTED_ITEMS]
	if(!length(wanted_types))
		return list()
	var/list/candidates = typecache_filter_list(oview(range, pawn), wanted_types)
	for(var/obj/item/slime_extract/extract in candidates)
		if(extract.fresh_from_slime)
			candidates -= extract
	return candidates

/// slimes will also chase down critters they still owe a mutation, hungry or not
/datum/targeting_strategy/slime_food/is_valid_target(mob/living/living_mob, atom/target, vision_range, datum/ai_controller/controller = null)
	. = ..()
	if(. || isnull(controller) || QDELETED(target))
		return .

	var/list/wanted_mobs = controller.blackboard[BB_SLIME_WANTED_MOBS]
	if(!wanted_mobs?[target.type])
		return FALSE

	var/mob/living/basic/slime/slimey = living_mob
	return slimey.can_feed_on(target, silent = TRUE, check_adjacent = FALSE) && can_see(slimey, target, vision_range)

/// upstream's version falls through to TRUE no matter what, so full slimes hunted anyway.
/// critters we still owe a mutation get chased hungry or not, see slime_food above
/datum/bt_node/decorator/slime_wants_to_eat/ranching

/datum/bt_node/decorator/slime_wants_to_eat/ranching/check_condition(datum/ai_controller/controller)
	var/mob/living/basic/slime/slime_pawn = controller.pawn
	if(!istype(slime_pawn) || slime_pawn.buckled)
		return FALSE
	if(controller.blackboard[BB_SLIME_HUNGER_LEVEL] != SLIME_HUNGER_NONE || controller.blackboard[BB_SLIME_RABID])
		return TRUE
	return length(controller.blackboard[BB_SLIME_WANTED_MOBS]) > 0

/datum/bt_node/decorator/slime_is_wild

/datum/bt_node/decorator/slime_is_wild/check_condition(datum/ai_controller/controller)
	var/mob/living/basic/slime/slime_pawn = controller.pawn
	if(!istype(slime_pawn))
		return FALSE
	return !slime_pawn.is_ranched()

/// these branches only butt in when their key gets freshly set. if one bails partway (pathing gave up,
/// say) the key is still sitting there perfectly valid, so nothing ever re-sets it and the slime
/// wanders right past its target forever. dropping the target on the way out puts that edge back.
/datum/bt_node/decorator/bb_key_set/slime_target

/datum/bt_node/decorator/bb_key_set/slime_target/on_child_complete(datum/ai_controller/controller, result)
	controller.clear_blackboard_key(key)

/// check to see if we're free to go eat items laying around
/datum/bt_node/decorator/bb_key_set/slime_target/forage
	polling_rate = 1 SECONDS

/// buckled/unconscious have no blackboard signal to hang off of, so poll the whole thing instead of
/// trusting the parent's key signals. otherwise we miss the moment the slime gets back up
/datum/bt_node/decorator/bb_key_set/slime_target/forage/register_observe_signals(atom/pawn)
	return FALSE

/datum/bt_node/decorator/bb_key_set/slime_target/forage/unregister_observe_signals(atom/pawn)
	return

/datum/bt_node/decorator/bb_key_set/slime_target/forage/check_condition(datum/ai_controller/controller)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/slime/slime_pawn = controller.pawn
	if(!istype(slime_pawn) || slime_pawn.buckled || IS_UNCONSCIOUS_OR_CRIT(slime_pawn))
		return FALSE
	return TRUE

/// small chance per tick for a slime to yoink a wanted item right out of an adjacent mob's hands
/// they don't chase people down, to be clear
/datum/bt_node/ai_behavior/snatch_held_item

/datum/bt_node/ai_behavior/snatch_held_item/perform(seconds_per_tick, datum/ai_controller/controller)
	// the parallel only reruns us once per BASIC_MOB_FIND_TARGET_RATE, so this is already per-second
	if(!prob(15))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED

	var/mob/living/basic/slime/slime_pawn = controller.pawn
	var/list/wanted_types = controller.blackboard[BB_SLIME_WANTED_ITEMS]
	if(!istype(slime_pawn) || slime_pawn.buckled || IS_UNCONSCIOUS_OR_CRIT(slime_pawn) || !length(wanted_types))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED

	for(var/mob/living/neighbor in oview(1, slime_pawn))
		for(var/obj/item/held in neighbor.held_items)
			if(!wanted_types[held.type])
				continue
			var/held_name = "\the [held]" // get this bc eating it might delete the item
			if(!slime_pawn.eat_wanted_item(held, silent = TRUE))
				continue
			slime_pawn.visible_message(
				span_notice("[slime_pawn] snatches [held_name] right out of [neighbor]'s hands!"),
				span_notice("You snatch [held_name] right out of [neighbor]'s hands!")
			)
			slime_pawn.balloon_alert_to_viewers("snatches item out of hand!")
			slime_pawn.set_temporary_mood(SLIME_MOOD_MISCHIEVOUS)
			return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED

	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
