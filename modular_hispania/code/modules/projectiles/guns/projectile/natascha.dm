/obj/item/gun/projectile/automatic/fullauto/natascha
	name = "\improper Natascha"
	desc = "A heavily barely holdeable 7.62 minigun. Sasha, don't be jealous"
	icon_state = "natashaloaded200"
	item_state = "natashaloadedworking"
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = 0
	fire_delay = 1.85
	origin_tech = "combat=6;engineering=4;syndicate=6"
	mag_type = /obj/item/ammo_box/magazine/mm762x51
	weapon_weight = WEAPON_HEAVY
	fire_sound = 'sound/weapons/gunshots/gunshot_mg.ogg'
	magin_sound = 'sound/weapons/gun_interactions/lmg_magin.ogg'
	magout_sound = 'sound/weapons/gun_interactions/lmg_magout.ogg'
	spread = 10
	force = 15
	throwforce = 25
	can_suppress = FALSE

/obj/item/gun/projectile/automatic/fullauto/natascha/update_icon_state()
	icon_state = "natasha[magazine ? "loaded" : "unloaded"][magazine ? CEILING(get_ammo(0)/50, 1)*25 : "empty"]"
	item_state = "natasha[magazine ? "loaded" : "unloaded"][get_ammo() ? "working" : "off"]"

/obj/item/projectile/bullet/natascha
	icon = 'modular_hispania/icons/obj/projectiles.dmi'
	icon_state = "natasha-bullet"
	damage = 45

/obj/item/ammo_box/magazine/mm762x51
	name = "bullets canister (7.62x51mm)"
	icon = 'modular_hispania/icons/obj/ammo.dmi'
	icon_state = "a762-51"
	origin_tech = "combat=2"
	ammo_type = /obj/item/ammo_casing/natascha
	caliber = "mm76251"
	max_ammo = 200

/obj/item/ammo_casing/natascha
	icon = 'modular_hispania/icons/obj/ammo.dmi'
	desc = "A 762x51mm bullet casing."
	caliber = "mm76251"
	icon_state = "natasha-casing"
	projectile_type = /obj/item/projectile/bullet/natascha
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_STRONG
	muzzle_flash_range = MUZZLE_FLASH_RANGE_STRONG
