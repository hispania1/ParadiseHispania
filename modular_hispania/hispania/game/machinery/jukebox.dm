/obj/machinery/hispaniabox
	name = "Hispaniabox"
	desc = "Music for the bar."
	icon = 'modular_hispania/icons/obj/hispaniabox.dmi'
	icon_state = "jukebox"
	anchored = TRUE
	atom_say_verb = "states"
	density = TRUE
	light_color = "#FFD100"
	max_integrity = 75
	interact_offline = 1
	integrity_failure = 60
	var/light_range_on = 3
	var/light_power_on = 1
	var/active = FALSE
	var/list/rangers = list()
	var/stop = 0
	var/list/spotlights = list()
	var/list/sparkles = list()
	var/list/songs = list(
		"Play/Pause", // POR NADA DEL MUNDO QUITAR A ESTE
		"Lo-Fi Chill � Fly me to the moon - Frank Sinatra"    = new /datum/track('modular_hispania/sound/hispaniabox/Fly_Me_To_The_Moon.ogg',	1340,	5,	"moon", "Fly me to the moon - Frank Sinatra"),
		"Lo-Fi Chill � Interstellar Main Theme - Hans Zimmer"  = new /datum/track('modular_hispania/sound/music/title11.ogg',		2540,	5,	"zimmer", "Interstellar Main Theme - Hans Zimmer"),
		"Jazz � Porco Rosso Main Theme"  					   = new /datum/track('modular_hispania/sound/hispaniabox/PorcoRosso.ogg',		5000,	5,	"porco", "Porco Rosso Main Theme"),
		"Eurodance Trance � Better Off Alone - SALEM Remix"    = new /datum/track('modular_hispania/sound/music/title12.ogg',					1750,	5,	"euro", "Better Off Alone - SALEM Remix"),
		"Cyberpunk � Dance With The Dead - Andromeda"  		   = new /datum/track('modular_hispania/sound/music/title1.ogg',					3010,	5,	"withdead", "Dance With The Dead - Andromeda"),
		"Pop-Rock � Space Oddity - David Bowie"  			   = new /datum/track('modular_hispania/sound/music/title4.ogg',					3300,	5,	"oddity", "Space Oddity - David Bowie"  ),
		"Pop � Space Jam"  									   = new /datum/track('modular_hispania/sound/music/title3.ogg',					1930,	5,	"jam", "Space Jam"),
		"Pop � Europa VII - La Oreja de Van Gogh"  			   = new /datum/track('modular_hispania/sound/music/title10.ogg',					2390,	5,	"europa", "Europa VII - La Oreja de Van Gogh"),
		"Pop � Los Marcianos Llegaron Ya - Tito Rodriguez"     = new /datum/track('modular_hispania/sound/music/title5.ogg',					1740,	5,	"marcianos", "Los Marcianos Llegaron Ya - Tito Rodriguez"),
		"Pop � Never Gonna Give You Up - Rick Astley"		   = new /datum/track('modular_hispania/sound/hispaniabox/Give_You_Up.ogg',		2120,	5,	"giveyouup", "Never Gonna Give You Up - Rick Astley"),
		"Pop � Cacho Casta�a - Si te agarro con otro te mato"  = new /datum/track('modular_hispania/sound/hispaniabox/cacho.ogg',		2000,	5,	"cacho", "Cacho Casta�a - Si te agarro con otro te mato"),
		"Pop � Children Of The Sun - Billy Thorpe"			   = new /datum/track('modular_hispania/sound/music/title8.ogg',		3470,	5,	"sun", "Children Of The Sun - Billy Thorpe"),
		"Pop � Star Wars Cantina - Meco"  					   = new /datum/track('modular_hispania/sound/hispaniabox/star_wars_cantina.ogg',			2532,	5,	"cantina", "Star Wars Cantina - Meco"),
		"Electro � Spoiler - DJ Hyper"						   = new /datum/track('modular_hispania/sound/music/title9.ogg',		3500,	5,	"hyper", "Spoiler - DJ Hyper"),
		"Electro � Cheeki Breeki - Anthem"					   = new /datum/track('modular_hispania/sound/hispaniabox/russian.ogg',	1930,	5,	"cheeki", "Cheeki Breeki - Anthem"),
		"Electro � Daft Punk - Veridis Quo"			   		   = new /datum/track('modular_hispania/sound/hispaniabox/daft.ogg',		5570,	5,	"daft", "Daft Punk - Veridis Quo"),
		"Electro � Paradise Theme - Nanostrasen"			   = new /datum/track('modular_hispania/sound/music/title2.ogg',		2080,	5,	"paradise", "Paradise Theme - Nanostrasen"),
		"Ambiente � Thunderdome Song - Nanostrasen"			   = new /datum/track('modular_hispania/sound/music/thunderdome.ogg',	2020,	5,	"thunderdome", "Thunderdome Song - Nanostrasen"),
		"Ambiente � Tension Music - Nanostrasen"			   = new /datum/track('modular_hispania/sound/music/traitor.ogg',		3500,	5,	"tension", "Tension Music - Nanostrasen"),
		"Ambiente � Space Ambient Song - Nanostrasen" 		   = new /datum/track('modular_hispania/sound/music/space.ogg',		2130,	5,	"space", "Space Ambient Song - Nanostrasen"),
		"Cumbia � La Vida Es Un Carnaval - Celia Cruz"		   = new /datum/track('modular_hispania/sound/hispaniabox/cumbion.ogg',	2770,	5,	"carnaval", "La Vida Es Un Carnaval - Celia Cruz"),
		"Rock � Yes - Roundabout"							   = new /datum/track('modular_hispania/sound/hispaniabox/yes.ogg',	2600,	5,	"roundabout", "Yes - Roundabout"),
		"Rock Latino � Noviembre Sin Ti - Reik"				   = new /datum/track('modular_hispania/sound/hispaniabox/reik.ogg',	1990,	5,	"noviembre", "Noviembre Sin Ti - Reik"),
		"For Science � Still Alive - GLaDOS"				   = new /datum/track('modular_hispania/sound/music/title7.ogg',		1840,	5,	"GLaDOS", "Still Alive - GLaDOS"),
		)
	var/datum/track/selection
	var/track = ""
	var/musicrange = 11
	var/MusicChannel = CHANNEL_JUKEBOX

