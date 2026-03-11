/datum/reagent/liquid_fertilizer
	name = "Liquid Fertilizer"
	description = "A mixture of water and fertilizer. Good for plants, not so much for you..."
	color = "#572700c6"
	taste_description = "disguting sludge"

/datum/reagent/liquid_fertilizer/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(1)
	M.add_nausea(12)

/datum/reagent/liquid_fertilizer/premium
	name = "Nutriment Rich Liquid Fertilizer"
	description = "An excellent, well balanced mixture of water, and a special blend of fertilizer. This is what plants REALLY crave!"


/datum/reagent/liquid_fertilizer/premium/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(2)
	M.add_nausea(20)

/obj/structure/soil/proc/try_handle_liquidfertilizer(obj/item/attacking_item, mob/user, params)
	var/water_amount = 0
	var/fertilizer_amount = 0
	if(istype(attacking_item, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/container = attacking_item
		if(container.reagents.has_reagent(/datum/reagent/liquid_fertilizer, 10) || container.reagents.has_reagent(/datum/reagent/liquid_fertilizer/premium, 10))
			water_amount = 150
			fertilizer_amount = 150
			if(nutrition >= MAX_PLANT_NUTRITION * 0.8 && water >= MAX_PLANT_WATER * 0.8 && !container.reagents.has_reagent(/datum/reagent/liquid_fertilizer/premium,10))
				if(isliving(user))
					var/mob/living/livinguser = user
					if(livinguser.patron.type in ALL_DIVINE_PATRONS)
						to_chat(user,span_warning("Dendor be blessed, this soil is already well taken care of!"))
						return TRUE
				to_chat(user, span_warning("The soil seems fine. It doesn't need this... sludge."))
				return TRUE
			else if(container.reagents.has_reagent(/datum/reagent/liquid_fertilizer/premium,10))
				container.reagents.remove_reagent(/datum/reagent/liquid_fertilizer/premium,10)
				fertilize_soil()
				adjust_nutrition(fertilizer_amount)
				adjust_water(water_amount)
				to_chat(user,span_info("You pour some of the rich liquid fertilizer onto the soil. It looks more prosperous already!"))
				return TRUE
			else if(container.reagents.has_reagent(/datum/reagent/liquid_fertilizer,10))
				container.reagents.remove_reagent(/datum/reagent/liquid_fertilizer,10)
				adjust_nutrition(fertilizer_amount)
				adjust_water(water_amount)
				to_chat(user,span_info("You pour some of the liquid fertilizer onto the soil."))
				return TRUE
	return FALSE

			
