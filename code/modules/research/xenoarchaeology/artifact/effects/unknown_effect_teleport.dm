
/datum/artifact_effect/teleport
	effecttype = "teleport"
	effect = list(EFFECT_TOUCH, EFFECT_AURA, EFFECT_PULSE)
	effect_type = 6

/datum/artifact_effect/teleport/DoEffectTouch(var/mob/user)
	var/weakness = GetAnomalySusceptibility(user)
	if(prob(100 * weakness))
		var/list/randomturfs = new/list()
		for(var/turf/simulated/floor/T in orange(user, 50))
			randomturfs.Add(T)
		if(randomturfs.len > 0)
			to_chat(user, "<span class='warning'>You are suddenly zapped away elsewhere!</span>")
			user.unlock_from()

			spark(user, 3, FALSE)
			user.forceMove(pick(randomturfs))
			spark(user, 3, FALSE)

/datum/artifact_effect/teleport/DoEffectAura()
	if(holder)
		for (var/mob/living/M in range(src.effectrange,holder))
			var/weakness = GetAnomalySusceptibility(M)
			if(prob(100 * weakness))
				var/list/randomturfs = new/list()
				for(var/turf/simulated/floor/T in orange(M, 30))
					randomturfs.Add(T)
				if(randomturfs.len > 0)
					to_chat(M, "<span class='warning'>You are displaced by a strange force!</span>")
					M.unlock_from()
					spark(M, 3, FALSE)
					M.forceMove(pick(randomturfs))
					spark(M, 3, FALSE)

/datum/artifact_effect/teleport/DoEffectPulse()
	if(holder)
		for (var/mob/living/M in range(src.effectrange, holder))
			var/weakness = GetAnomalySusceptibility(M)
			if(prob(100 * weakness))
				var/list/randomturfs = new/list()
				for(var/turf/simulated/floor/T in orange(M, 15))
					randomturfs.Add(T)
				if(randomturfs.len > 0)
					to_chat(M, "<span class='warning'>You are displaced by a strange force!</span>")

					spark(M, 3, FALSE)
					M.unlock_from()
					M.forceMove(pick(randomturfs))
					spark(M, 3, FALSE)
