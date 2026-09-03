extends Enemy2D

func _ready():
	behaviours = [
		FleeBehaviour.new(self, {
			"health_threshold": 0,
			"flee_when_close": true,
			"skip_chance": 75,
		}),
		AmbushBehaviour.new(self, {
			"close_in": true,
		}),
		MeleeBehaviour.new(self, {
			"post_hook": funcref(self, "post_melee")
		}),
		RallyBehaviour.new(self, {}),
		MoveBehaviour.new(self, {}),
	]
	attack_range = 1
	melee_damage = 1
	health = 1
	speed = 1

func post_melee():
	if get_chance(10): target.add_buff('bleed', 2)
