GLOBAL_LIST_EMPTY(feedmespawn)

/datum/event/feedme
	announceWhen = 3
	endWhen = 11 MINUTES
	var/zona_spawn = null

/datum/event/feedme/announce()
	GLOB.minor_announcement.Announce("A new gourmet guest has arrived to the station bar. Its important to satisfy his culinary taste or there could be consequences for service workers")

/datum/event/feedme/start()
	INVOKE_ASYNC(src, PROC_REF(spawnear))

/datum/event/feedme/end()	//por si el evento llega a terminar por un admin
	for(var/mob/living/simple_animal/comensal/C in world)
		qdel(C)

/datum/event/feedme/proc/spawnear()
	var/list/possible_areas = list()
	for(var/area/crew_quarters/bar/A in world) 	//esto devuelve 1 area (bar)
		for(var/turf/simulated/floor/F in A)	//esto devuelve todos los pisos de esa area
			possible_areas.Add(F)
	zona_spawn = pick(possible_areas)

	new /obj/effect/portal/(zona_spawn)
	pick(new /mob/living/simple_animal/comensal/clown(zona_spawn),
	new /mob/living/simple_animal/comensal/carnivoro(zona_spawn),
	new /mob/living/simple_animal/comensal/mexicano(zona_spawn),
	new /mob/living/simple_animal/comensal/oriental(zona_spawn))

/mob/living/simple_animal/comensal
	name = "Catador"
	desc = "Parece hambriento.."
	icon = 'modular_hispania/icons/mob/comensales.dmi'
	speak_chance = 5
	icon_state = "model"
	icon_living = "model"
	icon_dead = "vacio"
	health = 60
	maxHealth = 60
	nutrition = -9000
	metabolism_efficiency = 100
	var/turns_since_scan = 0
	var/obj/movement_target
	var/alimentado = 0
	var/meta = 50
	var/paciencia = 10 MINUTES
	var/endtime = 0
	var/list/platos_favoritos = list()
	speak = list(
	"Muero de hambre!",
	"Escuche varias cosas de la cocina de este lugar.. Y no particularmente buenas",
	"Deme su mejor platillo",
	"Tengo tanto hambre que me comeria un planeta",
	"Cuanto tiempo hay que esperar para ser atendido?",
	)
	var/list/respuestas_positivas = list(
	)
	var/list/respuestas_negativas = list(
	"Esta comida es mala...",
	"No tienes una comida mejor?.",
	"Meh...wakale",
	"Preferiria otra comida..",
	"Esta comida no es de mi agrado"
	)

/mob/living/simple_animal/comensal/New()
	..()
	endtime = world.time + paciencia


/mob/living/simple_animal/comensal/proc/alimentar(I)
	for(var/plato in platos_favoritos)
		if(istype(I, plato))
			atom_say(pick(respuestas_positivas))
			alimentado += 10
			emote("flip")
			return
	if(en_lista_especial(I))
		atom_say(pick(respuestas_positivas))
		alimentado += 10
		emote("flip")
		return
	atom_say(pick(respuestas_negativas))
	alimentado += 2

/mob/living/simple_animal/comensal/proc/en_lista_especial(I) //definir en cada uno
	return FALSE

/mob/living/simple_animal/comensal/handle_automated_movement()
	. = ..()
	if(world.time > endtime)
		endtime = endtime * 2 //para q no entre denuevo
		var/stars = alimentado / 10
		GLOB.minor_announcement.Announce("The gourmet guest has left the station after waiting for a long time. He left a terrible review ([stars] star/s)")
		var/locat = src.loc
		new /obj/effect/portal/(locat)

		for(var/datum/money_account/account in GLOB.station_money_database.get_all_department_accounts())
			if(account.account_name == "Service Account")
				account.set_credits(-10000)
				spawn(5 SECONDS)
					GLOB.major_announcement.Announce("$10000 Credits have been removed from Service Account", new_sound = 'sound/arcade/lose.ogg', new_title = "Nanobank Service")
		sleep(1)
		qdel(src)
		return

	if(alimentado > meta)
		var/locat = src.loc
		new /obj/effect/portal/(locat)
		new /obj/item/storage/secure/briefcase/syndie/(locat)
		GLOB.minor_announcement.Announce("El Catador se ha ido totalmente satisfecho. Buen trabajo!")
		sleep(1)
		qdel(src)
		return

	if(resting)
		return

	if(++turns_since_scan > 5)
		turns_since_scan = 0

		if(movement_target && !(isturf(movement_target.loc) || ishuman(movement_target.loc)))
			movement_target = null
			stop_automated_movement = FALSE

		// No current target, or current target is out of range.
		var/list/snack_range = oview(src, 3)
		if(!movement_target || !(movement_target.loc in snack_range))
			movement_target = null
			stop_automated_movement = FALSE
			var/obj/item/possible_target = null
			for(var/I in snack_range)
				if(istype(I, /obj/item/reagent_containers/food/snacks)) // Noms
					possible_target = I
					break
			if(possible_target && (isturf(possible_target.loc) || ishuman(possible_target.loc))) // On the ground or in someone's hand.
				movement_target = possible_target
		if(movement_target)
			INVOKE_ASYNC(src, .proc/move_to_target)

/mob/living/simple_animal/comensal/proc/move_to_target()
	stop_automated_movement = TRUE
	step_to(src, movement_target, 1)
	sleep(3)
	step_to(src, movement_target, 1)
	sleep(3)
	step_to(src, movement_target, 1)

	if(movement_target) // Not redundant due to sleeps, Item can be gone in 6 deciseconds
		// Face towards the thing
		dir = get_dir(src, movement_target)

		if(!Adjacent(movement_target)) //can't reach food through windows.
			return

		if(isturf(movement_target.loc))
			movement_target.attack_animal(src) // Eat the thing

