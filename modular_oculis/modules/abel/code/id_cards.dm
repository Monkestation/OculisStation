/obj/item/card/id/advanced/black/abel
	name = "\improper ABEL ID"
	desc = "It's an ABEL associate ID card."
	trim = /datum/id_trim/centcom/abel
	wildcard_slots = WILDCARD_LIMIT_ADMIN

/obj/item/card/id/advanced/black/abel/Initialize(mapload)
	. = ..()
	registered_account = new(player_account = FALSE)
	registered_account.account_id = ADMIN_ACCOUNT_ID // this is so bank_card_talk() can work.
	registered_account.account_job = SSjob.get_job_type(/datum/job/abel)
	registered_account.account_balance += 20000

/obj/item/card/id/advanced/black/abel/alt_click_can_use_id(mob/living/user)
	. = ..()
	if(!. || isnull(user.client?.holder)) // admins only as a safety so people don't steal all the dollars. spawn in a holochip if you want them to get some dosh
		registered_account.bank_card_talk(span_warning("Only authorized representatives of ABEL may use this card."), force = TRUE)
		return FALSE
	return TRUE

/obj/item/card/id/advanced/black/abel/equipped(mob/user, slot)
	. = ..()
	if((slot & ITEM_SLOT_ID) && !registered_name)
		registered_name = user.real_name
		update_icon()
		update_label()

/datum/id_trim/centcom/abel
	assignment = JOB_ABEL_ASSOCIATE
	trim_icon = 'modular_oculis/modules/abel/icons/id_trims.dmi'
	trim_state = "trim_headcrystallomancer"
	access = list(ACCESS_MAINT_TUNNELS)
	sechud_icon_state = SECHUD_CENTCOM
	department_color = COLOR_STRONG_VIOLET
	subdepartment_color = COLOR_SYNDIE_RED_HEAD
	honorifics = list("ABEL Associate")
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

/datum/job/abel
	title = "ABEL"

///////////////////////////////////////////
