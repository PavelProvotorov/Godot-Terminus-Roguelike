extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.WANDER,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 1
	health = 1
	melee_damage = 0
	setup()
