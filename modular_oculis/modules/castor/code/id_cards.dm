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

/obj/item/card/id/advanced/castor/equipped(mob/user, slot)
	. = ..()
	if((slot & ITEM_SLOT_ID) && !registered_name)
		registered_name = user.real_name
		update_icon()
		update_label()

/datum/id_trim/admin/castor
	department_state = "departmenthead"
	sechud_icon_state = SECHUD_CENTCOM
	threat_modifier = -INFINITY
	big_pointer = TRUE
	honorific_positions = HONORIFIC_POSITION_FIRST | HONORIFIC_POSITION_LAST | HONORIFIC_POSITION_FIRST_FULL | HONORIFIC_POSITION_NONE

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

/datum/id_trim/admin/castor/sectorial_personnel_administrator
	trim_state = "trim_headofpersonnel"
	department_color = COLOR_COMMAND_BLUE
	subdepartment_color = COLOR_SERVICE_LIME
	assignment = "Sectorial Personnel Administrator"
	pointer_color = COLOR_SERVICE_LIME
	honorifics = list("<font color='#04a804'>S.P.A.</font>")

/obj/item/card/id/advanced/castor/sectorial_personnel_administrator
	name = "\improper ID card"
	desc = "A Castor Station ID card. Has ALL the access of the both your station and Castor's."
	trim = /datum/id_trim/admin/castor/sectorial_personnel_administrator

/datum/id_trim/admin/castor/sectorial_security_administrator
	trim_state = "trim_securityofficer"
	department_color = COLOR_COMMAND_BLUE
	subdepartment_color = COLOR_SECURITY_RED
	assignment = "Sectorial Security Administrator"
	pointer_color = COLOR_SECURITY_RED
	honorifics = list("<font color='#db001d'>S.S.A.</font>")

/obj/item/card/id/advanced/castor/sectorial_security_administrator
	name = "\improper ID card"
	desc = "A Castor Station ID card. Has ALL the access of the both your station and Castor's."
	trim = /datum/id_trim/admin/castor/sectorial_security_administrator

/datum/id_trim/admin/castor/sectorial_research_administrator
	trim_state = "trim_scientist"
	department_color = COLOR_COMMAND_BLUE
	subdepartment_color = COLOR_SCIENCE_PINK
	assignment = "Sectorial Research Administrator"
	pointer_color = COLOR_SCIENCE_PINK
	honorifics = list("<font color='#8d04a8'>S.R.A.</font>")

/obj/item/card/id/advanced/castor/sectorial_research_administrator
	name = "\improper ID card"
	desc = "A Castor Station ID card. Has ALL the access of the both your station and Castor's."
	trim = /datum/id_trim/admin/castor/sectorial_research_administrator

/datum/id_trim/admin/castor/sectorial_medical_administrator
	trim_state = "trim_medicaldoctor"
	department_color = COLOR_COMMAND_BLUE
	subdepartment_color = COLOR_MEDICAL_BLUE
	assignment = "Sectorial Medical Administrator"
	pointer_color = COLOR_MEDICAL_BLUE
	honorifics = list("<font color='#06cfa4'>S.M.A.</font>")

/obj/item/card/id/advanced/castor/sectorial_medical_administrator
	name = "\improper ID card"
	desc = "A Castor Station ID card. Has ALL the access of the both your station and Castor's."
	trim = /datum/id_trim/admin/castor/sectorial_medical_administrator

/datum/id_trim/admin/castor/sectorial_logistics_administrator
	trim_state = "trim_cargotechnician"
	department_color = COLOR_COMMAND_BLUE
	subdepartment_color = COLOR_CARGO_BROWN
	assignment = "Sectorial Logistics Administrator"
	pointer_color = COLOR_CARGO_BROWN
	honorifics = list("<font color='#9e5a02'>S.L.A.</font>")

/obj/item/card/id/advanced/castor/sectorial_logistics_administrator
	name = "\improper ID card"
	desc = "A Castor Station ID card. Has ALL the access of the both your station and Castor's."
	trim = /datum/id_trim/admin/castor/sectorial_logistics_administrator

/datum/id_trim/admin/castor/sectorial_engineering_administrator
	trim_state = "trim_stationengineer"
	department_color = COLOR_COMMAND_BLUE
	subdepartment_color = COLOR_ENGINEERING_ORANGE
	assignment = "Sectorial Engineering Administrator"
	pointer_color = COLOR_ENGINEERING_ORANGE
	honorifics = list("<font color='#ff8800'>S.E.A.</font>")

/obj/item/card/id/advanced/castor/sectorial_engineering_administrator
	name = "\improper ID card"
	desc = "A Castor Station ID card. Has ALL the access of the both your station and Castor's."
	trim = /datum/id_trim/admin/castor/sectorial_engineering_administrator

/datum/id_trim/admin/castor/sectorial_internal_affairs_administrator
	trim_state = "trim_lawyer"
	department_color = COLOR_COMMAND_BLUE
	subdepartment_color = COLOR_CENTCOM_BLUE
	assignment = "Sectorial Internal Affairs Administrator"
	pointer_color = COLOR_CENTCOM_BLUE
	honorifics = list("<font color='#0038f1'>S.I.A.A.</font>")

/obj/item/card/id/advanced/castor/sectorial_internal_affairs_administrator
	name = "\improper ID card"
	desc = "A Castor Station ID card. Has ALL the access of the both your station and Castor's."
	trim = /datum/id_trim/admin/castor/sectorial_internal_affairs_administrator
