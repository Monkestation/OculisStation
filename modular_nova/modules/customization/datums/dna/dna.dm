/datum/dna
	var/list/datum/mutant_bodypart/mutant_bodyparts = list()
	features = MANDATORY_FEATURE_LIST
	///Body markings of the DNA's owner. This is for storing their original state for re-creating the character. They'll get changed on species mutation
	var/list/list/body_markings = list()
	///Current body size, used for proper re-sizing and keeping track of that
	var/current_body_size = BODY_SIZE_NORMAL

/// Updates the mob's body size to prefs features
/datum/dna/proc/update_body_size(force_reapply = FALSE, animate_time = 0) // OCULIS EDIT ADDITION: add animate_time arg
	if(force_reapply)
		current_body_size = BODY_SIZE_NORMAL
	if(!holder || species.body_size_restricted || current_body_size == features["body_size"])
		return
	var/change_multiplier = features["body_size"] / current_body_size
	/* OCULIS EDIT - ORIGINAL:
	//We update the translation to make sure our character doesn't go out of the southern bounds of the tile
	var/translate = ((change_multiplier-1) * ICON_SIZE_ALL)/2
	var/matrix/new_transform = matrix(holder.transform)
	new_transform.Scale(change_multiplier)
	// Splits the updated translation into X and Y based on the user's rotation.
	var/translate_x = translate * ( new_transform.b / features["body_size"] )
	var/translate_y = translate * ( new_transform.e / features["body_size"] )
	new_transform.Translate(translate_x, translate_y)
	var/new_maptext_height = features["body_size"] * ICON_SIZE_Y
	if(animate_time > 0)
		animate(holder, transform = new_transform, maptext_height = new_maptext_height, time = animate_time)
	else
		holder.transform = new_transform
		holder.maptext_height = new_maptext_height // Adjust runechat height
	*/ // ORIGINAL END - OCULIS EDIT START:
	//We update the translation to make sure our character doesn't go out of the southern bounds of the tile
	var/translate = ((change_multiplier-1) * ICON_SIZE_ALL)/2
	var/matrix/new_transform = matrix(holder.transform)
	new_transform.Scale(change_multiplier)
	// Splits the updated translation into X and Y based on the user's rotation.
	var/translate_x = translate * ( new_transform.b / features["body_size"] )
	var/translate_y = translate * ( new_transform.e / features["body_size"] )
	new_transform.Translate(translate_x, translate_y)
	var/new_maptext_height = features["body_size"] * ICON_SIZE_Y
	if(animate_time > 0)
		animate(holder, transform = new_transform, maptext_height = new_maptext_height, time = animate_time)
	else
		holder.transform = new_transform
		holder.maptext_height = new_maptext_height // Adjust runechat height
	// OCULIS EDIT END
	current_body_size = features["body_size"]

/mob/living/carbon/proc/apply_customizable_dna_features_to_species()
	if(!has_dna())
		CRASH("[src] does not have DNA")
	dna.body_markings = dna.body_markings.Copy()
	var/list/bodyparts_to_add = LAZYCOPY(dna.mutant_bodyparts)
	for(var/key, part in bodyparts_to_add)
		var/datum/mutant_bodypart/mutant_part = part
		if(SSaccessories.sprite_accessories[key])
			var/datum/sprite_accessory/accessory = SSaccessories.sprite_accessories[key][mutant_part.name]
			if(!accessory?.factual)
				bodyparts_to_add -= key
				continue
	dna.mutant_bodyparts = bodyparts_to_add.Copy()
