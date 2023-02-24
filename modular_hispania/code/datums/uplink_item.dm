/datum/uplink_item/dangerous/minigun
	name = "Natascha Minigun"
	desc = "She weighs one hundred fifty kilograms and fires two hundred credits, custom-tooled cartridges at ten thousand rounds per minute. It costs four hundred thousand credits to fire this weapon...for twelve seconds."
	reference = "NATASCHA"
	item = /obj/item/gun/projectile/automatic/fullauto/natascha
	cost = 85
	uplinktypes = list(UPLINK_TYPE_NUCLEAR, UPLINK_TYPE_SST)
	surplus = FALSE

/datum/uplink_item/ammo/minigun
	name = "Natascha Minigun - 7.62x51mm Canister Magazine"
	desc = "A 200-round canister full of bullets of 7.62x51mm ammunition for use in the delicate Natascha. By the time you need to use this, you'll already be cleaning on another station."
	reference = "NATASCHAAMMO"
	item = /obj/item/ammo_box/magazine/mm762x51
	cost = 30
	uplinktypes = list(UPLINK_TYPE_NUCLEAR, UPLINK_TYPE_SST)
	surplus = FALSE
	
/datum/uplink_item/jobspecific/telegunHispania
	name = "Telegun"
	desc = "An extremely high-tech energy gun that utilizes bluespace technology to teleport away living targets. Select the target beacon on the telegun itself; projectiles will send targets to the beacon locked onto."
	reference = "TGH"
	item = /obj/item/gun/energy/telegun
	cost = 12
	job = list("Scientist")
