/obj/proc/food_rot_enter(atom/movable/arrived)
	if(istype(arrived,/obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/snacc=arrived
		snacc.stop_rotting()

/obj/proc/food_rot_leave(atom/movable/gone)
	if(istype(gone,/obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/snacc=gone
		snacc.begin_rotting()
