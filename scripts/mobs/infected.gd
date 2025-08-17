extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.WANDER,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.RALLY,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 1
	health = 3
	melee_damage = 2
	setup()
