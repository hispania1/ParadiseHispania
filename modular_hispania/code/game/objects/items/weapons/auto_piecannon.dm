/obj/item/gun/throw/piecannon/auto_piecannon
	name = "Autoloading pie cannon"
	desc = "The newest invention straight out of every clown's wet dream. Activate in hand to holster."
	flags = ABSTRACT | DROPDEL | NODROP
	fire_delay = 1 SECONDS


/obj/item/gun/throw/piecannon/auto_piecannon/process_fire(atom/target as mob|obj|turf, mob/living/user as mob|obj, message = 1, params, zone_override)
	playsound(user, 'sound/weapons/sonic_jackhammer.ogg', 50, 1)
	..()
	if(get_ammocount() == 0)
		qdel(src)
		return

/obj/item/gun/throw/piecannon/auto_piecannon/attack_self(mob/living/user)
    to_chat(usr, "<span class='notice'>You holster your pie cannon. Another time.</span>")
    qdel(src)
    return
