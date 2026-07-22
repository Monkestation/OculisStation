/*
 * The silk chairs / tables
 */
/obj/structure/chair/silk
	name = "silk chair"
	icon = 'modular_oculis/modules/arachnids/icons/structures/silk_structures.dmi'
	icon_state = "chair"
	buildstacktype = /obj/item/stack/sheet/silk
	buildstackamount = 3
	item_chair = /obj/item/chair/silk
	resistance_flags = FLAMMABLE

/obj/item/chair/silk
	name = "silk chair"
	desc = "It's way too soft for it to make a dent on anything."
	icon = 'modular_oculis/modules/arachnids/icons/structures/silk_structures.dmi'
	icon_state = "chair_toppled"
	origin_type = /obj/structure/chair/silk
	custom_materials = null
	force = 0 //It's just silk
	throwforce = 0
	throw_range = 6

/obj/structure/bed/silk
	name = "silk bed"
	icon_state = "bed"
	icon = 'modular_oculis/modules/arachnids/icons/structures/silk_structures.dmi'
	build_stack_type = /obj/item/stack/sheet/silk

/obj/item/stack/tile/silk
	name = "silk floor tile"
	singular_name = "silk floor tile"
	desc = "Soft and luxurious."
	icon = 'modular_oculis/modules/arachnids/icons/tiles/silk_tiles.dmi'
	icon_state = "tile_silk"
	inhand_icon_state = "tile"
	turf_type = /turf/open/floor/silk
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/silk
	force = 0
	throwforce = 0

/turf/open/floor/silk
	name = "silk floor"
	desc = "Soft and luxurious."
	icon = 'modular_oculis/modules/arachnids/icons/turf/silk_floors.dmi'
	icon_state = "silk"
	floor_tile = /obj/item/stack/tile/silk
	bullet_bounce_sound = null
	footstep = FOOTSTEP_CARPET
	barefootstep = FOOTSTEP_CARPET_BAREFOOT
	clawfootstep = FOOTSTEP_CARPET_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/obj/structure/table/silk
	name = "silk table"
	desc = "Really stable. Do not set on fire."
	icon = 'modular_oculis/modules/arachnids/icons/smooth_structures/silk_table.dmi'
	buildstack = /obj/item/stack/sheet/silk
	resistance_flags = FLAMMABLE
	max_integrity = 50


/turf/closed/wall/material/silk
	name = "silk wall"
	desc = "A silk wall reinforced with iron, still weaker than an iron wall."
	icon = 'modular_oculis/modules/arachnids/icons/turf/silk_wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	sheet_type = /obj/item/stack/sheet/silk
	hardness = 80
	explosive_resistance = 0
	max_integrity = 100
	damage_deflection = 5
	custom_materials = list(/datum/material/silk = SHEET_MATERIAL_AMOUNT*2)
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_SILK_WALLS + SMOOTH_GROUP_WALLS
	canSmoothWith = SMOOTH_GROUP_SILK_WALLS

/obj/structure/falsewall/silk
	name = "silk wall"
	desc = "A silk wall reinforced with iron, still weaker than an iron wall."
	icon = 'modular_oculis/modules/arachnids/icons/turf/silk_wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	mineral = /obj/item/stack/sheet/silk
	walltype = /turf/closed/wall/material/silk
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_SILK_WALLS + SMOOTH_GROUP_WALLS
	canSmoothWith = SMOOTH_GROUP_SILK_WALLS


/*
 * Weaker versions of the spider structures
 */

/obj/structure/spider/stickyweb/sealed/tough/arachnid //reduced integrity.
	name = "arachnid solid web"
	desc = "A solid wall of arachnid silk, thick enough to block air flow. Since arachnid silk is softer than the average silk, it's easier to destroy."
	max_integrity = 30

/obj/structure/spider/passage/arachnid // reduced integrity, see-through.
	name = "arachnid web passage"
	desc = "A messy connection of webs that block airflow, but still allows passage."
	max_integrity = 30
	opacity = FALSE

/obj/structure/spider/spikes/arachnid // minimum damage reduced from 20 to 5, max damage reduced from 30 to 5, integrity reduced.
	name = "arachnid web spikes"
	desc = "Silk hardened into small yet deadly spikes. Since arachnid silk is softer than the average silk, their efficiency is somewhat reduced."
	max_integrity = 10

/obj/structure/spider/spikes/arachnid/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/caltrop, min_damage = 5, max_damage = 5, flags = CALTROP_NOSTUN | CALTROP_BYPASS_SHOES)

/obj/structure/spider/stickyweb/arachnid // reduced integrity, only carbons with more than two arachnid limbs can surf on it freely.
	name = "arachnid web"
	desc = "Designed to slow anything that isn't an arachnid. Really fragile."
	max_integrity = 10

/obj/structure/spider/stickyweb/arachnid/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(isliving(mover))
		if(HAS_TRAIT(mover, TRAIT_ARACHNID_WEB_SURFER))
			return TRUE
		if(mover.pulledby && HAS_TRAIT(mover.pulledby, TRAIT_ARACHNID_WEB_SURFER))
			return TRUE
		if(prob(50))
			loc.balloon_alert(mover, "stuck in web!")
			return FALSE
	else if(isprojectile(mover))
		return prob(30)

/obj/structure/spider/stickyweb/arachnid/is_whitelisted(mob/candidate)
	return HAS_TRAIT(candidate, TRAIT_WEB_SURFER) | HAS_TRAIT(candidate, TRAIT_ARACHNID_WEB_SURFER)
