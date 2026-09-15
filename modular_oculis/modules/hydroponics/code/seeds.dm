/obj/item/seeds
	///infusion damage
	var/infusion_damage = 0

/obj/item/seeds/proc/return_all_data()
	var/obj/grown_food = product
	var/base64 = icon2base64(icon(initial(grown_food.icon), initial(grown_food.icon_state)))
	return list(
		"image" = base64,
		"name" = name,
		"desc" = desc,
		"potency" = potency,
		"weed_rate" = weed_rate,
		"weed_chance" = weed_chance,
		"yield" = yield,
		"ref" = REF(src),
		"production_speed" = production,
		"maturation_speed" = maturation,
		"endurance" = endurance,
		"lifespan" = lifespan,
	)
