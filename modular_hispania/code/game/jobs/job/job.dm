/datum/job
	var/list/hispa_access = list()
	hispa_access = list(ACCESS_MAINT_TUNNELS)

/datum/job/get_access()
	access |= hispa_access
	return ..()
