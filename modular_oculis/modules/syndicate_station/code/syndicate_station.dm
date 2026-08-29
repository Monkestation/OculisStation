/datum/lazy_template/syndicate_station
	key = LAZY_TEMPLATE_KEY_SYNDICATE_STATION
	map_dir = "_maps/oculis/lazy_templates"
	map_name = "syndicate_station"

/area/centcom/octavia
	name = "SSS Octavia"
	icon_state = "syndie-ship"
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	area_flags = NOTELEPORT
	flags_1 = NONE
	ambience_index = AMBIENCE_DANGER

/area/centcom/octavia/control
	name = "SSS Octavia - Control Room"
	icon_state = "syndie-control"
	static_lighting = TRUE

/area/centcom/octavia/expansion_bombthreat
	name = "SSS Octavia - Ordnance Laboratory"
	icon_state = "syndie-elite"
	static_lighting = TRUE
	ambience_index = AMBIENCE_ENGI

/area/centcom/octavia/expansion_bioterrorism
	name = "SSS Octavia - Bio-Weapon Laboratory"
	icon_state = "syndie-elite"
	static_lighting = TRUE
	ambience_index = AMBIENCE_MEDICAL

/area/centcom/octavia/expansion_chemicalwarfare
	name = "SSS Octavia - Chemical Weapon Manufacturing Plant"
	icon_state = "syndie-elite"
	static_lighting = TRUE
	ambience_index = AMBIENCE_REEBE

/area/centcom/octavia/expansion_fridgerummage
	name = "SSS Octavia - Perishables and Foodstuffs Storage"
	icon_state = "syndie-elite"
	static_lighting = TRUE

/area/centcom/octavia/expansion_custodialcloset
	name = "SSS Octavia - Custodial Closet"
	icon_state = "syndie-elite"
