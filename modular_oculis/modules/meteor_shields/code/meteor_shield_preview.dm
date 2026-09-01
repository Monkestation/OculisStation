/proc/get_meteor_sat_overlapping_turfs(atom/source)
	. = list()
	var/turf/our_turf = get_turf(source)
	for(var/obj/machinery/satellite/meteor_shield/sat as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/satellite/meteor_shield))
		if(!sat.active || (sat.obj_flags & EMAGGED) || sat == source)
			continue
		var/turf/sat_turf = get_turf(sat)
		if(sat_turf != our_turf.z)
			var/obj/effect/abstract/meteor_shield_proxy/proxy = sat.proxies[our_turf.z]
			if(proxy)
				sat_turf = get_turf(proxy)
			else
				continue
		if(get_dist(our_turf, sat_turf) > max(sat.kill_range, /obj/machinery/satellite/meteor_shield::kill_range) * 2)
			continue
		. |= sat.get_covered_turfs(sat_turf.z)
