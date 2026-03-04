/area
	/// Extra A* weight applied to all turfs in this area.
	var/astar_weight = ASTAR_WEIGHT_AREA_DEFAULT

/area/station/hallway
	astar_weight = ASTAR_WEIGHT_AREA_HALLS // hallways should be pathed through MORE often

// maints is yucky
/area/station/maintenance
	astar_weight = ASTAR_WEIGHT_AREA_MAINTS

/area/station/service/library/abandoned
	astar_weight = ASTAR_WEIGHT_AREA_MAINTS

/area/station/service/hydroponics/garden/abandoned
	astar_weight = ASTAR_WEIGHT_AREA_MAINTS

/area/station/service/kitchen/abandoned
	astar_weight = ASTAR_WEIGHT_AREA_MAINTS

/area/station/service/electronic_marketing_den
	astar_weight = ASTAR_WEIGHT_AREA_MAINTS

/area/station/service/abandoned_gambling_den
	astar_weight = ASTAR_WEIGHT_AREA_MAINTS

/area/station/service/theater/abandoned
	astar_weight = ASTAR_WEIGHT_AREA_MAINTS

/area/station/medical/abandoned
	astar_weight = ASTAR_WEIGHT_AREA_MAINTS


/area/station/science/research/abandoned
	astar_weight = ASTAR_WEIGHT_AREA_MAINTS

// very slight preference for public areas like dorms, bar, etc
/area/station/commons/dorms
	astar_weight = ASTAR_WEIGHT_AREA_COMMONS

/area/station/commons/locker
	astar_weight = ASTAR_WEIGHT_AREA_COMMONS

/area/station/commons/fitness
	astar_weight = ASTAR_WEIGHT_AREA_COMMONS

/area/station/service/bar
	astar_weight = ASTAR_WEIGHT_AREA_COMMONS

/area/station/service/library
	astar_weight = ASTAR_WEIGHT_AREA_COMMONS

/area/station/service/cafeteria
	astar_weight = ASTAR_WEIGHT_AREA_COMMONS

/area/station/service/kitchen/diner
	astar_weight = ASTAR_WEIGHT_AREA_COMMONS

// ensure that backroom areas keep the default weight
/area/station/service/library/private
	astar_weight = ASTAR_WEIGHT_AREA_DEFAULT

/area/station/service/bar/backroom
	astar_weight = ASTAR_WEIGHT_AREA_DEFAULT
