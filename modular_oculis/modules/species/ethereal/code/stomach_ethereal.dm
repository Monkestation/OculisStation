/obj/item/organ/stomach/ethereal/proc/on_owner_examine(datum/source, mob/user, list/examine_list)
	if(!isethereal(owner)) //All of these effect the light the ethereal emits, it makes no sense on a non-ethereal
		return

	switch(cell.charge())
		if(-INFINITY to ETHEREAL_CHARGE_NONE)
			examine_list += span_boldwarning("[owner.p_Their()] light is very dim, and is flickering on and off.")
		if(ETHEREAL_CHARGE_NONE to ETHEREAL_CHARGE_LOWPOWER)
			examine_list += span_warning("[owner.p_Their()] light is very dim, and is flickering slightly.")
		if(ETHEREAL_CHARGE_LOWPOWER to ETHEREAL_CHARGE_NORMAL)
			examine_list += span_warning("[owner.p_Their()] light is dimming.")
		if(ETHEREAL_CHARGE_FULL to ETHEREAL_CHARGE_OVERLOAD)
			examine_list += span_warning("[owner.p_They()] seem[owner.p_s()] unusually bright, and spark occasionally.")
		if(ETHEREAL_CHARGE_OVERLOAD to ETHEREAL_CHARGE_DANGEROUS)
			examine_list += span_boldwarning("Electricity is arcing off of [owner.p_them()]!.")