/datum/track
	song_name = "???"
	song_path = null
	song_length = 0
	song_beat = 0
	var/song_icon

/datum/track/New(path, length, beat, icon, name)
	song_path = path
	song_length = length
	song_beat = beat
	song_icon = icon
	song_name = name

/obj/machinery/hispaniabox/vv_get_dropdown()
	. = ..()
	. += "--- "
	. += "HISPANIA "
	. += "--- "
	.["Emaggear"] = "?_src_=vars;emag=[UID()]"
	.["Insertar Nueva Cancion"] = "?_src_=vars;nuevacancion=[UID()]"
	.["Borrar Cancion"] = "?_src_=vars;borrarcancion=[UID()]"
	.["Borrar TODAS Las Canciones"] = "?_src_=vars;borrartodascanciones=[UID()]"

/obj/machinery/hispaniabox/power_change()
	..()
	light()

/obj/machinery/hispaniabox/welder_act(mob/user, obj/item/I)
	if(user.a_intent == INTENT_HARM) // Harm intent
		return FALSE
	else // Any other intents
		if(obj_integrity >= max_integrity)
			to_chat(user, "<span class='notice'>[src] does not need repairs.</span>")
			return TRUE
		if(!I.tool_use_check(user, 0))
			return TRUE
		WELDER_ATTEMPT_REPAIR_MESSAGE
		if(I.use_tool(src, user, 40, volume = I.tool_volume))
			WELDER_REPAIR_SUCCESS_MESSAGE
			obj_integrity = clamp(obj_integrity + 20, 0, max_integrity)
			if(obj_integrity > integrity_failure)
				stat &= ~BROKEN
			update_icon()
		return TRUE

/obj/machinery/hispaniabox/emp_act()
	. = ..()
	dance_over()
	stop = 0
	active = FALSE
	selection = null
	STOP_PROCESSING(SSfastprocess, src)
	playsound(src.loc, 'sound/effects/sparks4.ogg', 50, TRUE)
	do_sparks(3, 1, src)
	obj_integrity -= max_integrity - 1 // OUCH da�o a la jukebox, 2 EMP TUMBAN LA JUKEBOX
	update_icon()

