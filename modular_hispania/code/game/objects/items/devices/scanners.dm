/obj/item/healthanalyzer
	pickup_sound =  'modular_hispania/sound/medbay/device_pickup.ogg'
	drop_sound = 'modular_hispania/sound/medbay/device_drop.ogg'

/obj/item/reagent_scanner
	pickup_sound =  'modular_hispania/sound/medbay/device_pickup.ogg'
	drop_sound = 'modular_hispania/sound/medbay/device_drop.ogg'

/obj/item/healthanalyzer/attack(mob/living/M, mob/living/user)
	..()
	playsound(user.loc, 'modular_hispania/sound/medbay/healthscanner_used.ogg', 25)
