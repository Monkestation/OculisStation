/obj/machinery/self_actualization_device/debug
	name = "Debug Self-Actualization Device"
	desc = "Now with only 1 second cook time!"
	processing_time = 1 SECONDS

/obj/machinery/self_actualization_device/debug/RefreshParts()
	. = ..()
	processing_time = 1 SECONDS
