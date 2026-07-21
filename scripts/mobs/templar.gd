extends Enemy2D

func _ready():
	behaviours = [
		MeleeBehaviour.new(self, {
			"post_hook": funcref(self, "post_melee")
		}),
		MoveBehaviour.new(self, {}),
	]
	attack_range = 1
	health = 5
	melee_damage = 2
	
func post_melee():
	if get_chance(25): target.add_buff('bleed', 3)
