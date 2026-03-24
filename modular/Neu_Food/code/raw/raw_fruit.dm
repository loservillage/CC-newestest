/obj/item/reagent_containers/food/snacks/rogue/fruit/apple_sliced
	name = "apple slice"
	icon = 'modular/Neu_Food/icons/raw/raw_fruit.dmi'
	icon_state = "apple_sliced"
	desc = "A neatly sliced bit of apple. Nicer to eat. Refined, even."
	faretype = FARE_FINE
	tastes = list("airy apple" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	//CC Edit Begin
	diet_types = list("Fruits")
	diet_change_amount = FOOD_DIETARY_VALUE_POOR
	//CC Edit End

/obj/item/reagent_containers/food/snacks/rogue/fruit/pumpkin_sliced
	name = "pumpkin slice"
	icon = 'modular/Neu_Food/icons/raw/raw_fruit.dmi'
	icon_state = "pumpkin_sliced"
	desc = "A neatly sliced bit of pumpkin. Typically cooked first."
	faretype = FARE_POOR
	tastes = list("pumpkin" = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/pumpkin_mashed
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/preserved/pumpkin_mashed
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	rotprocess = SHELFLIFE_LONG
	//CC Edit Begin
	diet_types = list("Fruits", "Vegetables") //It's quite universal.
	diet_change_amount = FOOD_DIETARY_VALUE_POOR - 1
	//CC Edit End
