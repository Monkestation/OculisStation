/datum/surgery_operation/limb/amputate/mechanic/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You begin to sever [limb.owner]'s [limb.plaintext_zone]..."),
		span_notice("[surgeon] begins to sever [limb.owner]'s [limb.plaintext_zone]."),
		span_notice("[surgeon] begins to sever [limb.owner]'s [limb.plaintext_zone] with [tool]."),
	)
	display_pain(limb.owner, "You feel your connection to your [limb.plaintext_zone]'s shut down!", TRUE)

/datum/surgery_operation/limb/amputate/mechanic/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You successfully amputate [limb.owner]'s [limb.plaintext_zone]!"),
		span_notice("[surgeon] successfully amputates [limb.owner]'s [limb.plaintext_zone]!"),
		span_notice("[surgeon] finishes severing [limb.owner]'s [limb.plaintext_zone]."),
	)
	display_pain(limb.owner, "You can no longer feel your [limb.plaintext_zone]!", TRUE)
	if(HAS_MIND_TRAIT(surgeon, TRAIT_MORBID))
		surgeon.add_mood_event("morbid_dissection_success", /datum/mood_event/morbid_dissection_success)
	limb.drop_limb()

/datum/surgery_operation/limb/bioware/vein_threading/mechanic/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You start rerouting [limb.owner]'s hydraulics system."),
		span_notice("[surgeon] starts rerouting [limb.owner]'s hydraulics system."),
		span_notice("[surgeon] starts manipulating [limb.owner]'s hydraulics system."),
	)
	display_pain(limb.owner, "Your hydraulics system errors out!", TRUE)

/datum/surgery_operation/limb/bioware/vein_threading/mechanic/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..() // TODO SHROOPY
	display_results(
		surgeon,
		limb.owner,
		span_notice("You reroute [limb.owner]'s hydraulics system into a resistant mesh!"),
		span_notice("[surgeon] reroutes [limb.owner]'s hydraulics system into a resistant mesh!"),
		span_notice("[surgeon] finishes manipulating [limb.owner]'s hydraulics system."),
	)
	display_pain(limb.owner, "Your hydraulics reactivate, now reinforced!", TRUE)

/datum/surgery_operation/limb/bioware/muscled_veins/mechanic/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You start attaching redundancies to [limb.owner]'s hydraulics."),
		span_notice("[surgeon] starts attaching redundancies around [limb.owner]'s hydraulics."),
		span_notice("[surgeon] starts manipulating [limb.owner]'s hdraulics."),
	)
	display_pain(limb.owner, "Your hydraulics system errors out!", TRUE)

/datum/surgery_operation/limb/bioware/muscled_veins/mechanic/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..() // TODO SHROOPY
	display_results(
		surgeon,
		limb.owner,
		span_notice("You reshape [limb.owner]'s blood vessels, adding a muscled membrane!"),
		span_notice("[surgeon] reshapes [limb.owner]'s blood vessels, adding a muscled membrane!"),
		span_notice("[surgeon] finishes manipulating [limb.owner]'s blood vessels."),
	)
	display_pain(limb.owner, "You can feel your heartbeat's powerful pulses ripple through your body!")

/datum/surgery_operation/limb/bioware/nerve_splicing/mechanic/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You start splicing together [limb.owner]'s automatic systems."),
		span_notice("[surgeon] starts splicing together [limb.owner]'s automatic systems."),
		span_notice("[surgeon] starts manipulating [limb.owner]'s automatic systems."),
	)
	display_pain(limb.owner, "Your entire body goes numb!", TRUE)

/datum/surgery_operation/limb/bioware/nerve_splicing/mechanic/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..() // TODO SHROOPY
	display_results(
		surgeon,
		limb.owner,
		span_notice("You successfully splice [limb.owner]'s automatic systems!"),
		span_notice("[surgeon] successfully splices [limb.owner]'s automatic systems!"),
		span_notice("[surgeon] finishes manipulating [limb.owner]'s automatic systems."),
	)
	display_pain(limb.owner, "You regain feeling in your body; It feels like everything's happening around you in slow motion!", TRUE)

/datum/surgery_operation/limb/bioware/nerve_grounding/mechanic/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You start grounding [limb.owner]'s systems."),
		span_notice("[surgeon] starts grounding [limb.owner]'s systems."),
		span_notice("[surgeon] starts manipulating [limb.owner]'s systems."),
	)
	display_pain(limb.owner, "Your entire body goes numb!", TRUE)

/datum/surgery_operation/limb/bioware/nerve_grounding/mechanic/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..() // TODO SHROOPY
	display_results(
		surgeon,
		limb.owner,
		span_notice("You successfully ground [limb.owner]'s systems!"),
		span_notice("[surgeon] successfully grounds [limb.owner]'s systems!"),
		span_notice("[surgeon] finishes manipulating [limb.owner]'s systems."),
	)
	display_pain(limb.owner, "You regain feeling in your body! You feel energized!", TRUE)

