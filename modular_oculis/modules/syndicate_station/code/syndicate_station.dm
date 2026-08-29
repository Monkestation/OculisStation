/datum/lazy_template/syndicate_station
	key = LAZY_TEMPLATE_KEY_SYNDICATE_STATION
	map_dir = "_maps/oculis/lazy_templates"
	map_name = "syndicate_station"

/area/centcom/syndicate_mothership
	name = "Syndicate Space Station"
	icon_state = "syndie-ship"
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	area_flags = NOTELEPORT
	flags_1 = NONE
	ambience_index = AMBIENCE_DANGER

/area/centcom/syndicate_mothership/control
	name = "Syndicate Space Station - Control Room"
	icon_state = "syndie-control"
	static_lighting = TRUE

/area/centcom/syndicate_mothership/expansion_bombthreat
	name = "Syndicate Space Station - Ordnance Laboratory"
	icon_state = "syndie-elite"
	static_lighting = TRUE
	ambience_index = AMBIENCE_ENGI

/area/centcom/syndicate_mothership/expansion_bioterrorism
	name = "Syndicate Space Station - Bio-Weapon Laboratory"
	icon_state = "syndie-elite"
	static_lighting = TRUE
	ambience_index = AMBIENCE_MEDICAL

/area/centcom/syndicate_mothership/expansion_chemicalwarfare
	name = "Syndicate Space Station - Chemical Weapon Manufacturing Plant"
	icon_state = "syndie-elite"
	static_lighting = TRUE
	ambience_index = AMBIENCE_REEBE

/area/centcom/syndicate_mothership/expansion_fridgerummage
	name = "Syndicate Space Station - Perishables and Foodstuffs Storage"
	icon_state = "syndie-elite"
	static_lighting = TRUE

/area/centcom/syndicate_mothership/expansion_custodialcloset
	name = "Syndicate Space Station - Custodial Closet"
	icon_state = "syndie-elite"