/obj/machinery/hispaniabox/Destroy()
	dance_over()
	selection = null
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

/obj/machinery/hispaniabox/obj_break(damage_flag)
	..()
	dance_over()
	selection = null
	STOP_PROCESSING(SSfastprocess, src)
	update_icon()

/obj/machinery/hispaniabox/attackby(obj/item/O, mob/user, params)
	if(!active)
		if(iswrench(O))
			if(isinspace())
				to_chat(user,"<span class='notice'>You can't secure the [src] in the space...</span>")
				return
			if(!anchored)
				to_chat(user,"<span class='notice'>You secure [src] to the floor.</span>")
				anchored = TRUE
				light()
			else if(anchored)
				to_chat(user,"<span class='notice'>You unsecure and disconnect [src].</span>")
				anchored = FALSE
				set_light(0)
			playsound(src, O.usesound, 50, 1)
			return
	if(istype(O,/obj/item/vinyldiscojukebox))
		var/obj/item/vinyldiscojukebox/I = O
		if(!I.used) return // Si no esta listo, pues no amigo.
		var/datum/track/nueva_cancion = I.track

		songs[nueva_cancion.song_name] = nueva_cancion
		qdel(I)

		user.visible_message("<span class='warning'>[user] inserts a vinyl in the [src]!</span>", "<span class='notice'>You insert the vinyl in the [src].</span>")
		playsound(src,'modular_hispania/sound/machines/dvd_working.ogg',50,1)
		message_admins("[key_name(usr)] ha agregado una nueva cancion: \"[nueva_cancion.song_name]\" a la hispaniabox del tile ([x], [y], [z]).")
	return ..()

/obj/machinery/hispaniabox/emag_act(mob/user)
	if(!emagged)
		emagged = TRUE
		if(user)
			user.visible_message("<span class='warning'>Sparks fly out of the [src]!</span>", "<span class='notice'>You emag the [src], new features unlocked.</span>")
		playsound(src.loc, 'sound/effects/sparks4.ogg', 50, TRUE)
		do_sparks(3, 1, src)
		songs["Final_Gear.EXECUTE"] = new /datum/track('modular_hispania/sound/hispaniabox/emmaged/RapdelasOpciones.ogg',	1570,	5,	"gear", "CHOCUJUEGO � El rap de las opciones")
		songs["Last Order Of Pizza"] = new /datum/track('modular_hispania/sound/hispaniabox/emmaged/pizza.ogg',	1270,	5,	"pizza", "Spider-Man 2 � The Game Pizza Theme")
		songs["Nothing Honk Matters"] = new /datum/track('modular_hispania/sound/music/clown.ogg',	1470,	5,	"clown", "SS13 � Clown Main Theme")
		return

/obj/machinery/hispaniabox/examine(mob/living/M)
	. = ..()
	if (active && selection)
		var/image = image('modular_hispania/icons/obj/hispaniabox.dmi', icon_state = selection.song_icon)
		. += "<span class='notice'>[bicon(src)] Estas escuchando \"[selection.song_name]\" [bicon(image)]</span>"

