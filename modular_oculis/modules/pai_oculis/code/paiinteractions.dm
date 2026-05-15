// With an upgrade from robotics, pAIs will be allowed to pilot mechs. These next two proc calls allow that.
/mob/living/silicon/pai_oculis/can_perform_action(atom/target, action_bitflags)
	if((action_bitflags & NEED_HANDS) && isoldpAI(target))
		return TRUE
	return ..()

/obj/vehicle/sealed/mecha/mouse_drop_receive(atom/dropping, mob/living/M, params)
	if(isoldpAI(M) && M == dropping)
		var/mob/living/silicon/pai_oculis/pai = M
		if(!pai.can_pilot_mechs)
			to_chat(M, span_warning("The exosuit refuses to interface with you!"))
			return
		mob_try_enter(M)
		return
	return ..()

// Our pAIs can also inhabit bots (cleanbots, hygeinebots, floorbots, etc)
/mob/living/basic/bot/attackby(obj/item/attacking_item, mob/living/user, list/modifiers, list/attack_modifiers)
	if(istype(attacking_item, /obj/item/pai_card_oculis))
		insertpai(user, attacking_item)
		return
	return ..()
