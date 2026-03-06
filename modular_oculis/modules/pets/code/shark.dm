/mob/living/basic/carp/mega/evil_ass_fish
	name = "Evil Ass Fish"
	desc = "The Sectorial Security Administrator's pet fish. It seems a bit overweight."
	faction = list(FACTION_NEUTRAL)
	gold_core_spawnable = NO_SPAWN
	ai_controller = /datum/ai_controller/basic_controller/carp/pet

/mob/living/basic/carp/mega/evil_ass_fish/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/pet_bonus, "bloops happily!")
