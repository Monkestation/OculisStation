/proc/toggle_looc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling ooc
		if(toggle != GLOB.ooc_allowed)
			GLOB.looc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.looc_allowed = !GLOB.looc_allowed
	to_chat(world, span_oocplain("<B>LOOC has been globally [GLOB.looc_allowed ? "enabled" : "disabled"].</B>"))
