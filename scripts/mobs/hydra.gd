extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.FLEE,
		BEHAVIOUR_TYPE.AMBUSH,
		BEHAVIOUR_TYPE.RANGED,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 2
	ranged_damage = 1
	melee_damage = 1
	health = 3
	speed = 1

func _post_ranged_attack_hook():
	if get_chance(50): 
		target.add_buff('poison', 6)

func _post_melee_attack_hook():
	if get_chance(25): target.add_buff('poison', 6)
	
func get_flee_behaviour_config() -> Dictionary:
	return {
		"health_threshold": 0,
		"flee_when_close": true,
		"skip_chance": 25,
	}
