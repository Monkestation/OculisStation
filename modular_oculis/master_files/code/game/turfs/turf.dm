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
