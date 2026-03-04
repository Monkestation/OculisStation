/area
	/// Extra A* weight applied to all turfs in this area.
	var/astar_weight = 0

/area/station/hallway
	astar_weight = -20 // hallways should be pathed through MORE often

/area/station/maintenance
	astar_weight = 10
