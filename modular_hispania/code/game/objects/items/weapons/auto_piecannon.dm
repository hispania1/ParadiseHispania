/obj/item/gun/throw/piecannon/auto_piecannon
	name = "Autoloading pie cannon"
	desc = "The newest invention straight out of every clown's wet dream."
	flags = ABSTRACT | DROPDEL
	fire_delay = 1 SECONDS


/obj/item/gun/throw/piecannon/auto_piecannon/process_fire(atom/target as mob|obj|turf, mob/living/user as mob|obj, message = 1, params, zone_override)
	..()
	if(get_ammocount() == 0)
		qdel(src)
		return
