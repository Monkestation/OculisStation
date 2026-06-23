
//Climb computers
/obj/machinery/computer/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)

/obj/machinery/modular_computer/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)

//Computer-based machine climbing exceptions
/obj/machinery/computer/slot_machine/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()

	RemoveElement(/datum/element/climbable)
	RemoveElement(/datum/element/elevation, pixel_shift = 10)

/obj/machinery/computer/pandemic/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()

	RemoveElement(/datum/element/climbable)
	RemoveElement(/datum/element/elevation, pixel_shift = 10)

//Climb lathes
/obj/machinery/power/manufacturing/lathe/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 20)

//Climb circuit imprinters
/obj/machinery/rnd/production/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 20)

//Climb autolathes
/obj/machinery/autolathe/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 20)

//Climb canisters
/obj/machinery/portable_atmospherics/canister/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 25)

//Climb charging station
/obj/machinery/recharge_station/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)

//Climb transit tubes
/obj/machinery/transit_tube/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)

//Climb pacmans
/obj/machinery/power/port_gen/pacman/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)

//Climb thermomachines
/obj/machinery/atmospherics/components/unary/thermomachine/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)

//Climb R&D servers
/obj/machinery/rnd/server/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)

//Climb ammo workbench
/obj/machinery/ammo_workbench/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)

//Climb microwave
/obj/machinery/microwave/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)

//Climb washing machine
/obj/machinery/washing_machine/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)

//Climb message server
/obj/machinery/telecomms/message_server/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)
//Climb telecomms server
/obj/machinery/telecomms/server/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)
//Climb oven
/obj/machinery/oven/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)
