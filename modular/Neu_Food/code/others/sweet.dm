// -------------- CHOCOLATE -----------------
/obj/item/reagent_containers/food/snacks/chocolate
	name = "chocolate bar"
	desc = "Unbelievably fancy chocolate, imported all the way from distant Grenzelhoft"
	icon = 'modular/Neu_Food/icons/others/sweet.dmi'
	icon_state = "chocolate"
	bitesize = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("rich sweetness" = 1)
	faretype = FARE_FINE
	rotprocess = null
	eat_effect = /datum/status_effect/buff/snackbuff
	//CC Edit Begin
	//Like honey, if this is weird, do change. Chocolates are often under Carbohydrates.
	diet_types = list("Grains")
	diet_change_amount = FOOD_DIETARY_VALUE_GOOD
	//CC Edit End

/obj/item/reagent_containers/food/snacks/chocolate/On_Consume(mob/living/eater)
	if(islupian(eater) || isvulp(eater))
		to_chat(eater, span_warning("The chocolate tastes delicious but my stomach churns violently!"))
		if(iscarbon(eater))
			var/mob/living/carbon/C = eater
			C.add_nausea(120) // enough to trigger vomiting
		eater.adjustToxLoss(5)
	return ..()
