extends Enemy2D

func _ready():
	behaviours = [
#		TestBehaviour.new(self, {}),
		MeleeBehaviour.new(self, {}),
#		RallyBehaviour.new(self, {}),
#		MoveBehaviour.new(self, {}),
#		WanderBehaviour.new(self, {})
	]
	attack_range = 2
	health = 3
	melee_damage = 1
