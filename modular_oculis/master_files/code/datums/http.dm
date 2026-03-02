/datum/http_request/New(...)
	. = ..()
	if(length(args))
		src.prepare(arglist(args))

/// Helper for `new /datum/http_request` with a return type,
/// so you can do stuff like `http_request(...).begin_async()`
/proc/http_request(...) as /datum/http_request
	RETURN_TYPE(/datum/http_request)
	return new /datum/http_request(arglist(args))


/**
 * Returns a user-agent for http(s) requests
 * * comment - {str || list} String or list, comments to be applied to the user-agent
 *
 * ```
 * // returns `BYOND 516.1666 ss13-oculisstation/deadbeef (Comment-One; Comment-Two)`
 * get_useragent(list("Comment-One", "Comment-Two"))
 * // returns `BYOND 516.1666 ss13-oculisstation/deadbeef (My-comment)`
 * get_useragent("My-comment")
 * ```
 */
/proc/get_useragent(comment)
	. = "BYOND/[DM_VERSION].[DM_BUILD] ss13-oculisstation/[copytext(GLOB.revdata.commit, 0, 8) || "NOCOMMIT"] "

	if (istext(comment))
		. += " ([comment])"
	else if (islist(comment))
		var/list/comments = comment
		if (length(comments))
			. += " ("
			for (var/i = 1 to length(comments))
				. += "[comments[i]]"
				if (i == length(comments))
					. += ")"
					break
				. += ";"
