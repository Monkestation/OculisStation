/obj/item/megaphone/microphone
	name = "microphone"
	desc = "Uhm. Uh. Oh- Hm. Err."
	icon = 'icons/obj/service/broadcast.dmi'
	icon_state = "microphone"
	inhand_icon_state = "microphone"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

/obj/item/megaphone/microphone/handle_speech(mob/living/user, list/speech_args)
	if(HAS_TRAIT(user, TRAIT_SIGN_LANG) || user.get_active_held_item() != src)
		return
	speech_args[SPEECH_SPANS] |= voicespan

/obj/item/megaphone/microphone/add_tts_filter(mob/living/carbon/user, list/message_args)
	if(HAS_TRAIT(user, TRAIT_SIGN_LANG) || user.get_active_held_item() != src)
		return
	if(obj_flags & EMAGGED)
		///somewhat compressed and ear-grating, crusty and noisy with a bit of echo.
		message_args[TREAT_TTS_FILTER_ARG] += "acrusher=samples=9:level_out=7,aecho=delays=100:decays=0.4,aemphasis=type=emi,crystalizer=i=6,acontrast=60,rubberband=pitch=0.9"
	else
		///A sharper and louder sound with a bit of echo
		message_args[TREAT_TTS_FILTER_ARG] += "acrusher=samples=2:level_out=6,aecho=delays=90:decays=0.3,aemphasis=type=cd,acontrast=30,crystalizer=i=5"
