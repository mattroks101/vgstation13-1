/obj/effect/mine
	name = "Mine"
	desc = "I better stay away from that thing."
	density = 0
	anchored = 1
	w_type=NOT_RECYCLABLE
	icon = 'icons/obj/weapons.dmi'
	icon_state = "uglymine"
	var/triggerproc = "explode" //name of the proc thats called when the mine is triggered
	var/triggered = 0

/obj/effect/mine/New()
	..()
	icon_state = "uglyminearmed"

/obj/effect/mine/Crossed(mob/living/carbon/AM)
	if(istype(AM))
		visible_message("<span class='warning'>[AM] triggered \the [bicon(src)] [src]</span>")
		trigger(AM)

/obj/effect/mine/proc/trigger(mob/living/carbon/AM)
	explosion(loc, 0, 1, 2, 3)
	qdel(src)

/obj/effect/mine/dnascramble
	name = "Radiation Mine"

/obj/effect/mine/dnascramble/trigger(mob/living/carbon/AM)
	spark(src)
	AM.apply_radiation(50, RAD_INTERNAL)
	randmutb(AM)
	domutcheck(AM,null)
	qdel(src)

/obj/effect/mine/plasma
	name = "Plasma Mine"

/obj/effect/mine/plasma/trigger(AM)
	for(var/turf/simulated/floor/target in range(1,src))
		if(!target.blocks_air)
			var/datum/gas_mixture/payload = new
			payload.toxins = 30
			target.zone.air.merge(payload)
			target.hotspot_expose(1000, CELL_VOLUME)
	qdel(src)

/obj/effect/mine/kick
	name = "Kick Mine"

/obj/effect/mine/kick/trigger(mob/AM)
	spark(src)
	del(AM.client)
	qdel(src)

/obj/effect/mine/n2o
	name = "N2O Mine"

/obj/effect/mine/n2o/trigger(AM)
	//example: n2o triggerproc
	//note: im lazy

	for (var/turf/simulated/floor/target in range(1,src))
		if(!target.blocks_air)

			var/datum/gas_mixture/payload = new
			var/datum/gas/sleeping_agent/trace_gas = new

			trace_gas.moles = 187 // total mols of a n2o canister 1870.81
			payload += trace_gas

			target.zone.air.merge(payload)

	qdel(src)

/obj/effect/mine/stun
	name = "Stun Mine"

/obj/effect/mine/stun/trigger(mob/AM)
	if(ismob(AM))
		AM.Knockdown(10)
	spark(src)
	qdel(src)