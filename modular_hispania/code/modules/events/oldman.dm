#define SPECIAL_ROLE_OLD_MAN "Old Man"

/datum/event/spawn_oldman
	announceWhen = 25
	endWhen		 = 30
	var/successSpawn = TRUE
	var/key_of_oldman

/datum/event/spawn_oldman/announce()
	if(successSpawn)
		GLOB.minor_announcement.Announce("Unknown entity detected aboard [station_name()]. Please report any sightings to local authority.", "Bioscan Alert", 'modular_hispania/sound/effects/oldman/alert.ogg')

/datum/event/spawn_oldman/proc/get_oldman(end_if_fail = 0)
	spawn()
		var/list/candidates = SSghost_spawns.poll_candidates("Do you want to play as the old man?", ROLE_DEMON, TRUE, 30 SECONDS, source = /mob/living/simple_animal/hostile/oldman, role_cleanname = "Old man")
		if(!candidates.len)
			key_of_oldman = null
			kill()
			successSpawn = FALSE
			return
		var/mob/C = pick(candidates)
		key_of_oldman = C.key

		if(!key_of_oldman)
			kill()
			successSpawn = FALSE
			return

		var/datum/mind/player_mind = new /datum/mind(key_of_oldman)
		player_mind.active = 1
		var/list/spawn_locs = list()
		for(var/obj/effect/landmark/L in GLOB.landmarks_list)
			if(isturf(L.loc))
				switch(L.name)
					if("revenantspawn")
						spawn_locs += L.loc
		if(!spawn_locs) //If we can't find any revenant spawns, try the carp spawns
			for(var/obj/effect/landmark/L in GLOB.landmarks_list)
				if(isturf(L.loc))
					switch(L.name)
						if("carpspawn")
							spawn_locs += L.loc
		if(!spawn_locs) //If we can't find either, just spawn the oldman at the player's location
			spawn_locs += get_turf(player_mind.current)
		if(!spawn_locs) //If we can't find THAT, then just retry
			kill()
			return
		var/mob/living/simple_animal/hostile/oldman/SCP = new /mob/living/simple_animal/hostile/oldman(pick(spawn_locs))
		player_mind.transfer_to(SCP)
		player_mind.assigned_role = SPECIAL_ROLE_OLD_MAN
		player_mind.special_role = SPECIAL_ROLE_OLD_MAN
		message_admins("[key_name_admin(SCP)] has been made into the Old Man by an event.")
		log_game("[key_name_admin(SCP)] was spawned as the Old Man by an event.")
		successSpawn = TRUE
		var/oldman_report = "<font size=3><b>NAS Trurl High-Priority Update</b></span>"
		oldman_report += "<br><br>Our long-range sensors have detected paranormal activity emanating from your station. There is not much information but a femur breaker seems to be its weakness. Build one and use it with a living being. We highly recommend using perma-prisoners or non-crewmembers for this horrible task"
		print_command_report(oldman_report, "Classified NAS Trurl Update", FALSE)
		GLOB.minor_announcement.Announce("A report has been downloaded and printed out at all communications consoles.", "Incoming Classified Message", 'sound/AI/commandreport.ogg')

/datum/event/spawn_oldman/start()
	get_oldman()
