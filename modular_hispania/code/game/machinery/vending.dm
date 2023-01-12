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

/obj/machinery/economy/vending/detdrobe
	hispa_products = list(
					/obj/item/clothing/under/rank/security/detective/black = 1,
					/obj/item/clothing/under/rank/security/detective/fem = 2,
					/obj/item/clothing/suit/storage/det_suit/forensics/black = 1,
					/obj/item/clothing/head/det_hat/black = 1)
	hispa_prices = list(
					/obj/item/clothing/under/rank/security/detective/black = 50,
					/obj/item/clothing/under/rank/security/detective/fem = 50,
					/obj/item/clothing/suit/storage/det_suit/forensics/black = 75,
					/obj/item/clothing/head/det_hat/black = 20)
