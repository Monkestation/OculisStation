/obj/item/card/id/advanced/castor
	name = "\improper Castor ID"
	desc = "A Castor Station ID card. Has ALL the access of the both your station and Castor's."
	icon_state = "card_centcom"
	assigned_icon_state = "assigned_centcom"
	trim = /datum/id_trim/admin/castor
	wildcard_slots = WILDCARD_LIMIT_ADMIN

/obj/item/card/id/advanced/castor/Initialize(mapload)
	. = ..()
	registered_account = new(player_account = FALSE)
	registered_account.account_id = ADMIN_ACCOUNT_ID // this is so bank_card_talk() can work.
	registered_account.account_job = SSjob.get_job_type(/datum/job/castor)
	registered_account.account_balance += 999999 // MONEY! We add more money to the account every time we spawn because it's a debug item and infinite money whoopie

/obj/item/card/id/advanced/castor/alt_click_can_use_id(mob/living/user)
	. = ..()
	if(!. || isnull(user.client?.holder)) // admins only as a safety so people don't steal all the dollars. spawn in a holochip if you want them to get some dosh
		registered_account.bank_card_talk(span_warning("Only authorized representatives of Nanotrasen may use this card."), force = TRUE)
		return FALSE
	return TRUE

/datum/id_trim/admin/castor
	department_state = "departmenthead"
	sechud_icon_state = SECHUD_CENTCOM
	threat_modifier = -INFINITY
	big_pointer = TRUE
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_LAST_FULL | HONORIFIC_POSITION_NONE

/datum/job/castor
	title = "Castor Station Administration"

/////////////////////////////////////////////////////////

/datum/id_trim/admin/castor/sectorial_commander
	trim_state = "trim_captain"
	department_color = COLOR_CENTCOM_BLUE
	subdepartment_color = COLOR_CENTCOM_BLUE
	assignment = "Sectorial Commander"
	pointer_color = COLOR_CENTCOM_BLUE
	honorifics = list(span_blue("S.C."))

/obj/item/card/id/advanced/castor/sectorial_commander
	name = "\improper ID card"
	desc = "A Castor Station ID card. Has ALL the access of the both your station and Castor's."
	trim = /datum/id_trim/admin/castor/sectorial_commander