/obj/machinery/hispaniabox/attack_hand(mob/user)
	if(..())
		return

	if(stat & BROKEN)
		return

	if(!anchored)
		to_chat(user,"<span class='warning'>This device must be anchored by a wrench!</span>")
		return

	if(!Adjacent(user) && !isAI(user))
		return

	add_fingerprint(user)

	var/list/skins = list()
	for(var/I in songs)
		if (I == "Play/Pause")
			var/image/image = image('modular_hispania/icons/obj/hispaniabox.dmi', icon_state = "Play/Pause")
			skins[I] = image
		else
			var/datum/track/S = songs[I] // Get the accociated list
			var/icon = S.song_icon
			var/image/image = image('modular_hispania/icons/obj/hispaniabox.dmi', icon_state = icon)
			skins[I] = image

	var/choice = show_radial_menu(user, src, skins, null, 40, CALLBACK(src, .proc/radial_check, user), TRUE)
	if(!choice || !radial_check(user))
		return
	if (choice == "Play/Pause")
		if(isnull(selection))
			return
		if(QDELETED(src))
			return
		if(!active)
			if(stop > world.time)
				to_chat(usr, "<span class='warning'>[bicon(src)] The device is still resetting from the last activation, it will be ready again in [DisplayTimeText(stop-world.time)].</span>")
				playsound(src, 'sound/misc/compiler-failure.ogg', 50, 1)
				return
			active = TRUE
			update_icon()
			dance_setup()
			playsound(src,'modular_hispania/sound/machines/dvd_working.ogg',50,1)

			var/sound/song_played = sound(selection["song_path"])
			var/list/players_copy = GLOB.player_list.Copy()

			for(var/mob/M in range(musicrange,src))
				if(!M.client || !(M.client.prefs.sound & SOUND_INSTRUMENTS))
					continue
				rangers[M] = TRUE
				M.playsound_local(src, 100, channel = MusicChannel, S = song_played)
				var/dis = get_dist(src, M)
				if(dis >= musicrange-1)
					M.set_sound_channel_volume(MusicChannel, 5 * M.client.prefs.get_channel_volume(CHANNEL_JUKEBOX))
				else if(dis >= musicrange-2)
					M.set_sound_channel_volume(MusicChannel, 15 * M.client.prefs.get_channel_volume(CHANNEL_JUKEBOX))
				else if(dis >= musicrange-4)
					M.set_sound_channel_volume(MusicChannel, 40 * M.client.prefs.get_channel_volume(CHANNEL_JUKEBOX))
				else
					M.set_sound_channel_volume(MusicChannel, 100 * M.client.prefs.get_channel_volume(CHANNEL_JUKEBOX))
			for(var/mob/M in players_copy)
				if(!M.client || !(M.client.prefs.sound & SOUND_INSTRUMENTS) || (M in rangers))
					continue
				rangers[M] = TRUE
				M.playsound_local(src, 100, channel = MusicChannel, S = song_played)
				M.set_sound_channel_volume(MusicChannel, 0)
			START_PROCESSING(SSobj, src)
			return
		else if(active)
			stop = 0
			return
		else
			to_chat(usr, "<span class='warning'>[bicon(src)] You cannot stop the song until the current one is over.</span>")
			return
	var/datum/track/S = songs[choice]
	if(!active)
		selection = S
		playsound(src,'sound/misc/ping.ogg',50,1)
	else
		to_chat(usr, "<span class='warning'>[bicon(src)] You cannot change the song until the current one is over.</span>")

/obj/machinery/hispaniabox/proc/radial_check(mob/living/carbon/human/H)
	if(!src || !Adjacent(H) || H.incapacitated())
		return FALSE
	return TRUE

/obj/machinery/hispaniabox/proc/light()
	if(!(stat & BROKEN))
		return set_light(light_range_on, light_power_on)
	else
		return set_light(0)

/obj/machinery/hispaniabox/proc/dance_setup()
	stop = world.time + selection["song_length"]

/obj/machinery/hispaniabox/proc/dance_over()
	QDEL_LIST_CONTENTS(spotlights)
	QDEL_LIST_CONTENTS(sparkles)
	for(var/mob/living/L in rangers)
		if(!L || !L.client)
			continue
		L.stop_sound_channel(MusicChannel)
	rangers = list()

/obj/machinery/hispaniabox/process()
	if(world.time < stop && active)
		//var/sound/song_played = sound(selection["song_path"])

		for(var/mob/M in range(musicrange,src))
			if(!(M in rangers))
				if(!M.client || !(M.client.prefs.sound & SOUND_INSTRUMENTS))
					continue
				rangers[M] = TRUE
				M.set_sound_channel_volume(MusicChannel, M.client.prefs.get_channel_volume(CHANNEL_JUKEBOX))
		for(var/mob/L in rangers)
			var/dis = get_dist(src, L)
			if(dis > musicrange)
				rangers -= L
				if(!L || !L.client)
					continue
				L.set_sound_channel_volume(MusicChannel, 0)
			else if(dis >= musicrange-1)
				L.set_sound_channel_volume(MusicChannel, 5 * L.client.prefs.get_channel_volume(CHANNEL_JUKEBOX))
			else if(dis >= musicrange-2)
				L.set_sound_channel_volume(MusicChannel, 15 * L.client.prefs.get_channel_volume(CHANNEL_JUKEBOX))
			else if(dis >= musicrange-4)
				L.set_sound_channel_volume(MusicChannel, 40 * L.client.prefs.get_channel_volume(CHANNEL_JUKEBOX))
			else
				L.set_sound_channel_volume(MusicChannel, 100 *L.client.prefs.get_channel_volume(CHANNEL_JUKEBOX))
	else if(active)
		active = FALSE
		STOP_PROCESSING(SSfastprocess, src)
		dance_over()
		playsound(src,'sound/machines/terminal_off.ogg',50,1)
		icon_state = "[initial(icon_state)]"
		stop = world.time + 10

