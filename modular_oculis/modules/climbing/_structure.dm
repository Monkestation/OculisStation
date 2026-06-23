/obj/structure
    var/climbable_pixel_shift = 0 // If set to a value above 0, the structure becomes climbable with this specific pixel shift elevation.

/obj/structure/Initialize(mapload)
    . = ..()
    if(climbable_pixel_shift)
        AddElement(/datum/element/climbable)
        AddElement(/datum/element/elevation, pixel_shift = climbable_pixel_shift)

//Climb tank dispensers
/obj/structure/tank_dispenser
	climbable_pixel_shift = 25

//Climb morgues
/obj/structure/bodycontainer/morgue
	climbable_pixel_shift = 10

//Climb fluid tanks (water/welding fuel etc. Also covers plumbed ones)
/obj/structure/reagent_dispensers
	climbable_pixel_shift = 25

//Don't climb the water cooler... it's too tall
/obj/structure/reagent_dispensers/water_cooler
	climbable_pixel_shift = 0
