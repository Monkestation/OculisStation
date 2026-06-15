
//Climb computers
/obj/machinery/computer/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)

/obj/machinery/modular_computer/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)

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

//Climb tank dispensers
/obj/structure/tank_dispenser/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 30)

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
