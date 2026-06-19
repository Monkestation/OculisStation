/datum/supply_pack/emergency/capsule
	name = "Emergency Capsule Crate"
	desc = "Station crashed onto lavaland? Out of mining points but still worried about being caught in a storm? Contains one deployable survival capsule. Warranty void once deployed."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/survivalcapsule = 1
				)
	crate_name = "emergency capsule box"
	crate_type = /obj/structure/closet/crate/cardboard
