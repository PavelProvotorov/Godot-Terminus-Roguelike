extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 2
	health = 3
	melee_damage = 2
	
func _post_melee_attack_hook():
	if get_chance(25): target.add_buff('bleed', 3)
