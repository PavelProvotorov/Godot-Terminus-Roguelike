extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.RANGED,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 2
	ranged_damage = 2
	melee_damage = 1
	health = 4
	speed = 1

func _post_ranged_attack_hook() -> void:
	target.add_buff('blindness')
	target.update_fog()
