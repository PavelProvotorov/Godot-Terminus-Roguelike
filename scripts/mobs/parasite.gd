extends Enemy2D

func _ready():
	behaviours = [
		MeleeBehaviour.new(self, {}),
		MoveBehaviour.new(self, {}),
	]
	attack_range = 1
	melee_damage = 1
	health = 2
	speed = 2
