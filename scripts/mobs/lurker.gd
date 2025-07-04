extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.AMBUSH,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 1
	melee_damage = 2
	health = 4
	speed = 1
