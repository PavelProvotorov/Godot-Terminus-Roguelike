extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
		BEHAVIOUR_TYPE.WANDER,
	]
	attack_range = 1
	health = 6
	melee_damage = 3
