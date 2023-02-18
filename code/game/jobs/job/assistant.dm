/datum/job/assistant
	title = "Assistant"
	flag = JOB_ASSISTANT
	department_flag = JOBCAT_SUPPORT
	total_positions = -1
	spawn_positions = -1
	supervisors = "the head of personnel"
	department_head = list("Head of Personnel")
	selection_color = "#dddddd"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit = /datum/outfit/job/assistant

/datum/job/assistant/get_access()
	if(GLOB.configuration.jobs.assistant_maint_access)
		return list(ACCESS_MAINT_TUNNELS)
	else
		return list()

/datum/outfit/job/assistant
	name = "Assistant"
	jobtype = /datum/job/assistant

	uniform = /obj/item/clothing/under/color/random
	shoes = /obj/item/clothing/shoes/black
	id = /obj/item/card/id/assistant

//HISPANIA CHANGES START
/datum/job/aprendiz
	title = "Aprendiz"
	max_horas = TRUE	// convierte la exp en vez de minimo a maximo
	//esta exp map esta revertida, en vez de minimo 5 horas para jugarlo, es maximo 5 horas para jugarlo
	exp_map = list(EXP_TYPE_CREW = 600)
	flag = JOB_ASSISTANT
	department_flag = JOBCAT_SUPPORT
	total_positions = -1
	spawn_positions = -1
	supervisors = "the head of personnel"
	department_head = list("Head of Personnel")
	selection_color = "#dddddd"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit = /datum/outfit/job/aprendiz

/datum/job/aprendiz/get_access()
	if(GLOB.configuration.jobs.assistant_maint_access)
		return list(ACCESS_MAINT_TUNNELS)
	else
		return list()

/datum/outfit/job/aprendiz
	name = "Aprendiz"
	jobtype = /datum/job/aprendiz
	uniform = /obj/item/clothing/under/color/random
	shoes = /obj/item/clothing/shoes/black
	backpack_contents = list(
		/obj/item/crowbar = 1,
		/obj/item/flashlight/lantern = 1,
		/obj/item/storage/firstaid/regular = 1,
		/obj/item/book/manual/wiki/sop_general = 1,
		/obj/item/storage/toolbox/fluff/lunchbox
	)

//HISPANIA CHANGES END

