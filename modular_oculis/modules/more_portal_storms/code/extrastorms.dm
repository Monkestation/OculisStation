/datum/round_event_control/portal_storm_netherworld
	name = "Portal Storm: Netherworld"
	typepath = /datum/round_event/portal_storm/netherworld
	weight = 1
	min_players = 15
	earliest_start = 30 MINUTES
	category = EVENT_CATEGORY_ENTITIES
	description = "Netherworld creatures pour out of portals."
	intensity_restriction = TRUE

/datum/round_event/portal_storm/netherworld
	boss_types = list(/mob/living/basic/migo = 5)
	hostile_types = list(
		/mob/living/basic/creature/hatchling = 12,
		/mob/living/basic/creature = 8,
	)

/datum/round_event_control/portal_storm_pirates //Pirate storm meant to be similar but stronger than the syndicate verson, at the cost of an ICES credit. More enemies, more of which are ranged.
	name = "Portal Storm: Pirates"
	typepath = /datum/round_event/portal_storm/pirates
	weight = 1
	min_players = 20
	earliest_start = 1 HOURS
	category = EVENT_CATEGORY_ENTITIES
	description = "Space pirates pour out of portals."
	intensity_restriction = TRUE

/datum/round_event/portal_storm/pirates
	boss_types = list(/mob/living/basic/trooper/pirate/ranged/space = 6)
	hostile_types = list(
		/mob/living/basic/trooper/pirate/melee/space = 10,
	)
