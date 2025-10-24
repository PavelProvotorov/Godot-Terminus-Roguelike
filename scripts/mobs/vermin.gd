extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.RALLY,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 1
	melee_damage = 1
	health = 1
	speed = 1
