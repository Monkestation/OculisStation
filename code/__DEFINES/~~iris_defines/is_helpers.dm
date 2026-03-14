#define isnabber(A) (is_species(A, /datum/species/nabber))
#define isaquamorph(A) (is_species(A, /datum/species/aquamorph))
#define ispolysmorph(A) (is_species(A, /datum/species/polysmorph))

// keeping this in iris defines instead of oculis just for testmerge compatability
#define is_slime_core(A) (istype(A, /obj/item/organ/brain/slime))