/obj/machinery/hispaniabox/update_icon_state()
	if(stat & BROKEN)
		icon_state = "[initial(icon_state)]-broken"
	else if (active)
		icon_state = "[initial(icon_state)]-running"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/vinyldiscojukebox
	name = "vinyl"
	desc = "A bluespace vinyl capable of reaching music from other dimension." // Me da risa, lo siento
	icon = 'modular_hispania/icons/obj/hispaniabox.dmi'
	icon_state = "creation"
	lefthand_file = 'modular_hispania/icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'modular_hispania/icons/mob/inhands/items_righthand.dmi'
	item_state = "vinyl"
	var/datum/track
	var/used = FALSE

/obj/item/vinyldiscojukebox/proc/radial_check(mob/living/carbon/human/H)
	if(!src || !Adjacent(H) || H.incapacitated())
		return FALSE
	return TRUE

/obj/item/vinyldiscojukebox/attack_self(mob/user)
	if(used) return // No hay rembolsos.
	add_fingerprint(user) // TODOS SABEN QUIEN ERES
	var/rutacancion = input(usr, "Escoje tu archivo de musica para la nueva cancion","Nueva Cancion Hispaniabox") as null|file
	if(!rutacancion) return
	rutacancion = file(rutacancion)

	var/tiempo = input(usr, "Lapso de tiempo de la cancion en decisegundos, ejemplo: Cancion de 4:30 minutos pasaria a \"4300\"", "Tiempo de la Cancion") as num|null
	if(!tiempo || !Adjacent(user, src)) return

	var/genero = input(usr, "Escribe el genero muscial de la cancion", "Genero Musical") as text|null
	if(!genero || !Adjacent(user, src)) return

	var/nombre = input(usr, "Escribe el nombre de la cancion, y no, no te dare vista previa", "Nombre de la Cancion") as text|null
	if(!nombre || !Adjacent(user, src)) return

	var/list/skins = list()
	for(var/I in list("hispania","experimental","weird","admin","event","smuggy","trash","face?","game","calm","classical","smuggy","rock","actualrock"))
		var/image/image = image('modular_hispania/icons/obj/hispaniabox.dmi', icon_state = I)
		skins[I] = image

	var/icono = show_radial_menu(user, src, skins, null, 40, CALLBACK(src, .proc/radial_check, user), TRUE)
	if(!icono || !radial_check(user))
		return

	var/cancionreal = genero + " � " + nombre
	if(!GLOB.sounds_cache.Find(rutacancion))
		GLOB.sounds_cache += rutacancion

	used = TRUE
	track = new /datum/track(rutacancion, tiempo, 5, icono, cancionreal) // Aqui ocurre la magia
	icon_state = icono
	name = nombre + " vinyl"
	desc = "A vinyl holder of spessman tunes, bring it to a jukebox."

	playsound(src,'sound/items/change_jaws.ogg',50,1)

	message_admins("[key_name(usr)] ha creado una nueva cancion: \"[nombre]\"")

// JUKEBOX ALT

/obj/machinery/hispaniabox/boombox
	name = "boombox"
	desc = "For REAL Workout."
	icon_state = "boombox"
	anchored = TRUE
	max_integrity = 50
	integrity_failure = 35
	songs = list(
		"Play/Pause",
		"WORK HARDER NOT SMARTER || Work Harder - LISA"    = new /datum/track('modular_hispania/sound/hispaniabox/harder.ogg',	1240,	5,	"harder", "Work Harder - LISA"),)
	musicrange = 8
	MusicChannel = CHANNEL_RADIOBOX
