/datum/design/module/mod_riding_saddle
	name = "Riding Saddle Module"
	id = "mod_riding_saddle"
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT *1.25,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/mod/module/saddle

/datum/techweb_node/mod_equip/New()
	. = ..()
	design_ids += list(
		"mod_riding_saddle",
	)
