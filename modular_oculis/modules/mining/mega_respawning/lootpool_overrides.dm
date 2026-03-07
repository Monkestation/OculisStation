/mob/living/basic/boss/blood_drunk_miner/Initialize(mapload)
	regular_loot += /obj/item/book/granter/crafting_recipe/dusting/summoning_flute/blood_drunk_miner
	. = ..()

/mob/living/simple_animal/hostile/megafauna/hierophant/Initialize(mapload)
	loot += /obj/item/book/granter/crafting_recipe/dusting/summoning_flute/hierophant
	. = ..()

/obj/structure/closet/crate/necropolis/dragon/PopulateContents()
	..()
	new /obj/item/book/granter/crafting_recipe/dusting/summoning_flute/drake(src)

/obj/structure/closet/crate/necropolis/gladiator/PopulateContents()
	..()
	new /obj/item/book/granter/crafting_recipe/dusting/summoning_flute/the_marked_one(src)

/obj/structure/closet/crate/necropolis/colossus/PopulateContents()
	..()
	new /obj/item/book/granter/crafting_recipe/dusting/summoning_flute/colossus(src)

/obj/structure/closet/crate/necropolis/bubblegum/PopulateContents()
	..()
	new /obj/item/book/granter/crafting_recipe/dusting/summoning_flute/bubblegum(src)

// Icebox megafauna below
/mob/living/simple_animal/hostile/megafauna/clockwork_defender/Initialize(mapload)
	loot += /obj/item/book/granter/crafting_recipe/dusting/summoning_flute/clockwork_defender
	. = ..()

/mob/living/basic/boss/thing/Initialize(mapload)
	regular_loot += /obj/item/book/granter/crafting_recipe/dusting/summoning_flute/the_thing
	. = ..()

/mob/living/simple_animal/hostile/megafauna/wendigo/Initialize(mapload)
	guaranteed_butcher_results += /obj/item/book/granter/crafting_recipe/dusting/summoning_flute/wendigo
	. = ..()

/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner/Initialize(mapload)
	loot += /obj/item/book/granter/crafting_recipe/dusting/summoning_flute/demonic_frost_miner
	. = ..()
