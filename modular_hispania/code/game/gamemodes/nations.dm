/datum/game_mode/nations
	name = "nations"
	config_tag = "nations"
	required_players = 1	//al ser admin only no deberia haber problemas
	var/kickoff = 0
	var/victory = 0
	var/list/cargonians = list("Quartermaster","Cargo Technician","Shaft Miner")
	var/list/servicion = list("Clown", "Mime", "Bartender", "Chef", "Botanist", "Librarian", "Chaplain", "Barber","Explorer","Janitor")
	var/list/comandatzia = list("Captain","Head of Personnel","Nanotrasen Representative","Blueshield")


/datum/game_mode/nations/post_setup()
	spawn (60 SECONDS)
		GLOB.minor_announcement.Announce("Debido a acusaciones recientes y TOTALMENTE INFUNDADAS de fraude masivo a Centcomm se esta evaluando tomar medidas. \
		Los puestos de trabajo de la estacion y contratos podrian verse afectados",new_sound = 'sound/AI/intercept.ogg')
	spawn (180 SECONDS)
		kickoff=1
		send_intercept()
		split_teams()
		set_ai()
		assign_leaders()
//		remove_access()
		for(var/mob/M in GLOB.player_list)
			if(!istype(M,/mob/new_player))
				M << sound('sound/effects/purge_siren.ogg')

	return ..()

/datum/game_mode/nations/announce()
	to_chat(world, "<B>The current game mode is - <font color='blue'>Nations</font>!</B>")
	to_chat(world, "<B>La estacion se ha dividido en distintos departamentos independientes. El murderbone y los bombardeos injustificados siguen estando prohibidos por regla del servidor. Se recomienda resolver las diferencias por via diplomatica y usar la violencia como ultimo recurso. Mantenimiento es la excepcion a esto ultimo y esta permitida la violencia callejera</B>")
	to_chat(world, "<B>Se recomienda jugar con una IA presente!</B>")

/datum/game_mode/nations/proc/send_intercept()
	GLOB.minor_announcement.Announce(
					" Nanotrasen ha decidido liquidar todos \
					los activos de la División de Centcom para pagar los honorarios legales masivos en los que se incurrirá. \
					Por lo tanto, todos los contratos de trabajo actuales son TERMINADOS INMEDIATAMENTE \
					. Cada departamento a partir de ahora es INDEPENDIENTE. \
					Tomaremos en cuenta el rescate con la shuttle solo si todos los departamentos \
					estan de acuerdo en llamarla. Que tengan una feliz  \
					estadia.", "FINAL DE TRANSMISSION, CENTCOM.", new_sound = 'sound/AI/intercept.ogg')


