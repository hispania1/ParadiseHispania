/obj/item/gun/special/auto_piecannon
	name = "Autoloading pie cannon"
	desc = "The newest invention straight out of every clown's wet dream."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "chemsprayer"		//placeholder
	fire_delay = 2 SECONDS
	var/ammo_type = list(/obj/item/ammo_casing/special/auto_piecannon_BPG)
	var/selfcharge = TRUE

/obj/item/ammo_casing/special/auto_piecannon_BPG
	name = "Bluespace Pie Generator"
	desc = "Bluespace thingamajig that generates banana cream pies out of thin air."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "handgun_ammo_battery" //placeholder
	fire_sound = 'sound/weapons/sonic_jackhammer.ogg'
	projectile_type = /obj/item/projectile/piecannon_shot
	var/e_cost = 250
