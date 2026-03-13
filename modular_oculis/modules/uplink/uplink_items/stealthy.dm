/datum/uplink_item/stealthy_weapons/contrabaton
	name = "Contractor Baton"
	desc = "A compact, specialised baton assigned to Syndicate contractors. Applies light electrical shocks to targets. \
	These shocks are capable of affecting the inner circuitry of most robots as well, applying a short stun. \
	Has the added benefit of affecting the vocal cords of your victim, causing them to slur as if inebriated."
	item = /obj/item/melee/baton/telescopic/contractor_baton
	cost = 10
	surplus = 25
	limited_stock = 1
	population_minimum = TRAITOR_POPULATION_LOWPOP
	purchasable_from = UPLINK_TRAITORS | UPLINK_SPY

/datum/uplink_item/stealthy_weapons/telebaton
	name = "Telescopic Baton"
	desc = "A compact baton used by multiple factions across the frontier. \
	While not as powerful as the Contractor Baton, it is still a very useful tool for subduing someone. \
	It also does not stop victims from speaking clearly, nor does it shock robots. \
	Unlike the silver or gold tipped telescopic batons found on head of personnel, this one does not penetrate armor very well."
	item = /obj/item/melee/baton/telescopic
	cost = 5
	surplus = 50
	limited_stock = 3
	purchasable_from = UPLINK_TRAITORS | UPLINK_SPY
