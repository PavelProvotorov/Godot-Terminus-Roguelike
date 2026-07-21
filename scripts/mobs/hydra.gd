extends Enemy2D

func _ready():
	behaviours = [
		FleeBehaviour.new(self, {
			"health_threshold": 0,
			"flee_when_close": true,
			"skip_chance": 25,
		}),
		AmbushBehaviour.new(self, {}),
		RangedBehaviour.new(self, {
			"post_hook": funcref(self, "post_ranged"),
		}),
		MeleeBehaviour.new(self, {
			"post_hook": funcref(self, "post_melee"),
		}),
		MoveBehaviour.new(self, {}),
	]
	attack_range = 2
	ranged_damage = 1
	melee_damage = 1
	health = 3
	speed = 1

func post_ranged():
	if get_chance(50): 
		target.add_buff('poison', 6)

func post_melee():
	if get_chance(25): 
		target.add_buff('poison', 6)
