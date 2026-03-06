
/datum/config_entry/flag/auto_memory_stats

#ifndef OPENDREAM
/datum/config_entry/flag/auto_memory_stats/ValidateAndSet(str_val)
	. = ..()
	if(.)
		SSmemory_stats.can_fire = config_entry_value
#endif
