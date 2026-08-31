extends Enemy2D

func _ready():
	behaviours = [
		MeleeBehaviour.new(self, {}),
		MoveBehaviour.new(self, {}),
		OpenDoorBehaviour.new(self, {}),
		WanderBehaviour.new(self, {}),
	]
	blood = Blood.COLOUR.GREY
	attack_range = 1
	health = 4
	melee_damage = 2
