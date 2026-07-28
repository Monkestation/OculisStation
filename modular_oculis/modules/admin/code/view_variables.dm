#define VV_MOB_TOGGLE_ORBITING "toggle_orbiting"

/atom/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_MOB_TOGGLE_ORBITING, "Toggle Orbiting")

/atom/vv_do_topic(list/href_list)
	. = ..()

	if(!.)
		return

	if(href_list[VV_MOB_TOGGLE_ORBITING])
		if(!check_rights(R_ADMIN))
			return
		if(HAS_TRAIT_FROM(src, TRAIT_ORBITING_FORBIDDEN, VV_MOB_TOGGLE_ORBITING))
			REMOVE_TRAIT(src, TRAIT_ORBITING_FORBIDDEN, VV_MOB_TOGGLE_ORBITING)
			to_chat(usr, span_notice("Orbiting allowed for [src]."))
			log_admin("[key_name(usr)] has allowed [src] to be orbited.")
			message_admins(span_notice("[key_name(usr)] has allowed [src] to be orbited."))
		else
			ADD_TRAIT(src, TRAIT_ORBITING_FORBIDDEN, VV_MOB_TOGGLE_ORBITING)
			QDEL_NULL(orbiters)
			to_chat(usr, span_notice("Orbiting forbidden for [src]."))
			log_admin("[key_name(usr)] has forbidden [src] to be orbited.")
			message_admins(span_notice("[key_name(usr)] has forbidden [src] from being orbited."))


#undef VV_MOB_TOGGLE_ORBITING
