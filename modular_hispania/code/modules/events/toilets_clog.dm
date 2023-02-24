/datum/event/toilets_clog
	announceWhen = 3
	endWhen = 10

/datum/event/toilets_clog/announce()
	GLOB.minor_announcement.Announce("Los baños de la estacion estan teniendo problemas para evacuar sus desechos. Se recomienda una revision")

/datum/event/toilets_clog/start()
	var/cant = 0
	var/al_menos_uno = FALSE
	for(var/obj/structure/toilet/W in world)
		cant++
		if(W.anchored)
			if(prob(50))
				al_menos_uno = TRUE
				W.averiado = TRUE
				W.inundar()
				W.old_desc = W.desc
				W.desc= (W.old_desc + "<span class='warning'>Esta tapado! Hace falta una sopapa de plomero</span>")
	if((!al_menos_uno) && (cant>0))
		GLOB.minor_announcement.Announce("Revisando mejor.. los inodoros estan en muy buenas condiciones")
	if(cant==0)
		GLOB.minor_announcement.Announce("Vaya parece que enrealidad no tenemos ningun inodoro en la estacion. Mejor no saber donde van los desechos humanos")

/obj/structure/toilet/
	var/averiado = FALSE
	var/old_desc = ""

/obj/structure/toilet/proc/inundar()
	if(averiado)
		for(var/obj/machinery/door/airlock/D in range(3, src))//para que ensucie un poqito mas
			if((D.req_access_txt == "0"))
				D.open()
		var/obj/item/grenade/chem_grenade/cleaner/A = new /obj/item/grenade/chem_grenade/cleaner(src.loc)
		A.prime()
		spawn(4 SECONDS)
			inundar()

/obj/structure/toilet/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/clothing/head/plunger))
		if(!averiado)
			user.visible_message("<span class='notice'>[src] no necesita ser destapado</span>")
			return
		playsound(user,'modular_hispania/sound/effects/plunger.ogg',50)
		if(do_after(user, 75, target = src))
			user.visible_message("<span class='notice'>[user] ha destapado el [src] !</span>")
			averiado = FALSE
			desc = old_desc
	..()

/obj/structure/toilet/wrench_act(mob/living/user, obj/item/I)
	if(averiado)
		//user.drop_item()
		user.visible_message("<span class='notice'>Esto seria una mala idea! Necesito una sopapa para destaparlo</span>")
		return
	else
		..()