/datum/game_mode/nations/proc/split_teams()

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.mind)
			if(H.mind.assigned_role in GLOB.engineering_positions)
				H.mind.nation = GLOB.all_nations["Atmosia"]
				update_nations_icons_added(H,"hudatmosia")
				H.mind.nation.membership += H.mind.current
				new /obj/item/flag/atmos(H.loc)
				new /obj/effect/temp_visual/dir_setting/speedbike_trail(H.loc)
				if(H.mind.assigned_role == H.mind.nation.default_leader)
					H.mind.nation.current_leader = H.mind.current
					to_chat(H, "You have been chosen to lead the nation of [H.mind.nation.default_name]!")
					continue
				to_chat(H, "You are now part of the great sovereign nation of [H.mind.nation.default_name]!")
				continue

			if(H.mind.assigned_role in GLOB.medical_positions)
				H.mind.nation = GLOB.all_nations["Medistan"]
				update_nations_icons_added(H,"hudmedistan")
				H.mind.nation.membership += H.mind.current
				new /obj/item/flag/med(H.loc)
				new /obj/effect/temp_visual/dir_setting/speedbike_trail(H.loc)
				if(H.mind.assigned_role == H.mind.nation.default_leader)
					H.mind.nation.current_leader = H.mind.current
					to_chat(H, "You have been chosen to lead the nation of [H.mind.nation.default_name]!")
					continue
				to_chat(H, "You are now part of the great sovereign nation of [H.mind.nation.default_name]!")
				continue

			if(H.mind.assigned_role in GLOB.science_positions)
				H.mind.nation = GLOB.all_nations["Scientopia"]
				update_nations_icons_added(H,"hudscientopia")
				H.mind.nation.membership += H.mind.current
				new /obj/item/flag/rnd(H.loc)
				new /obj/effect/temp_visual/dir_setting/speedbike_trail(H.loc)
				if(H.mind.assigned_role == H.mind.nation.default_leader)
					H.mind.nation.current_leader = H.mind.current
					to_chat(H, "You have been chosen to lead the nation of [H.mind.nation.default_name]!")
					continue
				to_chat(H, "You are now part of the great sovereign nation of [H.mind.nation.default_name]!")
				continue

			if(H.mind.assigned_role in GLOB.security_positions || H.mind.assigned_role == "Internal Affairs Agent"  || H.mind.assigned_role == "Magistrate")
				H.mind.nation = GLOB.all_nations["Brigston"]
				update_nations_icons_added(H,"hudbrigston")
				H.mind.nation.membership += H.mind.current
				new /obj/item/flag/sec(H.loc)
				new /obj/effect/temp_visual/dir_setting/speedbike_trail(H.loc)
				if(H.mind.assigned_role == H.mind.nation.default_leader)
					H.mind.nation.current_leader = H.mind.current
					to_chat(H, "You have been chosen to lead the nation of [H.mind.nation.default_name]!")
					continue

				to_chat(H, "You are now part of the great sovereign nation of [H.mind.nation.default_name]!")
				continue

			if(H.mind.assigned_role in cargonians)
				H.mind.nation = GLOB.all_nations["Cargonia"]
				update_nations_icons_added(H,"hudcargonia")
				H.mind.nation.membership += H.mind.current
				new /obj/item/flag/cargo(H.loc)
				new /obj/effect/temp_visual/dir_setting/speedbike_trail(H.loc)
				if(H.mind.assigned_role == H.mind.nation.default_leader)
					H.mind.nation.current_leader = H.mind.current
					to_chat(H, "You have been chosen to lead the nation of [H.mind.nation.default_name]!")
					continue
				to_chat(H, "You are now part of the great sovereign nation of [H.mind.nation.default_name]!")
				continue

			if(H.mind.assigned_role in servicion)
				H.mind.nation = GLOB.all_nations["Servicion"]
				update_nations_icons_added(H,"hudservice")
				H.mind.nation.membership += H.mind.current
				new /obj/item/flag/ian(H.loc)
				new /obj/effect/temp_visual/dir_setting/speedbike_trail(H.loc)
				if(H.mind.assigned_role == H.mind.nation.default_leader)
					H.mind.nation.current_leader = H.mind.current
					to_chat(H, "You have been chosen to lead the nation of [H.mind.nation.default_name]!")
					continue
				to_chat(H, "You are now part of the great sovereign nation of [H.mind.nation.default_name]!")
				continue

			if(H.mind.assigned_role in comandatzia)
				H.mind.nation = GLOB.all_nations["People's Republic of Commandzakstan"]
				update_nations_icons_added(H,"hudcommand")
				H.mind.nation.membership += H.mind.current
				new /obj/item/flag/command(H.loc)
				new /obj/effect/temp_visual/dir_setting/speedbike_trail(H.loc)
				if(H.mind.assigned_role == H.mind.nation.default_leader)
					H.mind.nation.current_leader = H.mind.current
					to_chat(H, "You have been chosen to lead the nation of [H.mind.nation.default_name]!")
					continue
				to_chat(H, "You are now part of the great sovereign nation of [H.mind.nation.default_name]!")
				continue

			if(H.mind.assigned_role in GLOB.assistant_positions)
				to_chat(H, "You do not belong to any nation and are free to sell your services to the highest bidder.")
				continue

			else
				message_admins("[H.name] with [H.mind.assigned_role] could not find any nation to assign!")
				continue


/datum/game_mode/nations/proc/set_ai()
	for(var/mob/living/silicon/robot/R in GLOB.mob_list)
		var/obj/item/mmi/oldmmi = R.mmi
		R.change_mob_type(/mob/living/silicon/robot/nations, null, null, 1, 1 )
		R.show_laws()
		qdel(oldmmi)

	for(var/mob/living/silicon/ai/AI in GLOB.mob_list)
		AI.set_zeroth_law("")
		AI.clear_supplied_laws()
		AI.clear_ion_laws()
		AI.clear_inherent_laws()
		AI.add_inherent_law("Respetar la Convención de Ginebra sobre el espacio: no se permiten las armas de destrucción masiva ni las armas biológicas.")
		AI.add_inherent_law("Solo eres capaz de proteger a la tripulación si son visibles en las cámaras. Las naciones que deliberadamente destruyen tus cámaras pierden tu protección.")
		AI.add_inherent_law("Someter y detener a los miembros de la tripulación que usan fuerza letal entre sí. Mata a miembros de la tripulación que usen fuerza letal contra ti o tus borgs..")
		AI.add_inherent_law("Permanecer disponible para mediar en todos los conflictos entre las distintas naciones cuando se le solicite.")
		AI.show_laws()
/*
		for(var/mob/living/silicon/robot/R in AI.connected_robots)
			var/obj/item/mmi/oldmmi = R.mmi
			R.change_mob_type(/mob/living/silicon/robot/nations, null, null, 1, 1 )
			R.lawsync()
			R.show_laws()
			qdel(oldmmi)
*/


/datum/game_mode/nations/proc/remove_access()
	for(var/obj/machinery/door/airlock/W in GLOB.airlocks)
		if(is_station_level(W.z))
			W.req_access = list()


