/datum/station_trait/nebula/storm
	name = "Eidolon Storm"
	trait_type = STATION_TRAIT_NEGATIVE
	trait_flags = STATION_TRAIT_SPACE_BOUND
	weight = 1
	show_in_report = TRUE
	report_message = "This station is located inside the Eidolon Storm. Redspace Anchor functionality must be at top priority."
	trait_to_give = STATION_TRAIT_EIDOLON_STORM

	blacklist = list()
	dynamic_threat_id = "Eidolon Storm"

	nebula_layer = /atom/movable/screen/parallax_layer/random/space_gas/storm
	/// Area's that are part of the radioactive nebula
	var/radioactive_areas = /area/space

/datum/station_trait/nebula/storm/New()
	. = ..()

	RegisterSignal(SSdcs, COMSIG_RULESET_BODY_GENERATED_FROM_GHOSTS, PROC_REF(on_spawned_mob))

	for(var/area/target as anything in get_areas(radioactive_areas))
		RegisterSignal(target, COMSIG_AREA_ENTERED, PROC_REF(on_entered))
		RegisterSignal(target, COMSIG_AREA_EXITED, PROC_REF(on_exited))

/datum/station_trait/nebula/storm/on_round_start()
	. = ..()

/datum/station_trait/nebula/storm/process(seconds_per_tick)
	apply_nebula_effect()

/datum/station_trait/nebula/storm/proc/on_entered(area/space, atom/movable/enterer, area/old_area)
	SIGNAL_HANDLER

/datum/station_trait/nebula/storm/proc/on_exited(area/space, atom/movable/exiter, direction)
	SIGNAL_HANDLER

/datum/station_trait/nebula/storm/proc/on_spawned_mob(datum/source, mob/spawned_mob)
	SIGNAL_HANDLER

/datum/station_trait/nebula/storm/proc/apply_nebula_effect()
	/*
	if() //admins can force this
		if(!SSweather.get_weather_by_type(/datum/weather/eidolon_storm))
			SSweather.run_weather(/datum/weather/eidolon_storm)
		return

	//No storms, shielding is good!
	var/datum/weather/weather = SSweather.get_weather_by_type(/datum/weather/eidolon_storm)
	weather?.wind_down()
	*/
