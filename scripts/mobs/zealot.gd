extends Enemy2D

func _ready():
	behaviours = [
		MeleeBehaviour.new(self, {}),
		MoveBehaviour.new(self, {}),
		OpenDoorBehaviour.new(self, {}),
		WanderBehaviour.new(self, {}),
	]
	attack_range = 1
	health = 4
	melee_damage = 2
