/datum/supplyfacedatum
	var/obj/structure/roguemachine/supplyface/parent
	var/favours = 1
	var/cooldown = 0


/datum/supplyfacedatum/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Supplies", "Order Supplies")
		ui.open()


