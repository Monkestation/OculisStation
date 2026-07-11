/obj/item/gun/ballistic/revolver/c38
	w_class = WEIGHT_CLASS_SMALL // concealed carry blickinator

/obj/item/gun/ballistic/revolver/russian/Initialize(mapload)
	/* // OCULIS EDIT REMOVAL START
	. = ..()
	if(mapload)
		new /obj/item/gun/ballistic/revolver/sol(get_turf(src))
		return INITIALIZE_HINT_QDEL
	*/ // OCULIS EDIT REMOVAL END
	// OCULIS EDIT ADDITION START
	if(mapload)
		return INITIALIZE_HINT_QDEL // Don't bother initalizing it, we're deleting it anyways and replacing it with nothing
	else
		return ..()
	// OCULIS EDIT ADDITION END

/obj/item/gun/ballistic/revolver/russian/soul/Initialize(mapload)
	. = ..()
	if (mapload)
		new /obj/item/stack/spacecash/c1000{amount = 2}(get_turf(src)) //done for the relic since it can be sold for 4-5k
