/obj/machinery
	var/climbable_pixel_shift = 0 // If set to a value above 0, the machinery becomes climbable with this specific pixel shift elevation.

/obj/machinery/Initialize(mapload)
	. = ..()
	if(climbable_pixel_shift)
		//Climbing time and stun time are based on how tall the climbed thing is
		AddElement(/datum/element/climbable, climb_time = climbable_pixel_shift/3 SECONDS, climb_stun = climbable_pixel_shift/4 SECONDS)
		AddElement(/datum/element/elevation, pixel_shift = climbable_pixel_shift)

/* === Climb Computers === */
/obj/machinery/computer
	climbable_pixel_shift = 10

/obj/machinery/modular_computer
	climbable_pixel_shift = 10

//Computer-based machine climbing exceptions
/obj/machinery/computer/slot_machine
	climbable_pixel_shift = 0

/obj/machinery/computer/pandemic
	climbable_pixel_shift = 0

/obj/machinery/modular_computer/preset/time_clock
	climbable_pixel_shift = 0

/obj/machinery/computer/cryopod
	climbable_pixel_shift = 0

/* === Climb Machines === */
//Climb lathes
/obj/machinery/power/manufacturing/lathe
	climbable_pixel_shift = 20

//Climb circuit imprinters
/obj/machinery/rnd/production
	climbable_pixel_shift = 20

//Climb autolathes
/obj/machinery/autolathe
	climbable_pixel_shift = 20

//Climb charging station //check rechargestation.dm in this module if issues arise
/obj/machinery/recharge_station
	climbable_pixel_shift = 10

//Climb canisters
/obj/machinery/portable_atmospherics/canister
	climbable_pixel_shift = 25

//Climb transit tubes
/obj/machinery/transit_tube
	climbable_pixel_shift = 10

//Climb pacmans
/obj/machinery/power/port_gen/pacman
	climbable_pixel_shift = 20

//Climb thermomachines
/obj/machinery/atmospherics/components/unary/thermomachine
	climbable_pixel_shift = 15

//Climb R&D servers
/obj/machinery/rnd/server
	climbable_pixel_shift = 20

//Climb ammo workbench
/obj/machinery/ammo_workbench
	climbable_pixel_shift = 15

//Climb microwave
/obj/machinery/microwave
	climbable_pixel_shift = 25

//Climb washing machine
/obj/machinery/washing_machine
	climbable_pixel_shift = 20

//Climb message server
/obj/machinery/telecomms/message_server
	climbable_pixel_shift = 20

//Climb telecomms server
/obj/machinery/telecomms/server
	climbable_pixel_shift = 20
//Climb oven
/obj/machinery/oven
	climbable_pixel_shift = 20

//BUT NOT THE RANGE, YOU'LL BURN YOURSELF
/obj/machinery/oven/range
	climbable_pixel_shift = 0

//Climb PDA painters
/obj/machinery/pdapainter
	climbable_pixel_shift = 20

//Climb mech rechargers
/obj/machinery/mech_bay_recharge_port
	climbable_pixel_shift = 20
