// Slime rancher AI controller blackboard keys

///Item a slime is currently walking towards to eat
#define BB_SLIME_ITEM_TARGET "BB_slime_item_target"
///Typecache of item types the slime still wants to eat
#define BB_SLIME_WANTED_ITEMS "BB_slime_wanted_items"
///Typecache of mob types the slime still wants to latch onto and drain
#define BB_SLIME_WANTED_MOBS "BB_slime_wanted_mobs"

/// From /mob/living/basic/slime/proc/eat_wanted_item(): (obj/item/meal)
/// Return COMPONENT_SLIME_WANTS_ITEM if this meal is worth something to you.
#define COMSIG_SLIME_CHECK_WANTED_ITEM "slime_check_wanted_item"
	#define COMPONENT_SLIME_WANTS_ITEM (1<<0)
/// From /mob/living/basic/slime/proc/eat_wanted_item(), after the item is gone: (meal_type)
#define COMSIG_SLIME_ATE_ITEM "slime_ate_item"
/// From /datum/status_effect/slime_leech/tick(): (mob/living/meal, drained)
#define COMSIG_SLIME_LATCH_DRAINED "slime_latch_drained"

// these control how long slimes jiggle when splitting or mutating
#define SLIME_SPLIT_WINDUP (5 SECONDS)
#define SLIME_MUTATE_WINDUP (8 SECONDS)

#define EVLOG_CATEGORY_SLIMES "Slimes"
