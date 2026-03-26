/// Path for the byond-memorystats dll
#define MEMORYSTATS_DLL_PATH (world.system_type == MS_WINDOWS ? "memorystats.dll" : "./libmemorystats.so")

/datum/config_entry/flag/auto_memory_stats

#ifndef OPENDREAM
/datum/config_entry/flag/auto_memory_stats/ValidateAndSet(str_val)
	. = ..()
	if(.)
		SSmemory_stats.can_fire = config_entry_value
#endif

#ifndef OPENDREAM
// byond-memorystats does not work on OpenDream, as it relies on functions exported from byondcore.dll / libbyond.so
SUBSYSTEM_DEF(memory_stats)
	name = "Memory Statistics"
	wait = 1 MINUTES
	ss_flags = SS_BACKGROUND
	runlevels = ALL
	var/list/stats

/datum/controller/subsystem/memory_stats/OnConfigLoad()
	if(!CONFIG_GET(flag/auto_memory_stats))
		can_fire = FALSE

/datum/controller/subsystem/memory_stats/Initialize()
	if(!rustg_file_exists(MEMORYSTATS_DLL_PATH))
		ss_flags |= SS_NO_FIRE
		return SS_INIT_NO_NEED
	fire()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/memory_stats/fire(resumed)
	var/memory_summary = get_memory_stats()
	if(memory_summary)
		var/timestamp = time2text(world.timeofday, "YYYY-MM-DD_hh-mm-ss")
		rustg_file_write(json_encode(stats), "[GLOB.log_directory]/profiler/memstat-[timestamp].json")
		rustg_file_write(memory_summary, "[GLOB.log_directory]/profiler/memstat-[timestamp].txt")

/datum/controller/subsystem/memory_stats/proc/get_memory_stats()
	var/result = trimtext(call_ext(MEMORYSTATS_DLL_PATH, "memory_stats")())
	if(!findtext(result, "Server mem usage:"))
		CRASH("byond-memorystats call errored: [result || "(null)"]")
	stats = parse_memory_stats(result)
	return result

/datum/controller/subsystem/memory_stats/proc/parse_memory_stats(text)
	if(!istext(text))
		CRASH("passed non-text stat info: [text]")
	. = list()
	var/static/regex/mem_stat_regex
	if(isnull(mem_stat_regex))
		mem_stat_regex = regex(@"^\s*([^:]+):\s*([\d.]+)\s*(B|KB|MB|GB)\s*\(([,\d]+)\)$", "gmi")
	var/memtext = trimtext(text)
	if(!mem_stat_regex.Find(memtext))
		CRASH("failed to parse mem with regex")
	// var/group = 1
	var/total = 0
	do
		var/key = mem_stat_regex.group[1]
		var/size = text2num(replacetext(mem_stat_regex.group[2], ",", ""))
		var/unit = mem_stat_regex.group[3]
		var/count = text2num(replacetext(mem_stat_regex.group[4], ",", ""))

		var/size_bytes = text2bytes(size, unit)
		if(isnull(size_bytes))
			CRASH("[key] had invalid size ([size]) or unit ([unit])")
		total += size_bytes
		.[key] = list(
			"size" = num2text(size_bytes, 16),
			"count" = num2text(count, 16),
		)
	while(mem_stat_regex.Find(memtext, mem_stat_regex.next))
	.["total_bytes"] = num2text(total, 16)

#endif

ADMIN_VERB(server_memory_stats, R_DEBUG, "Server Memory Stats", "Print various statistics about the server's current memory usage. (does not work on OpenDream)", ADMIN_CATEGORY_DEBUG)
	var/box_color = "red"
#ifndef OPENDREAM
	var/result = SSmemory_stats?.initialized ? span_danger("Error fetching memory statistics!") : span_warning("SSmemory_stats hasn't been initialized yet!")
	var/memory_stats = trimtext(replacetext(SSmemory_stats.get_memory_stats(), "Server mem usage:", ""))
	if(length(memory_stats))
		result = memory_stats
		box_color = "purple"
#else
	var/result = span_danger("Memory statistics not supported on OpenDream, sorry!")
#endif
	to_chat(user, fieldset_block("Memory Statistics", result, "boxed_message [box_color]_box"), avoid_highlighting = TRUE, type = MESSAGE_TYPE_DEBUG, confidential = TRUE)


// If you want to use the proc below, I suggest moving it to oculis_helpers/bytes.dm
/**
 * Converts a memory size with unit into bytes
 *
 * Converts a given size and unit into its equivalent in bytes, using binary prefixes
 * (1 KB = 1024 bytes). Supports B, KB, MB, and GB units. Units are case-insensitive.
 * Numbers are rounded to whole bytes.
 *
 * Arguments:
 * * size - Numeric value to convert (can be integer or floating point)
 * * unit - Text unit to convert from ("B", "KB", "MB", or "GB")
 *
 * Returns: Number of bytes as an integer, or null if input is invalid
 */
/proc/text2bytes(size, unit)
	if(!IS_FINITE(size) || !istext(unit))
		return null

	switch(uppertext(unit))
		if("B")
			return round(size)
		if("KB")
			return round(size * 1024)
		if("MB")
			return round(size * 1024 * 1024)
		if("GB")
			return round(size * 1024 * 1024 * 1024)
		else
			return null


#undef MEMORYSTATS_DLL_PATH

