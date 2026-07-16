/obj/structure
	var/climbable_pixel_shift = 0 // If set to a value above 0, the structure becomes climbable with this specific pixel shift elevation.

/obj/structure/Initialize(mapload)
	. = ..()
	if(climbable_pixel_shift)
		//Climbing time and stun time are based on how tall the climbed thing is
		AddElement(/datum/element/climbable, climb_time = climbable_pixel_shift/3 SECONDS, climb_stun = climbable_pixel_shift/3 SECONDS)
		AddElement(/datum/element/elevation, pixel_shift = climbable_pixel_shift)

//Climb tank dispensers
/obj/structure/tank_dispenser
	climbable_pixel_shift = 25

//Climb morgues
/obj/structure/bodycontainer/morgue
	climbable_pixel_shift = 10

//Climb fluid tanks (water/welding fuel etc. Also covers plumbed ones)
/obj/structure/reagent_dispensers
	climbable_pixel_shift = 20

//Don't climb the water cooler... it's too tall
/obj/structure/reagent_dispensers/water_cooler
	climbable_pixel_shift = 0

//Fixes pepper spray dispensers and virus food dispensers bumping your height when you get on a tile that technically holds that dispenser but it looks like it's mounted on the wall next to it
/obj/structure/reagent_dispensers/wall
	climbable_pixel_shift = 0

//ditto, with telescreens
/obj/machinery/computer/security/telescreen/
	climbable_pixel_shift = 0
