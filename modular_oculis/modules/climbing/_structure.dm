/obj/structure
    var/climbable_pixel_shift = 0 // If set to a value above 0, the structure becomes climbable with this specific pixel shift elevation.

/obj/structure/Initialize(mapload)
    . = ..()
    if(climbable_pixel_shift)
        AddElement(/datum/element/climbable)
        AddElement(/datum/element/elevation, pixel_shift = climbable_pixel_shift)

//Climb tank dispensers
/obj/structure/tank_dispenser/Initialize(mapload)
	climbable_pixel_shift = 25

//Climb morgues
/obj/structure/bodycontainer/morgue/Initialize(mapload)
	climbable_pixel_shift = 10

/obj/structure/reagent_dispensers
	climbable_pixel_shift = 25
