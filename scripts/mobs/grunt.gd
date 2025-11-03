extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.OPEN_DOOR,
		BEHAVIOUR_TYPE.WANDER,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.RALLY,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 2
	health = 3
	melee_damage = 1
	setup()
