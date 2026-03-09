ADMIN_VERB(reload_lobby_notices, R_NONE, "Reload Lobby Notices", "Reloads lobby notices from disk.", ADMIN_CATEGORY_DEBUG)
	config.load_lobby_notices()
	BLACKBOX_LOG_ADMIN_VERB("Reload Lobby Notices")
	message_admins("[key_name_admin(user)] reloaded lobby notices")

/datum/controller/configuration
	var/list/lobby_notices

/datum/controller/configuration/LoadMisc()
	. = ..()
	load_lobby_notices()

/datum/controller/configuration/proc/load_lobby_notices()
	lobby_notices?.Cut()
	var/files = list("[directory]/lobby_notices.json", "[directory]/oculis/lobby_notices.json")
	var/the_file
	for (var/path in files)
		if(fexists(file(path)))
			the_file = path
			break

	var/rawnotices = file2text(the_file)
	if(rawnotices)
		var/parsed = safe_json_decode(rawnotices)
		if(!parsed)
			log_config("JSON parsing failure for lobby_notices.json")
			DelayedMessageAdmins("JSON parsing failure for lobby_notices.json")
		else
			lobby_notices = parsed

/datum/controller/configuration/proc/ShowLobbyNotices(target)
	if (!length(config.lobby_notices)) return FALSE
	var/final_notices = ""
	var/do_final_top_separator = FALSE
	for (var/notice in config.lobby_notices)
		var/do_separator = FALSE
		if (islist(notice))
			var/list/_notice = notice
			if (_notice["CHATBOX_SAFE"])
				do_separator = TRUE
				final_notices = "[final_notices]<br>[_notice["CHATBOX_SAFE"]]"
		else
			final_notices = "[final_notices]<br>[notice]"
			do_separator = TRUE

		if (do_separator)
			do_final_top_separator = TRUE
			final_notices = "[final_notices]<hr class='solid'>"

	if(!final_notices)
		return FALSE
	to_chat(target, "[do_final_top_separator ? "<hr class='solid'>" : ""][final_notices]")

	return TRUE
// I want to use this but i decided i didnt need to use it
/*
/proc/compare_dates(year1, month1, day1, year2, month2, day2)
		// TRUE if date1 >= date2, FALSE if date1 < date2
		var/comparable_date1 = year1 * 10000 + month1 * 100 + day1
		var/comparable_date2 = year2 * 10000 + month2 * 100 + day2

		return comparable_date1 >= comparable_date2
*/

/*  in some other proc
	var/cur_day = text2num(time2text(world.realtime, "DD", "PT"))
	var/cur_mon = text2num(time2text(world.realtime, "MM", "PT"))
	var/cur_year = text2num(time2text(worldrealtime, "YYYY", "PT"))

	if (!compare_dates(cur_year, cur_mon, cur_day, 2025, 1, 15))
		motd = motd + "[motd]<br>" + ""
*/


/datum/latejoin_menu/ui_static_data(mob/user)
	. = ..()
	.["notices"] = config.lobby_notices

/datum/changelog/ui_static_data(mob/user)
	. = ..()
	.["notices"] = config.lobby_notices