/mob/living/simple_animal/comensal/death(gibbed)
	// Only execute the below if we successfully died
	. = ..(gibbed)
	if(!.)
		return
	GLOB.minor_announcement.Announce("... The gourmet guest is dead. This damages NT reputation in the culinary galaxy newspaper. A bluespace projectile has been fired to the bar")

	var/list/possible_areas = list()
	for(var/area/crew_quarters/bar/A in world) 	//esto devuelve 1 area (bar)
		for(var/turf/simulated/floor/F in A)	//esto devuelve todos los pisos de esa area
			possible_areas.Add(F)
	var/zona_spawn = pick(possible_areas)
	spawn(15 SECONDS)
		explosion((zona_spawn), 2, 3, 4, 4)

/obj/item/reagent_containers/food/snacks/attack_animal(mob/M)
	if(isanimal(M))
		M.changeNext_move(CLICK_CD_MELEE)
		if(istype(M,/mob/living/simple_animal/comensal))
			var/mob/living/simple_animal/comensal/D = M
			playsound(loc,'sound/items/eatfood.ogg', rand(10,50), 1)
			D.adjustHealth(-100) //se cura
			D.taste(reagents)
			D.alimentar(src)
			qdel(src)

//**********
//
// COMENSALES
//
//************
/mob/living/simple_animal/comensal/clown
	icon_state = "clown"
	icon_living = "clown"
	icon_dead = "clown_dead"
	name = "Catador payaso"
	desc = "Parece hambriento de bananas o platos con bananas.."
	platos_favoritos = list(
		/obj/item/reagent_containers/food/snacks/bananabreadslice,
		/obj/item/reagent_containers/food/snacks/bananacakeslice,
		/obj/item/reagent_containers/food/snacks/friedbanana,
		/obj/item/reagent_containers/food/snacks/grown/banana,
		/obj/item/reagent_containers/food/snacks/grown/banana/bluespace,
		/obj/item/reagent_containers/food/snacks/sliceable/bananabread,
		/obj/item/reagent_containers/food/snacks/sliceable/bananacake,
		/obj/item/reagent_containers/food/snacks/banana_mugcake,
	)
	respuestas_positivas = list(
	"Honk!!! esta comida si me gusta! ",
	"HOOOONK !!! Que sabroso!! ",
	"honk honk, esto es digno de un banquete de la honk mother"
	)

/mob/living/simple_animal/comensal/mexicano
	name = "Catador mexicano"
	desc = "Parece hambriento de tacos o burritos!"
	icon_state = "mexicano"
	icon_living = "mexicano"
	icon_dead = "mexicano_dead"
	platos_favoritos = list(
		/obj/item/reagent_containers/food/snacks/taco,
		/obj/item/reagent_containers/food/snacks/burrito,
	)
	respuestas_positivas = list(
	"Orale manito esto si es comida!!",
	"Pero que rico chamaco, traeme mas de esto",
	"Hmmm...Delicioso!!!"
	)

/mob/living/simple_animal/comensal/carnivoro
	name = "Catador carnivoro"
	desc = "Parece hambriento de carne!!"
	icon_state = "carnivoro"
	icon_living = "carnivoro"
	icon_dead = "carnivoro_dead"
	platos_favoritos = list(
		/obj/item/reagent_containers/food/snacks/meatsteak,
		/obj/item/reagent_containers/food/snacks/meatpie,
		/obj/item/reagent_containers/food/snacks/meatbreadslice,
		/datum/recipe/oven/meatbread,
		/datum/recipe/oven/meatpizza,
		/obj/item/reagent_containers/food/snacks/grown/meatwheat,
		/obj/item/reagent_containers/food/snacks/stewedsoymeat,
		/obj/item/reagent_containers/food/snacks/xemeatpie,
		/obj/item/reagent_containers/food/snacks/meat/monkey,
		/obj/item/reagent_containers/food/snacks/meatpizzaslice,
	)
	respuestas_positivas = list(
	"Yeeha!! esta carne si que esta buena en proteinas",
	"De eso estoy hablando!!, traeme mas de esta carne chico!! ",
	"Carne bien jugosa como me gusta oh si",
	"HMM Carne!! amo la carne!!"
	)

/mob/living/simple_animal/comensal/carnivoro/en_lista_especial(I)
	var/obj/item/reagent_containers/food/snacks/A = I
	if((findtext(A.name,"meat")!= 0))
		return TRUE
	else
		return FALSE

/mob/living/simple_animal/comensal/oriental
	name = "Catador oriental"
	desc = "Parece hambriento de sushi o esas cosas.."
	icon_state = "oriental"
	icon_living = "oriental"
	icon_dead = "arepa_dead"
	platos_favoritos = list(/obj/item/reagent_containers/food/snacks/carpmeat,
	/obj/item/reagent_containers/food/snacks/salmonmeat,
	/obj/item/reagent_containers/food/snacks/salmonsteak,
	/obj/item/reagent_containers/food/snacks/catfishmeat,
	)
	respuestas_positivas = list(
	"HMMM LICO COMIDA MUY BUENA",
	"Dal buena calificacion, comida sablosa",
	"Estal soplendido ! comida incleible!",
	"Incleible platillo, sel muy bueno plepalando comida"
	)


/mob/living/simple_animal/comensal/oriental/en_lista_especial(I)
	var/obj/item/reagent_containers/food/snacks/A = I
	if((findtext(A.name,"sushi")!= 0)|| (findtext(A.name,"roll")!=0)|| (findtext(A.name,"shrimp")!=0))
		return TRUE
	else
		return FALSE

