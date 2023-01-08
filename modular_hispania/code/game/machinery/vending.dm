//Hispania Vending

/obj/machinery/economy/vending
	var/list/hispa_products = list()
	var/list/hispa_contraband = list()
	var/list/hispa_premium = list()
	var/list/hispa_prices = list()

///Hispania Civilians Clothes

/obj/machinery/economy/vending/Initialize(mapload)
	products |= hispa_products // For each, use the following pattern:
	contraband |= hispa_contraband // list(/type/path = amount,/type/path2 = amount2)
	premium |= hispa_premium
	prices |= hispa_prices
	..()

/obj/machinery/economy/vending/security
	hispa_products = list(
					/obj/item/fluff/mongosflash = 1,
					/obj/item/storage/backpack/fluff/syndiesatchel = 1,
					/obj/item/fluff/desolate_baton_kit = 1,
					/obj/item/fluff/pyro_wintersec_kit = 1,
					/obj/item/fluff/sylus_conversion_kit = 1
					)
	hispa_prices = list(
					/obj/item/fluff/mongosflash = 3000,
					/obj/item/storage/backpack/fluff/syndiesatchel = 5000,
					/obj/item/fluff/desolate_baton_kit = 90000,
					/obj/item/fluff/pyro_wintersec_kit = 12000,
					/obj/item/fluff/sylus_conversion_kit = 15000
					)

/obj/machinery/economy/vending/bardrobe
		hispa_products = list(
					/obj/item/fluff/mongosflash = 1,

					)
	hispa_prices = list(
					/obj/item/fluff/mongosflash = 3000,

					)


