/datum/ai_controller/basic_controller/carp/goodboy //GOODBOY WHO DOESNT ATTACK AND TELEPORT
	blackboard = list(
		BB_BASIC_MOB_STOP_FLEEING = TRUE,
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_TARGET_PRIORITY_TRAIT = TRAIT_SCARY_FISHERMAN,
		BB_CARPS_FEAR_FISHERMAN = TRUE,
	)
	ai_traits = PASSIVE_AI_FLAGS
	behavior_tree_json = "code/modules/mob/living/basic/space_fauna/carp/carp_pet.bt.json"
