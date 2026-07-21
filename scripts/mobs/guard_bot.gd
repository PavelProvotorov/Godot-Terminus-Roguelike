extends Enemy2D

func _ready():
	behaviours = [
		FleeBehaviour.new(self, {
			"health_threshold": 0,
			"flee_when_close": true,
			"skip_chance": 25,
		}),
		AmbushBehaviour.new(self, {}),
		RangedBehaviour.new(self, {}),
		MeleeBehaviour.new(self, {}),
		MoveBehaviour.new(self, {}),
		OpenDoorBehaviour.new(self, {}),
		WanderBehaviour.new(self, {}),
	]
	attack_range = 2
	health = 4
	melee_damage = 1
	ranged_damage = 1
	visibility = 5
