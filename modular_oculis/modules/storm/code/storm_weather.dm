/datum/weather/eidolon_storm
	name = "storm"
	desc = "A cloud of intense violetspace energy passes through the area."

	weather_message = span_userdanger("<i>You feel waves of strange energy wash over you!</i>")
	weather_overlay = "nebula_radstorm"
	weather_duration_lower = 1 MINUTES
	weather_duration_upper = 2.5 MINUTES
	weather_color = COLOR_VIOLET
	weather_sound = 'sound/announcer/alarm/bloblarm.ogg'

	end_message = null

	area_type = /area
	protected_areas = list()
	target_trait = ZTRAIT_STATION

	weather_flags = (WEATHER_MOBS | WEATHER_INDOORS | WEATHER_ENDLESS)

/datum/weather/eidolon_storm/weather_act_mob(mob/living/living)
	if(!ishuman(living) || HAS_TRAIT(living, TRAIT_GODMODE))
		return

	if(!SSradiation.can_irradiate_basic(living) || SSradiation.wearing_rad_protected_clothing(living))
		return

	radiation_pulse(
		source = living,
		max_range = 0,
		threshold = RAD_LIGHT_INSULATION,
		chance = URANIUM_IRRADIATION_CHANCE,
	)
	return ..()
