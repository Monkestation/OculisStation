/obj/machinery/recharge_station/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/climbable)

/obj/machinery/recharge_station/open_machine(drop = TRUE, density_to_set = FALSE)
	. = ..(drop, density_to_set)
	RemoveElement(/datum/element/climbable)

/obj/machinery/recharge_station/close_machine(atom/movable/target, density_to_set = TRUE)
	. = ..(target, density_to_set)
	AddElement(/datum/element/climbable)
