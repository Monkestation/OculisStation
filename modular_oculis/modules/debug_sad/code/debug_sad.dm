/obj/machinery/self_actualization_device/debug
	name = "Debug Self-Actualization Device"
	desc = "Now with only 1 second cook time!"

/obj/machinery/self_actualization_device/Initialize(mapload)
	. = ..()
	processing_time = 1 SECONDS

/obj/machinery/self_actualization_device/RefreshParts()
	. = ..()
	processing_time = 1 SECONDS
