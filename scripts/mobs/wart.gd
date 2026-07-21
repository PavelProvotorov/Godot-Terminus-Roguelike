extends Enemy2D

func _ready():
	behaviours = [
		MeleeBehaviour.new(self, {}),
		RallyBehaviour.new(self, {}),
		MoveBehaviour.new(self, {}),
		WanderBehaviour.new(self, {}),
	]
	attack_range = 1
	health = 3
	melee_damage = 1
