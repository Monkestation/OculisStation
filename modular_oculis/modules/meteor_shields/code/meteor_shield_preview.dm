/proc/meteor_sat_turf_preview(atom/source, view_range)
	var/list/new_coverage = list()
	var/list/already_covered = list()
	var/list/obscured = list()
	var/list/solid = list()

	if(isnull(view_range))
		view_range = /obj/machinery/satellite/meteor_shield::kill_range

	var/turf/source_turf = get_turf(source)
	for(var/obj/machinery/satellite/meteor_shield/sat as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/satellite/meteor_shield))
		if(!sat.active || (sat.obj_flags & EMAGGED) || sat == source)
			continue
		var/turf/sat_turf = get_turf(sat)
		if(sat_turf != source_turf.z)
			var/obj/effect/abstract/meteor_shield_proxy/proxy = sat.proxies[source_turf.z]
			if(proxy)
				sat_turf = get_turf(proxy)
			else
				continue
		if(get_dist(source_turf, sat_turf) > max(sat.kill_range, /obj/machinery/satellite/meteor_shield::kill_range) * 2)
			continue
		already_covered |= sat.get_covered_turfs(sat_turf.z)

	for(var/turf/turf as anything in RANGE_TURFS(view_range, source_turf))
		if(isclosedturf(turf) && !istransparentturf(turf))
			solid += turf
			continue
		if(!has_view_line(source_turf, turf))
			obscured += turf
		else if(!(turf in already_covered))
			new_coverage += turf

	return alist(
		"new_coverage" = new_coverage,
		"already_covered" = already_covered,
		"obscured" = obscured,
		"solid" = solid,
	)
