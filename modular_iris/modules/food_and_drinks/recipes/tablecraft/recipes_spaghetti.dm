/datum/crafting_recipe/food/pasta_triple
	name = "Triple pasta"
	reqs = list(
		/obj/item/food/spaghetti/pastatomato = 1,
		/obj/item/food/spaghetti/copypasta = 1
	)
	result = /obj/item/food/spaghetti/triple
	dish_category = DISH_NOODLES
	cuisine_category = CUISINE_ITALIAN

/datum/crafting_recipe/food/pasta_tower
	name = "Pasta tower"
	reqs = list(
		/obj/item/food/spaghetti/pastatomato = 1,
		/obj/item/food/spaghetti/triple = 1
	)
	result = /obj/item/food/spaghetti/tower
	dish_category = DISH_NOODLES
	cuisine_category = CUISINE_ITALIAN

/datum/crafting_recipe/food/pasta_spire
	name = "InSPIREd pasta"
	reqs = list(
		/obj/item/food/spaghetti/pastatomato = 1,
		/obj/item/food/spaghetti/tower = 1
	)
	result = /obj/item/food/spaghetti/spire
	dish_category = DISH_NOODLES
	cuisine_category = CUISINE_ITALIAN

/datum/crafting_recipe/food/pasta_babel
	name = "Babel pasta"
	reqs = list(
		/obj/item/food/spaghetti/pastatomato = 1,
		/obj/item/food/spaghetti/spire = 1
	)
	result = /obj/item/food/spaghetti/babel
	dish_category = DISH_NOODLES
	cuisine_category = CUISINE_ITALIAN

/datum/crafting_recipe/food/pasta_singularity
	name = "Singularity pasta"
	reqs = list(
		/obj/item/food/spaghetti/pastatomato = 10
	)
	result = /obj/item/food/spaghetti/singularity
	dish_category = DISH_NOODLES
	cuisine_category = CUISINE_ITALIAN

/datum/crafting_recipe/food/expand_pasta_singularity
	name = "Expand singularity pasta"
	reqs = list(
		/obj/item/food/spaghetti/pastatomato = 1,
		/obj/item/food/spaghetti/singularity = 1
	)
	result = /obj/item/food/spaghetti/singularity
	dish_category = DISH_NOODLES
	cuisine_category = CUISINE_ITALIAN
