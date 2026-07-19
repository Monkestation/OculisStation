/obj/item/storage/box/stickers
	custom_price = PAYCHECK_CREW * 2

/obj/item/sticker
	custom_price = PAYCHECK_CREW * 0.5

/obj/item/storage/box/stickers/hearts
	name = "heart sticker pack"
	desc = "A pack of heart-shaped stickers, popular among pediatric nurses across the galaxy."
	illustration = "heart"

/obj/item/storage/box/stickers/hearts/PopulateContents()
	for(var/i in 1 to 8)
		new /obj/item/sticker/heart(src)

/obj/item/storage/box/stickers/stars
	name = "star sticker pack"
	desc = "Sparkle on! Don't forget to be yourself!"
	illustration = "star"

/obj/item/storage/box/stickers/stars/PopulateContents()
	for(var/i in 1 to 8)
		new /obj/item/sticker/star(src)

/obj/item/storage/box/stickers/plush
	name = "plush sticker pack"
	desc = "Assorted stickers meant to resemble the huggable plushies of the station! These are far less huggable, unfortunately."
	illustration = "smile"

/obj/item/storage/box/stickers/plush/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/sticker/pbee(src)
		new /obj/item/sticker/psnake(src)
		new /obj/item/sticker/pliz(src)
		new /obj/item/sticker/robot(src)

/obj/item/storage/box/stickers/animal
	name = "animal sticker pack"
	illustration = "heart"

/obj/item/storage/box/stickers/animal/PopulateContents()
		new /obj/item/sticker/oculis/uwu(src)
		new /obj/item/sticker/oculis/cat(src)
		new /obj/item/sticker/oculis/paw(src)
		new /obj/item/sticker/oculis/dog(src)
		new /obj/item/sticker/oculis/bunny(src)
		new /obj/item/sticker/oculis/fox(src)
		new /obj/item/sticker/oculis/xenobio_slime(src)
		new /obj/item/sticker/oculis/kitsune(src)
		new /obj/item/sticker/oculis/spider(src)
		new /obj/item/sticker/oculis/spider_alt(src)

/obj/item/storage/box/stickers/assorted_stars
	name = "assorted star sticker pack"
	desc = "A pack of stickers containing an antiquated three-tier reward system. The boon of managers everywhere!"
	illustration = "star"

/obj/item/storage/box/stickers/assorted_stars/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/sticker/oculis/bronze_star(src)
		new /obj/item/sticker/oculis/silver_star(src)
		new /obj/item/sticker/star(src)

/obj/item/storage/box/stickers/pride
	name = "pride sticker pack"
	desc = "A pack of various striped, multicolored stickers. Every month is pride month if your heart is pure and just."
	illustration = "heart"

/obj/item/storage/box/stickers/pride/PopulateContents()
		new /obj/item/sticker/oculis/ace(src)
		new /obj/item/sticker/oculis/aro(src)
		new /obj/item/sticker/oculis/aroace(src)
		new /obj/item/sticker/oculis/bi(src)
		new /obj/item/sticker/oculis/gay(src)
		new /obj/item/sticker/oculis/genderfluid(src)
		new /obj/item/sticker/oculis/genderqueer(src)
		new /obj/item/sticker/oculis/intersex(src)
		new /obj/item/sticker/oculis/lesbian(src)
		new /obj/item/sticker/oculis/lgbtq(src)
		new /obj/item/sticker/oculis/nb(src)
		new /obj/item/sticker/oculis/pan(src)
		new /obj/item/sticker/oculis/trans(src)

/obj/item/storage/box/stickers/species
	name = "crew species sticker pack"
	desc = "A pack of cutesy stickers showing off various common NT-Employed species! <br>A request to not cause any HR-related issues is written in fine print at the bottom..."
	illustration = "smile"

/obj/item/storage/box/stickers/species/PopulateContents()
		new /obj/item/sticker/oculis/human(src)
		new /obj/item/sticker/oculis/felinid(src)
		new /obj/item/sticker/oculis/rogue(src)
		new /obj/item/sticker/oculis/slime(src)
		new /obj/item/sticker/oculis/lizard(src)
		new /obj/item/sticker/oculis/moth(src)
		new /obj/item/sticker/oculis/plasmaman(src)
		new /obj/item/sticker/oculis/podperson(src)
		new /obj/item/sticker/oculis/snail(src)
		new /obj/item/sticker/oculis/serpentid(src)
		new /obj/item/sticker/oculis/vox(src)
		new /obj/item/sticker/oculis/hemo(src)
		new /obj/item/sticker/oculis/synth(src)
		new /obj/item/sticker/oculis/holosynth(src)
		new /obj/item/sticker/oculis/pai(src)
