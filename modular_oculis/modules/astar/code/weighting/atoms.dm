/atom/movable
	/// The weight for A* pathfinding added to turfs this atom is on.
	var/astar_weight

/atom/movable/Initialize(mapload, ...)
	. = ..()
	if(astar_weight && isturf(loc))
		var/turf/turf_loc = loc
		turf_loc.astar_weight += astar_weight

/atom/movable/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	if(astar_weight)
		var/turf/old_turf = get_turf(old_loc)
		var/turf/new_turf = get_turf(src)
		if(old_turf)
			old_turf.astar_weight -= astar_weight
		if(new_turf)
			new_turf.astar_weight += astar_weight

/obj/structure/plasticflaps
	astar_weight = ASTAR_WEIGHT_OBJ_DISCOURAGED

/obj/structure/chair
	astar_weight = ASTAR_WEIGHT_OBJ_MEH

/obj/structure/chair/sofa
	astar_weight = ASTAR_WEIGHT_OBJ_MEH * 2.5
