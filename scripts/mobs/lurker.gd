extends Enemy2D

func _ready():
	behaviours = [
		AmbushBehaviour.new(self, {
			"close_in": true,
		}),
		MeleeBehaviour.new(self, {}),
		MoveBehaviour.new(self, {}),
	]
	attack_range = 1
	melee_damage = 2
	health = 4
	speed = 1
