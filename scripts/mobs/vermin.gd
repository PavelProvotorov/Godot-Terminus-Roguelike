extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.FLEE,
		BEHAVIOUR_TYPE.AMBUSH,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.RALLY,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 1
	melee_damage = 1
	health = 1
	speed = 1

func get_flee_behaviour_config() -> Dictionary:
	return {
		"health_threshold": 0,
		"flee_when_close": true,
		"skip_chance": 75,
	}

func ambush_behaviour_config() -> Dictionary: 
	return {
		"close_in": true
	}
