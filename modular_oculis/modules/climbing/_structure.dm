//Climb tank dispensers
/obj/structure/tank_dispenser/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 25)

//Climb morgues
/obj/structure/bodycontainer/morgue/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/climbable)
	AddElement(/datum/element/elevation, pixel_shift = 10)
