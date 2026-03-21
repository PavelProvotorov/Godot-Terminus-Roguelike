extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
		BEHAVIOUR_TYPE.OPEN_DOOR,
		BEHAVIOUR_TYPE.WANDER,
	]
	attack_range = 1
	health = 4
	melee_damage = 2
	set_wandering(true)
