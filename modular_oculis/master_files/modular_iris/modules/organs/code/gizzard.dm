
/obj/item/organ/wings/functional/gizzard
	food_reagents = /obj/item/organ::food_reagents //You only get nutriment from eating roundstart wings, as opposed to growing REAL wings.

//OVERRIDE - You do not get flight potion from grinding roundstart wings.
/obj/item/organ/wings/functional/gizzard/grind_results()
	return null
