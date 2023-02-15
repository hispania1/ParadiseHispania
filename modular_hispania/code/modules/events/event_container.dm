//HISPANIA EVENTS
#define ASSIGNMENT_SERVICE "Service"
#define ASSIGMENT_CHAPLAIN "Chaplain"
#define ASSIGMENT_CARGO "Cargo"
#define ASSIGMENT_RD "RD"

/datum/event_container/
	var/list/available_events_hispa

/datum/event_container/New()
	..()
	available_events |= available_events_hispa

/datum/event_container/mundane
	available_events_hispa = list(
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Toilets clog",			/datum/event/toilets_clog, 			50,		list(ASSIGNMENT_JANITOR = 500)),
		)

/datum/event_container/moderate
	available_events_hispa = list(
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Feed me",					/datum/event/feedme, 			0,		list(ASSIGNMENT_SERVICE = 50)),
		)

/datum/event_container/major
	available_events_hispa = list(
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Swarmer Spawn", 		/datum/event/spawn_swarmer, 	10, 	list(ASSIGNMENT_SECURITY = 4),is_one_shot = TRUE),
		)

#undef ASSIGNMENT_SERVICE
#undef ASSIGMENT_CHAPLAIN
#undef ASSIGMENT_CARGO
