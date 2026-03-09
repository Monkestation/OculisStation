/turf/open/openspace/can_cross_safely(atom/movable/crossing)
	. = ..()
	if(.)
		return
	var/turf/below = GET_TURF_BELOW(src)
	if(below)
		var/obj/structure/stairs/stairs_below = locate() in below
		if(stairs_below?.isTerminator())
			return TRUE

/turf/open/openspace/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	. = ..()
	if(. || !pass_info.multiz_checks)
		return
	var/turf/turf_below = GET_TURF_BELOW(src)
	if(turf_below)
		var/obj/structure/stairs/stairs_below = locate() in turf_below
		if(stairs_below?.isTerminator())
			return TRUE
