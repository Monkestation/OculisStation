/datum/design/board/contactscanner
	name = "Formic Scanner Board"
	desc = "The circuit board for a formic scanner array."
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/contactscanner
	category = list(
		RND_CATEGORY_MACHINE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/contactplatform
	name = "Contact Platform Board"
	desc = "The circuit board for a contact platform."
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/contactplatform
	category = list(
		RND_CATEGORY_MACHINE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/contactanalyzer
	name = "Formic Analyzer"
	desc = "A device for scanning and communicating with Anomalous Resonance Forms."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT*2, /datum/material/silver =SMALL_MATERIAL_AMOUNT*2, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/contactanalyzer
	category = list(
		RND_CATEGORY_TOOLS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/contactresonator
	name = "Contact Resonator"
	desc = "A device for reading frequencies within Anomalous Resonance Forms for hidden data."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT*2, /datum/material/gold =SMALL_MATERIAL_AMOUNT*2, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/contactresonator
	category = list(
		RND_CATEGORY_TOOLS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
