/obj/item/stock_parts/power_store/cell/powerpack
	name = "laser powerpack"
	desc = "this is a rare peripheral for lasguns consisting of some rapidcharge drivers and a standard issue laser powercell. simply press it against an energy weapon's contacts to instantly charge it"
	icon = 'icons/obj/weapons/guns/ammo.dmi'
	icon_state = "oldrifle"



/obj/item/gun/energy/attackby(obj/item/stock_parts/power_store/cell/powerpack/I, mob/living/user)
	if(!istype(I))
		return ..()
	missing_charge = cell.maxcharge - cell.charge
	cell.charge += min(missing_charge, I.charge)
	user.visible_message(span_danger("[user] Is draining their powerpack into their gun"))
	I.charge = max(0, I.charge - missing_charge)
	recharge_newshot(no_cyborg_drain = TRUE)
	update_appearance()
	I.update_appearance()
