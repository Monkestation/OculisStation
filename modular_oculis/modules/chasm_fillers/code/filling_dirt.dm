/turf/open/misc/dirt/filling
	name = "filling dirt"
	desc = "Compressed dirt, meant to fill very large holes. It's very annoying and slow to walk through"
	slowdown = 1.5

/turf/open/misc/dirt/filling/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	return FALSE
