extends Enemy2D

func _ready():
	behaviours = [
#		BEHAVIOUR_TYPE.SPAWNER,
		BEHAVIOUR_TYPE.RANGED,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 2
	damage = 1