/datum/surgery_operation/limb/bioware/ligament_hook/mechanic/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You start refactoring [limb.owner]'s joints into snaplocks."),
		span_notice("[surgeon] starts refactoring [limb.owner]'s joints into snaplocks."),
		span_notice("[surgeon] starts manipulating [limb.owner]'s joints."),
	)
	display_pain(limb.owner, "You suddenly lose connection to your limbs!", TRUE)

/datum/surgery_operation/limb/bioware/ligament_hook/mechanic/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..() // TODO SHROOPY
	display_results(
		surgeon,
		limb.owner,
		span_notice("You refactor [limb.owner]'s joints into snaplocks!"),
		span_notice("[surgeon] refactor [limb.owner]'s joints into snaplocks!"),
		span_notice("[surgeon] finishes manipulating [limb.owner]'s joints."),
	)
	display_pain(limb.owner, "Your limbs feel... strangely loose.", TRUE)

/datum/surgery_operation/limb/bioware/ligament_reinforcement/mechanic/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You start reinforcing [limb.owner]'s joints."),
		span_notice("[surgeon] starts reinforcing [limb.owner]'s joints."),
		span_notice("[surgeon] starts manipulating [limb.owner]'s joints."),
	)
	display_pain(limb.owner, "You lose connection to your limbs suddenly!", TRUE)

/datum/surgery_operation/limb/bioware/ligament_reinforcement/mechanic/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..() // TODO SHROOPY
	display_results(
		surgeon,
		limb.owner,
		span_notice("You reinforce [limb.owner]'s joints!"),
		span_notice("[surgeon] reinforces [limb.owner]'s joints!"),
		span_notice("[surgeon] finishes manipulating [limb.owner]'s joints."),
	)
	display_pain(limb.owner, "Your limbs feel more secure, but also more frail.", TRUE)

/datum/surgery_operation/limb/bioware/cortex_folding/mechanic/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You start totally reprogramming [limb.owner]'s neural network."),
		span_notice("[surgeon] starts totally reprogramming [limb.owner]'s neural network."),
		span_notice("[surgeon] starts modifying [limb.owner]'s brain."),
	)
	display_pain(limb.owner, "Your mind swims with unintellible concepts, it's nearly too much to handle!", TRUE)

/datum/surgery_operation/limb/bioware/cortex_folding/mechanic/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..() // TODO SHROOPY
	display_results(
		surgeon,
		limb.owner,
		span_notice("You totally reprogram [limb.owner]'s neural network!"),
		span_notice("[surgeon] totally reprograms [limb.owner]'s neural network!"),
		span_notice("[surgeon] finishes modifying [limb.owner]'s brain."),
	)
	display_pain(limb.owner, "Your mind feels stronger... and more flexible!", TRUE)

/datum/surgery_operation/limb/bioware/cortex_imprint/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You start updating [limb.owner]'s operating system to a newer version."),
		span_notice("[surgeon] starts updating [limb.owner]'s operating system to a newer version."),
		span_notice("[surgeon] starts modifying [limb.owner]'s brain."),
	)
	display_pain(limb.owner, "A loading screen with a spinning icon fills your entire vision...", TRUE)

/datum/surgery_operation/limb/bioware/cortex_imprint/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..() // TODO SHROOPY
	display_results(
		surgeon,
		limb.owner,
		span_notice("You update [limb.owner]'s operating system to a newer version!"),
		span_notice("[surgeon] updates [limb.owner]'s operating system to a newer version!"),
		span_notice("[surgeon] finishes modifying [limb.owner]'s brain."),
	)
	display_pain(limb.owner, "Your OS finishes updating! Your mind feels stronger... and more resilient!", TRUE)

/datum/surgery_operation/limb/lipoplasty/mechanic/on_preop(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You begin to engage [limb.owner]'s expulsion valve..."),
		span_notice("[surgeon] begins to engage [limb.owner]'s expulsion valve."),
		span_notice("[surgeon] begins to operate on [limb.owner]'s [limb.plaintext_zone] with [tool]."),
	)
	display_pain(limb.owner, "You feel a stabbing in your [limb.plaintext_zone]!", TRUE)

/datum/surgery_operation/limb/lipoplasty/mechanic/on_success(obj/item/bodypart/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("You successfully remove excess fat from [limb.owner]'s body!"),
		span_notice("[surgeon] successfully removes excess fat from [limb.owner]'s body!"),
		span_notice("[surgeon] finishes expulsing excess fat from [limb.owner]'s [limb.plaintext_zone]."),
	)
	var/removednutriment = limb.owner.nutrition
	limb.owner.overeatduration = 0 //patient is unfatted
	limb.owner.set_nutrition(NUTRITION_LEVEL_WELL_FED)
	removednutriment -= NUTRITION_LEVEL_WELL_FED //whatever was removed goes into the meat

	if(limb.owner.flags_1 & HOLOGRAM_1)
		return

	var/typeofmeat = null
	for(var/meat_path in limb.butcher_drops)
		if(ispath(meat_path, /obj/item/food/meat))
			typeofmeat = meat_path
			break

	if(!typeofmeat)
		return
