/obj/item/organ/heart/hemophage/on_mob_insert(mob/living/carbon/tumorful, special, movement_flags)
	. = ..()
	RegisterSignal(tumorful, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(stab_bloodbag))

/obj/item/organ/heart/hemophage/on_mob_remove(mob/living/carbon/tumorless, special, movement_flags)
	. = ..()
	UnregisterSignal(tumorless, COMSIG_ATOM_ITEM_INTERACTION)

/obj/item/organ/heart/hemophage/proc/stab_bloodbag(mob/living/source, mob/living/user,  obj/item/used_item, list/modifiers)
	SIGNAL_HANDLER

	if(user != source)
		return NONE
	if(!istype(used_item, /obj/item/reagent_containers/blood))
		return NONE
	if(used_item.reagents?.total_volume <= 0)
		to_chat(user, span_warning("[src] is empty!"))
		return ITEM_INTERACT_BLOCKING

	user.visible_message(
		span_notice("[user] stabs [used_item] with [user.p_their()] teeth and drains its contents!"),
		span_notice("You stab [used_item] with your teeth and drain its contents!"),
		span_hear("You hear a stabbing sound! ...Followed by slurping?"),
		COMBAT_MESSAGE_RANGE,
	)
	INVOKE_ASYNC(src, PROC_REF(async_stab_bloodbag), user, used_item)
	return ITEM_INTERACT_BLOCKING

/obj/item/organ/heart/hemophage/proc/async_stab_bloodbag(mob/living/carbon/user, obj/item/reagent_containers/blood/bloodbag, time = 0.5 SECONDS)
	if(!do_after(user, time, bloodbag))
		return

	to_chat(user, span_notice("You swallow a gulp from [bloodbag]."))
	playsound(bloodbag, 'sound/items/drink.ogg', 50, TRUE) //slurp
	if(bloodbag.reagents.has_reagent(owner.dna.blood_type.reagent_type)) // do make sure it's actually filling before calling it such
		to_chat(user, span_notice("It's filling, though painfully bland."))
		owner.add_mood_event("drank_blood_bag", /datum/mood_event/disgust/hemophage_feed_bloodbag)
	bloodbag.reagents.trans_to(user, bloodbag.reagents.maximum_volume * 0.05, transferred_by = user, methods = INGEST)
	if(bloodbag.reagents.total_volume > 0)
		async_stab_bloodbag(user, bloodbag, 1 SECONDS)

/datum/mood_event/disgust/hemophage_feed_bloodbag
	description = "Blood bags always taste so stale. Uurrgh."
	mood_change = -2 //better than a monkey but worse than a living humonkey
	timeout = 5 MINUTES
