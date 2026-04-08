/datum/quirk/noannounce
	name = "Complex Name"
	desc = "Text-To-Speech systems have trouble with your name. You won't be announced by announcement systems."
	value = 0
	quirk_flags = QUIRK_HIDE_FROM_SCAN
	icon = FA_ICON_BULLHORN
	medical_record_text = "Patient has a name unpronounceable to machines."
	mob_trait = TRAIT_NO_ANNOUNCE

/proc/gen_garbage_name(min_length = 5, max_length = 16)
	var/charmap = list("w","µ","¬","î","V","°","0","K","ö","Â","F","å","÷","ú","*","¼","i","ÿ","f","Ý","~","ü","x","Û","4","B","œ","p","º","Q","ô","u","æ","Õ","¡","Ô","U","C","Å","ï","S","á","M","Ó","ƒ","û","T","É","Ê","Î","ý","¯","Ÿ","a","é","õ","ž","\\","-","&","5","«","¶","¾","ß","ì","6","¢","Ë","l","ã","ç","Ä","£","+","¤","y","à","d","Ù","m","z","I","t","j","®","½","ð","Š","Y","Ü","#","±","b","©","í","L","Ú","Æ","Ð","š","¿")

	var/len = rand(min_length, max_length)
	var/name = ""
	for(var/i in 1 to len)
		name += charmap[rand(1, length(charmap))]

	return name
