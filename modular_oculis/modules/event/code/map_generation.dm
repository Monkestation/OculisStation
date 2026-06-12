/datum/map_generator/oculis
	modules = list(
		/datum/map_generator_module/bottom_layer/violetspace_crystal,
		/datum/map_generator_module/border/violetspace_walls,
		/datum/map_generator_module/splatter_layer/random_enemies,
		/datum/map_generator_module/bottom_layer/repressurize,
		)
	buildmode_name = "Pattern: Oculis"

/datum/map_generator_module/bottom_layer/violetspace_crystal
	spawnableTurfs = list(
		/turf/open/floor/mineral/violetspace_crystal/random = 100,
		/turf/closed/wall/mineral/violetspace_crystal = 20,
		)

/datum/map_generator_module/border/violetspace_walls
	spawnableAtoms = list()
	spawnableTurfs = list(
		/turf/closed/wall/mineral/violetspace_crystal = 100,
	)

/datum/map_generator_module/splatter_layer/random_enemies
	spawnableAtoms = list(
		/mob/living/basic/mining/watcher/cosmic_entity = 85,
		/mob/living/basic/mining/hivelord/cosmic_entity = 85,
	)
