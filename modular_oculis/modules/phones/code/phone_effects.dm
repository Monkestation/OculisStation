/particles/phone_ringing
	icon = 'modular_oculis/modules/phones/icons/phone.dmi'
	icon_state = list("note" = 1)
	width = 32
	height = 48
	count = 5
	spawning = 0.5
	lifespan = 2 SECONDS
	fade = 1.5 SECONDS
	gravity = list(0, 0.1)
	position = generator(GEN_SPHERE, 0, 16, NORMAL_RAND)
	spin = generator(GEN_NUM, -1, 1, NORMAL_RAND)


/obj/item/modular_computer/proc/setup_particles()
	if(!particle_generator)
		particle_generator = new(src, /particles/phone_ringing, PARTICLE_ATTACH_MOB)
