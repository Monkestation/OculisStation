/turf
	/// The weight of the turf for A* pathfinding.
	var/astar_weight = 50

/turf/ChangeTurf(path, list/new_baseturfs, flags)
	var/old_astar_weight = (astar_weight - src::astar_weight) // just get the weight that isn't the turf
	. = ..()
	if(old_astar_weight)
		var/turf/new_turf = .
		if(new_turf && !(flags & CHANGETURF_SKIP))
			new_turf.astar_weight += old_astar_weight

/turf/open/chasm
	astar_weight = 9999

/turf/open/cliff
	astar_weight = 500

/turf/open/misc/ice
	astar_weight = 75

/turf/open/misc/dirt
	astar_weight = 60

/turf/open/misc/dirt/station
	astar_weight = /turf/open::astar_weight

/turf/open/misc/dirt/dark/station
	astar_weight = /turf/open::astar_weight

/turf/open/water
	astar_weight = 75

/turf/open/floor/plating
	astar_weight = 75

/turf/open/space
	astar_weight = 500

/turf/open/floor/tram/plate
	astar_weight = 75
