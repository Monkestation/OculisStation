/turf
	/// The weight of the turf for A* pathfinding.
	var/astar_weight = ASTAR_WEIGHT_TURF_DEFAULT

/turf/ChangeTurf(path, list/new_baseturfs, flags)
	var/old_astar_weight = (astar_weight - src::astar_weight) // just get the weight that isn't the turf
	. = ..()
	if(old_astar_weight)
		var/turf/new_turf = .
		if(new_turf && !(flags & CHANGETURF_SKIP))
			new_turf.astar_weight += old_astar_weight

/turf/open/chasm
	astar_weight = ASTAR_WEIGHT_TURF_NEVER

/turf/open/cliff
	astar_weight = ASTAR_WEIGHT_TURF_ALMOST_NEVER

/turf/open/misc/ice
	astar_weight = ASTAR_WEIGHT_TURF_DISCOURAGED

/turf/open/misc/dirt
	astar_weight = ASTAR_WEIGHT_TURF_DEFAULT * 1.2

/turf/open/misc/dirt/station
	astar_weight = ASTAR_WEIGHT_TURF_DEFAULT

/turf/open/misc/dirt/dark/station
	astar_weight = ASTAR_WEIGHT_TURF_DEFAULT

/turf/open/water
	astar_weight = ASTAR_WEIGHT_TURF_DISCOURAGED

/turf/open/floor/plating
	astar_weight = ASTAR_WEIGHT_TURF_DISCOURAGED

/turf/open/space
	astar_weight = ASTAR_WEIGHT_TURF_ALMOST_NEVER

/turf/open/floor/tram/plate
	astar_weight = ASTAR_WEIGHT_TURF_DISCOURAGED
