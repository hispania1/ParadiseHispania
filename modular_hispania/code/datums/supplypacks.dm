//Cloaker//
/datum/supply_packs/security/armory/cloaker
	name = "cloaker gear crate"
	contains = list(/obj/item/clothing/head/beret/centcom/officer,
					/obj/item/clothing/head/beret/centcom/officer,
					/obj/item/clothing/suit/armor/bulletproof,
					/obj/item/clothing/suit/armor/bulletproof,
					/obj/item/clothing/shoes/combat/swat,
					/obj/item/clothing/shoes/combat/swat,
					/obj/item/clothing/gloves/combat,
					/obj/item/clothing/gloves/combat,
					/obj/item/melee/classic_baton,
					/obj/item/melee/classic_baton,
					/obj/item/clothing/mask/gas/sechailer/cloaker,
					/obj/item/clothing/mask/gas/sechailer/cloaker,
					/obj/item/storage/belt/military/assault,
					/obj/item/storage/belt/military/assault)
	cost = 1150
	containername = "assault armor crate"
	contraband = 1
  
// Prototipo syndie
/datum/supply_packs/science/syndieprototype
	name = "Suspicious Prototype Crate"
	contains = list(/obj/item/syndieprototype)
	cost = 1200
	containername = "suspicious machine prototype crate"
	contraband = 1

// Vinilos
/datum/supply_packs/misc/vinyl
	name = "Custom Music (Vinyls)"
	contains = list(/obj/item/vinyldiscojukebox,
					/obj/item/vinyldiscojukebox,
					/obj/item/vinyldiscojukebox,)
	cost = 150
	containername = "custom music"
	containertype = /obj/structure/closet/crate/plastic
