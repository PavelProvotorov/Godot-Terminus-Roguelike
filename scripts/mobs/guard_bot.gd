extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.FLEE,
		BEHAVIOUR_TYPE.AMBUSH,
		BEHAVIOUR_TYPE.RANGED,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
		BEHAVIOUR_TYPE.OPEN_DOOR,
		BEHAVIOUR_TYPE.WANDER,
	]
	attack_range = 2
	health = 4
	melee_damage = 1
	ranged_damage = 1
	visibility = 5
	set_wandering(true)

func get_flee_behaviour_config() -> Dictionary:
	return {
		"health_threshold": 0,
		"flee_when_close": true,
		"skip_chance": 25,
	}
