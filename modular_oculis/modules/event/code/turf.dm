/turf/closed/wall/mineral/violetspace_crystal
	name = "purple wall"
	desc = "A wall made of crystalline outcrops."
	icon = 'modular_oculis/modules/event/icons/walls.dmi'
	icon_state = "plasma_wall-0"
	base_icon_state = "plasma_wall"
	sheet_type = /obj/item/stack/sheet/bluespace_crystal
	hardness = 70 // I'll tentatively compare it to Bismuth
	thermal_conductivity = 0.04
	slicing_duration = 200
	explosive_resistance = 3
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_CRYSTAL_WALL
	canSmoothWith = SMOOTH_GROUP_CRYSTAL_WALL
	custom_materials = list(/datum/material/bluespace = SHEET_MATERIAL_AMOUNT*2)
	rust_resistance = RUST_RESISTANCE_ORGANIC
	decon_type = /turf/open/floor/mineral/violetspace_crystal/random

/turf/closed/wall/mineral/violetspace_crystal/break_wall()
	new sheet_type(src, sheet_amount)

/obj/item/stack/tile/mineral/violetspace_crystal
	name = "purple floor tile"
	singular_name = "purple floor tile"
	desc = "A tile made out of crystalline outcrops."
	icon = 'icons/obj/tiles.dmi'
	icon_state = "tile_tram_dark"
	inhand_icon_state = "tile-tram"
	mats_per_unit = list(/datum/material/bluespace = SHEET_MATERIAL_AMOUNT*0.25)
	turf_type = /turf/open/floor/mineral/violetspace_crystal
	mineralType = /obj/item/stack/ore/bluespace_crystal
	merge_type = /obj/item/stack/tile/mineral/violetspace_crystal

/turf/open/floor/mineral/violetspace_crystal
	name = "purple floor"
	icon = 'modular_oculis/modules/event/icons/floor.dmi'
	icon_state = "violet_floor"
	floor_tile = /obj/item/stack/tile/mineral/violetspace_crystal
	icons = list("violet_floor", "violet_strong", "violet_cathedral")
	baseturfs = /turf/open/space
	custom_materials = list(/datum/material/bluespace = SMALL_MATERIAL_AMOUNT*5)
	rust_resistance = RUST_RESISTANCE_ORGANIC
	damaged_dmi = null

/turf/open/floor/mineral/violetspace_crystal/break_tile()
	return //unbreakable

/turf/open/floor/mineral/violetspace_crystal/burn_tile()
	return //unburnable

/turf/open/floor/mineral/violetspace_crystal/strong
	icon_state = "violet_strong"

/turf/open/floor/mineral/violetspace_crystal/cathedral
	icon_state = "violet_cathedral"

/turf/open/floor/mineral/violetspace_crystal/random

/turf/open/floor/mineral/violetspace_crystal/random/Initialize(mapload)
	. = ..()
	icon_state = pick(list("violet_floor", "violet_strong", "violet_cathedral"))
