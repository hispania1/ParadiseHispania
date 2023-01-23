//HISPANIA EVENTS
#define ASSIGNMENT_SERVICE "Service"
//HISPANIA CHANGES END

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
		)

#undef ASSIGNMENT_SERVICE