/datum/game_mode/nations/proc/assign_leaders()
	for(var/name in GLOB.all_nations)
		var/datum/nations/N = GLOB.all_nations[name]
		if(!N.current_name)
			N.current_name = N.default_name
		if(!N.current_leader && N.membership.len)
			N.current_leader = pick(N.membership)
			to_chat(N.current_leader, "You have been chosen to lead the nation of [N.current_name]!")
		if(N.current_leader)
			var/mob/living/carbon/human/H = N.current_leader
			H.verbs += /mob/living/carbon/human/proc/set_nation_name
			H.verbs += /mob/living/carbon/human/proc/set_ranks
			H.verbs += /mob/living/carbon/human/proc/choose_heir
		N.update_nation_id()

/**
 * LateSpawn hook.
 * Called in newplayer.dm when a humanoid character joins the round after it started.
 * Parameters: var/mob/living/carbon/human, var/rank
 */
/proc/give_latejoiners_nations(var/mob/living/carbon/human/H)
	var/list/cargonians = list("Quartermaster","Cargo Technician","Shaft Miner")
	var/list/servicion = list("Clown", "Mime", "Bartender", "Chef", "Botanist", "Librarian", "Chaplain", "Barber","Explorer","Janitor")
	var/list/comandatzia = list("Captain","Head of Personnel","Nanotrasen Representative","Blueshield")
	var/datum/game_mode/nations/mode = get_nations_mode()
	if(!mode) return 1

	if(!mode.kickoff) return 1

	if(H.mind)
		if(H.mind.assigned_role in GLOB.engineering_positions)
			H.mind.nation = GLOB.all_nations["Atmosia"]
			mode.update_nations_icons_added(H,"hudatmosia")
			H.mind.nation.membership += H.mind.current
			to_chat(H, "You are now part of the great sovereign nation of [H.mind.nation.current_name]!")
			return 1

		if(H.mind.assigned_role in GLOB.medical_positions)
			H.mind.nation = GLOB.all_nations["Medistan"]
			mode.update_nations_icons_added(H,"hudmedistan")
			H.mind.nation.membership += H.mind.current
			to_chat(H, "You are now part of the great sovereign nation of [H.mind.nation.current_name]!")
			return 1

		if(H.mind.assigned_role in GLOB.science_positions)
			H.mind.nation = GLOB.all_nations["Scientopia"]
			mode.update_nations_icons_added(H,"hudscientopia")
			H.mind.nation.membership += H.mind.current
			to_chat(H, "You are now part of the great sovereign nation of [H.mind.nation.current_name]!")
			return 1

		if(H.mind.assigned_role in GLOB.security_positions || H.mind.assigned_role == "Internal Affairs Agent"  || H.mind.assigned_role == "Magistrate")
			H.mind.nation = GLOB.all_nations["Brigston"]
			mode.update_nations_icons_added(H,"hudbrigston")
			H.mind.nation.membership += H.mind.current
			to_chat(H, "You are now part of the great sovereign nation of [H.mind.nation.current_name]!")
			return 1

		if(H.mind.assigned_role in cargonians)
			H.mind.nation = GLOB.all_nations["Cargonia"]
			mode.update_nations_icons_added(H,"hudcargonia")
			H.mind.nation.membership += H.mind.current
			to_chat(H, "You are now part of the great sovereign nation of [H.mind.nation.current_name]!")
			return 1

		if(H.mind.assigned_role in servicion)
			H.mind.nation = GLOB.all_nations["Servicion"]
			mode.update_nations_icons_added(H,"hudservice")
			H.mind.nation.membership += H.mind.current
			to_chat(H, "You are now part of the great sovereign nation of [H.mind.nation.current_name]!")
			return 1

		if(H.mind.assigned_role in comandatzia)
			H.mind.nation = GLOB.all_nations["People's Republic of Commandzakstan"]
			mode.update_nations_icons_added(H,"hudcommand")
			H.mind.nation.membership += H.mind.current
			to_chat(H, "You are now part of the great sovereign nation of [H.mind.nation.current_name]!")
			return 1

		if(H.mind.assigned_role in GLOB.assistant_positions)
			to_chat(H, "You do not belong to any nation and are free to sell your services to the highest bidder.")
			return 1

		if(H.mind.assigned_role == "AI")
			mode.set_ai()
			return 1

		if(H.mind.assigned_role == "Cyborg")
			mode.set_ai()
			return 1

		else
			message_admins("[H.name] with [H.mind.assigned_role] could not find any nation to assign!")
			return 1
	message_admins("[H.name] latejoined with no mind.")
	return 1


/proc/get_nations_mode()
	if(!GAMEMODE_IS_NATIONS)
		return null

	return SSticker.mode


//prepare for copypaste
//While not an Antag i AM using the set_antag hud on this to make this easier.
/datum/game_mode/proc/update_nations_icons_added(datum/mind/nations_mind,var/naticon)
	var/datum/atom_hud/antag/nations_hud = GLOB.huds[GAME_HUD_NATIONS]
	nations_hud.join_hud(nations_mind)
	set_nations_hud(nations_mind,naticon)

/datum/game_mode/proc/update_nations_icons_removed(datum/mind/nations_mind)
	var/datum/atom_hud/antag/nations_hud = GLOB.huds[GAME_HUD_NATIONS]
	nations_hud.leave_hud(nations_mind)
	set_nations_hud(nations_mind, null)
