#define MINIMUM_CLOTHING_STOCK 5

/obj/machinery/vending
	/// Additions to the `products` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/products_oculis
	/// Additions to the `product_categories` list of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/product_categories_oculis
	/// Additions to the `premium` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/premium_oculis
	/// Additions to the `contraband` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/contraband_oculis

/obj/machinery/vending/Initialize(mapload)
	if(products_oculis)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in products_oculis)
			products[item_to_add] = products_oculis[item_to_add]

	if(product_categories_oculis)
		for(var/category in product_categories_oculis)
			var/already_exists = FALSE
			for(var/existing_category in product_categories)
				if(existing_category["name"] == category["name"])
					existing_category["products"] += category["products"]
					already_exists = TRUE
					break

			if(!already_exists)
				product_categories += list(category)

	if(premium_oculis)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in premium_oculis)
			premium[item_to_add] = premium_oculis[item_to_add]

	if(contraband_oculis)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in contraband_oculis)
			contraband[item_to_add] = contraband_oculis[item_to_add]

	// Time to make clothes amounts consistent!
	for (var/obj/item/clothing/item in products)
		if(products[item] < MINIMUM_CLOTHING_STOCK && allow_increase(item))
			products[item] = MINIMUM_CLOTHING_STOCK

	for (var/category in product_categories)
		for(var/obj/item/clothing/item in category["products"])
			if(category["products"][item] < MINIMUM_CLOTHING_STOCK && allow_increase(item))
				category["products"][item] = MINIMUM_CLOTHING_STOCK

	for (var/obj/item/clothing/item in premium)
		if(premium[item] < MINIMUM_CLOTHING_STOCK && allow_increase(item))
			premium[item] = MINIMUM_CLOTHING_STOCK

	products_oculis?.Cut()
	product_categories_oculis?.Cut()
	premium_oculis?.Cut()
	contraband_oculis?.Cut()
	return ..()

#undef MINIMUM_CLOTHING_STOCK
