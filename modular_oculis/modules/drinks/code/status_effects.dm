// For /datum/reagent/consumable/ethanol/drink_of_legends
/datum/status_effect/drink_of_legends
	id = "drink_of_legends"
	duration = INFINITY
	status_type = STATUS_EFFECT_UNIQUE
	var/glow_power = 3
	var/glow_range = 3
	var/glow_color = "#00ff85" // rgb: 0, 100, 52
	var/obj/effect/dummy/lighting_obj/moblight/glow

/datum/status_effect/drink_of_legends/on_apply()
	glow = owner.mob_light()
	glow.set_light_range_power_color(glow_range, glow_power, glow_color)

/datum/status_effect/drink_of_legends/on_remove()
	QDEL_NULL(glow)
