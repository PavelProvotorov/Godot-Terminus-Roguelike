extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.FLEE,
		BEHAVIOUR_TYPE.AMBUSH,
		BEHAVIOUR_TYPE.WANDER,
		BEHAVIOUR_TYPE.RANGED,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 2
	health = 3
	melee_damage = 1
	ranged_damage = 1
	setup()

func get_flee_behaviour_config() -> Dictionary:
	return {
		"health_threshold": 0,
		"flee_when_close": true,
		"skip_chance": 25,
	}
