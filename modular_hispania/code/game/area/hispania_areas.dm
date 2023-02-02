/*

### This file contains a list of all the areas in your station. Format is as follows:

/area/CATEGORY/OR/DESCRIPTOR/NAME 	(you can make as many subdivisions as you want)
	name = "NICE NAME" 				(not required but makes things really nice)
	icon = "ICON FILENAME" 			(defaults to areas.dmi)
	icon_state = "NAME OF ICON" 	(defaults to "unknown" (blank))
	requires_power = FALSE 			(defaults to TRUE)
	music = "music/music.ogg"		(defaults to "music/music.ogg")

NOTE: This file is for Hispania specific extra AREAS used for our own tweaked/original maps
*/

/*-----------------------------------------------------------------------------*/

// ATMOS
/area/hispania/atmos/
	name = "Atmospherics Hispania"
	icon = 'modular_hispania/icons/turf/areas.dmi'

/area/hispania/atmos/storage
	name = "Atmospherics Auxiliary Storage"
	icon_state = "atmos_store"


// ENGINEERING
/area/hispania/engine
	ambientsounds = ENGINEERING_SOUNDS
	sound_environment = SOUND_AREA_LARGE_ENCLOSED
	icon = 'modular_hispania/icons/turf/areas.dmi'

/area/hispania/engine/workshop
	name = "Engineering Workshop"
	icon_state = "engi_workshop"

/area/hispania/engine/upper_hall
	name = "Engineering Upper Hall"
	icon_state = "engi_up"

/area/hispania/engine/down_hall
	name = "Engineering Main Hall"
	icon_state = "engi_down"

/area/hispania/engine/eva
	name = "Engineering EVA"
	icon_state = "engi_eva"
