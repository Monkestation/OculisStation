// yoinked from monkestation's slimecore
/obj/effect/abstract/rainbow_overlay
	name = ""
	alpha = 150
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'modular_oculis/modules/slime_rancher/icons/rainbow_effect.dmi'
	icon_state = "diag"
	vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_LAYER
	blend_mode = BLEND_INSET_OVERLAY

/// Slaps scrolling rainbow stripes over the atom's sprite.
/atom/movable/proc/rainbow_effect()
	appearance_flags &= ~KEEP_APART
	appearance_flags |= KEEP_TOGETHER
	vis_contents += new /obj/effect/abstract/rainbow_overlay
