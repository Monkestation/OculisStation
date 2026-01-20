/datum/hud/nymph
	ui_style = 'icons/hud/screen_gen.dmi'

/datum/hud/nymph/New(mob/living/basic/nymph/owner)
	. = ..()
	healths = new /atom/movable/screen/healths(null, src)
	infodisplay += healths
