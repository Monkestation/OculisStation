/atom/movable/screen/meteor_sat_turf_preview
	var/atom/source
	var/turf/center
	var/view_range

	var/list/new_coverage = list()
	var/list/already_covered = list()
	var/list/obscured = list()
	var/list/solid = list()

/atom/movable/screen/meteor_sat_turf_preview/Initialize(mapload, datum/hud/hud_owner, atom/source, view_range)
	..()
	src.center = center
	if(!isatom(source) || QDELING(source))
		. = INITIALIZE_HINT_QDEL
		CRASH("Tried to create [type] with an invalid source!")
	src.source = source
	src.center = get_turf(source)
	src.view_range = isnum(view_range) ? view_range : round(/obj/machinery/satellite/meteor_shield::kill_range * 1.5, 1)
	return INITIALIZE_HINT_LATELOAD

/atom/movable/screen/meteor_sat_turf_preview/LateInitialize()
	get_preview_turfs()
	icon = generate_appearance()

/atom/movable/screen/meteor_sat_turf_preview/Destroy(force)
	new_coverage.Cut()
	already_covered.Cut()
	obscured.Cut()
	solid.Cut()
	return ..()

/atom/movable/screen/meteor_sat_turf_preview/proc/get_preview_turfs()
	new_coverage.Cut()
	already_covered.Cut()
	obscured.Cut()
	solid.Cut()

	for(var/obj/machinery/satellite/meteor_shield/sat as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/satellite/meteor_shield))
		if(!sat.active || (sat.obj_flags & EMAGGED) || sat == source)
			continue
		var/turf/sat_turf = get_turf(sat)
		if(sat_turf != center.z)
			var/obj/effect/abstract/meteor_shield_proxy/proxy = sat.proxies[center.z]
			if(proxy)
				sat_turf = get_turf(proxy)
			else
				continue
		if(get_dist(center, sat_turf) > max(sat.kill_range, view_range) * 2)
			continue
		already_covered |= sat.get_covered_turfs(sat_turf.z)

	for(var/turf/turf as anything in RANGE_TURFS(view_range, center))
		if(isclosedturf(turf) && !istransparentturf(turf))
			solid += turf
			continue
		if(!has_view_line(center, turf))
			obscured += turf
		else if(!(turf in already_covered))
			new_coverage += turf

/atom/movable/screen/meteor_sat_turf_preview/proc/generate_appearance() as /icon
	var/icon/new_icon = icon('icons/ui_icons/minimap/minimap.dmi')
