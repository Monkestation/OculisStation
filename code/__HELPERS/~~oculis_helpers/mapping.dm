/// Checks to see if two atoms are on connected Z-levels,
/// i.e on different floors of the station.
/proc/are_zs_connected(atom/a, atom/b)
	a = get_turf(a)
	b = get_turf(b)
	if(isnull(a) || isnull(b))
		return FALSE
	if(a.z == b.z)
		return TRUE
	return (b.z in SSmapping.get_connected_levels(a))
