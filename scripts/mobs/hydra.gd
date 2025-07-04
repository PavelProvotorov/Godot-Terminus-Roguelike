extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.RANGED,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 2
	ranged_damage = 1
	melee_damage = 1
	health = 3
	speed = 1
