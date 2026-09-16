/datum/quirk/quantum_anxiety
	name = "Quantum Anxiety"
	desc = "Your subatomic particles are very self-conscious and have a tendency to lock up when under conscious observation. You cannot move or attack whilst being watched."
	value = -16
	icon = FA_ICON_LOCK
	mob_trait = TRAIT_UNOBSERVANT
	medical_record_text = "Light subtly bends around the patient, suggesting a high Weiss-Wiesemann/Rougon-Macquart coefficient."

/datum/quirk/quantum_anxiety/post_add()
	quirk_holder.AddComponentFrom(type, /datum/component/unobserved_actor, unobserved_flags = NO_OBSERVED_MOVEMENT | NO_OBSERVED_ATTACKS)

/datum/quirk/quantum_anxiety/remove()
	quirk_holder.RemoveComponentSource(type, /datum/component/unobserved_actor)
