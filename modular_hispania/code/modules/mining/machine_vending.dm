#define EQUIPMENT(n, o, p) n = new /datum/data/mining_equipment(n, o, p)
/obj/machinery/mineral/equipment_vendor
	var/list/hispa_prize

/obj/machinery/mineral/equipment_vendor/Initialize(mapload)
	..()
	hispa_prize = list()
	hispa_prize = list(
		EQUIPMENT("Premium Accelerator", 		/obj/item/gun/energy/kinetic_accelerator/premiumka, 					8000),
		EQUIPMENT("Precise Accelerator", 		/obj/item/gun/energy/kinetic_accelerator/premiumka/precise, 			15000),
		EQUIPMENT("Rapid Accelerator", 		/obj/item/gun/energy/kinetic_accelerator/premiumka/rapid, 					15000),
		EQUIPMENT("Heavy Accelerator", 		/obj/item/gun/energy/kinetic_accelerator/premiumka/heavy, 					15000),
		EQUIPMENT("Modular Accelerator", 		/obj/item/gun/energy/kinetic_accelerator/premiumka/modular, 			20000),
		EQUIPMENT("Build-you-own-KA kit", 		/obj/item/gun/energy/kinetic_accelerator/premiumka/byoka, 				30000),
	)
	prize_list["Kinetic Accelerator"] |= hispa_prize

#define EQUIPMENT(n, o, p) n = new /datum/data/mining_equipment(n, o, p)
