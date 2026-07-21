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
		MeleeBehaviour.new(self, {}),
		RallyBehaviour.new(self, {}),
		MoveBehaviour.new(self, {}),
	]
	attack_range = 1
	melee_damage = 1
	health = 1
	speed = 1
