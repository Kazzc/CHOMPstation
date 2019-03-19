//Hivebot based zergs woo
#define LASERS_TO_KILL *30 //Explanation in hivebot.dm
/mob/living/simple_animal/hostile/hivebot/zerg //Base Zerg template
	name = "zerg template"
	desc = "The Zerg Swarm is a terrifying and ruthless amalgamation of biologically advanced, arthropodal aliens. Dedicated to the pursuit of genetic perfection."
	faction = "zerg"
	speed = 2
	melee_damage_lower = 2
	melee_damage_upper = 2
	
	zergoverride  = 1
	
	projectilesound = 'sound/effects/splat.ogg'
	projectiletype = /obj/item/projectile/energy/acid

	speak = list("For the Hive!",)
	emote_hear = list()
	emote_see = list("looks around the area", "turns from side to side")
	say_understood = list("Affirmative.", "Positive.")
	say_cannot = list("Denied.", "Negative.")
	say_maybe_target = list("Possible threat detected.  Investigating.", "Motion detected.", "Investigating.")
	say_got_target = list("Threat detected.", "Threat removal engaged.", "Engaging target.")
	
	var/zerg_types = list("Zerg Drone" = /mob/living/simple_animal/hostile/hivebot/zerg/worker,)


/mob/living/simple_animal/hostile/hivebot/zerg/isSynthetic()
	return FALSE

/mob/living/simple_animal/hostile/hivebot/zerg/larva/proc/evolve()
	//TODDO MAke this work nicely
	set name = "EVOLVE"
	set desc = "Performs larva evolution."
	set category = "Abilities"
	var/location = get_turf(src)
	chosentype = input(usr,"What type would you like to be?") as null|anything in zerg_types
	if(!chosentype) return
	if(!src.ckey) 
		death()
		qdel(src)
		new /mob/living/simple_animal/hostile/hivebot/zerg/worker(location)
	else
		var/myuser = src.key
		death()
		qdel(src)
		var/mob/living/simple_animal/hostile/newmob = new chosentype(location)
		newmob.ckey = myuser

/mob/living/simple_animal/hostile/hivebot/zerg/larva
	name = "zerg larva"
	desc = "Larva are a fundamental zerg type, able to turn into other types"
	melee_damage_lower = 0
	melee_damage_upper = 0
	maxHealth = 0.2 LASERS_TO_KILL
	health = 0.2 LASERS_TO_KILL
	var/chosentype = null
/mob/living/simple_animal/hostile/hivebot/zerg/larva/Life()
	..()

/mob/living/simple_animal/hostile/hivebot/zerg/larva/New()
	..()
	verbs |= /mob/living/simple_animal/hostile/hivebot/zerg/larva/proc/evolve
	
/mob/living/simple_animal/hostile/hivebot/zerg/larva/initialize()
	spawn(1200)
		if(!src.ckey)
			evolve()
/mob/living/simple_animal/hostile/hivebot/zerg/worker
	name = "Zerg Drone"
	desc = "Drones are fundamental to economic and tech development, as they harvest resources and construct buildings."
	maxHealth = 1 LASERS_TO_KILL
	health = 1 LASERS_TO_KILL
	melee_damage_lower = 1
	melee_damage_upper = 1
