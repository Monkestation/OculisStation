// This is here to prevent a runtime related to having no laws.
/mob/living/silicon/pai_oculis/get_status_tab_items()
	. = list("") //we want to offset unique stuff from standard stuff
	SEND_SIGNAL(src, COMSIG_MOB_GET_STATUS_TAB_ITEMS, .)
	if(stat != CONSCIOUS)
		. += "Systems nonfunctional"
		return .
	. += "System integrity: [(health + 100) * 0.5]%"
	return .

/mob/living/silicon/pai_oculis/set_stat(new_stat)
	. = ..()
	update_stat()

/mob/living/silicon/pai_oculis/on_knockedout_trait_loss(datum/source)
	. = ..()
	set_stat(CONSCIOUS)
	update_stat()

/mob/living/silicon/pai_oculis/update_health_hud()
	if(!client || !hud_used)
		return

	var/atom/movable/screen/healths/healths = hud_used.screen_objects[HUD_MOB_HEALTH]
	if(!healths)
		return

	if(stat == DEAD)
		healths.icon_state = "health7"
		return

	if(health >= maxHealth)
		healths.icon_state = "health0"
	else if(health > maxHealth*0.6)
		healths.icon_state = "health2"
	else if(health > maxHealth*0.2)
		healths.icon_state = "health3"
	else if(health > -maxHealth*0.2)
		healths.icon_state = "health4"
	else if(health > -maxHealth*0.6)
		healths.icon_state = "health5"
	else
		healths.icon_state = "health6"

/mob/living/silicon/pai_oculis/updatehealth()
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		return
	set_health(maxHealth - get_brute_loss() - get_fire_loss())
	update_health_hud()
	update_stat()
	SEND_SIGNAL(src, COMSIG_LIVING_HEALTH_UPDATE)

/mob/living/silicon/pai_oculis/update_stat()
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		return
	if(stat != DEAD)
		if(health <= -maxHealth)
			death()
			return

/mob/living/silicon/pai_oculis/revive(full_heal_flags = NONE, excess_healing = 0, force_grab_ghost = FALSE)
	. = ..()
	if(!.)
		return

	src.set_stat(CONSCIOUS)
	if(full_heal_flags & HEAL_ADMIN)
		card.in_maintenance = FALSE
	update_stat()
	can_unfold = TRUE
	playsound(src, 'sound/effects/pai_boot.ogg', 50, FALSE)
	card.visible_message(span_alert("[src]'s systems come back online!"))
	return TRUE
