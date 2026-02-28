/obj/structure/roguemachine/supplyface
	name = "SUPPLYFACE"
	desc = "A specialized goldface, which, instead of paying with coins, accepts favours from the Azurian Mercenary's Guild."
	var/datum/supplyfacedatum/sfd

/obj/structure/roguemachine/supplyface/Initialize()
	. = ..()
	sfd = new()
	sfd.parent = src

/obj/structure/roguemachine/supplyface/attackby(obj/item/P, mob/user, params)
	if(istype(P, /obj/item/voucher/quest))
		sfd.favours += 1
		playsound(loc, 'sound/misc/machinevomit.ogg', 100, TRUE, -1)
		say("Genuine voucher accepted!")

/obj/structure/roguemachine/supplyface/attack_hand(mob/living/user)
	var/datum/job/mob_job = user.job ? SSjob.GetJob(user.job) : null
	if(istype(mob_job, /datum/job/roguetown/merchant))
		sfd.ui_interact(user)
	else
		say(user.name + " is not authorized as a merchant. This incident will be reported.")
		return
