extends Enemy2D

func _ready():
	behaviours = [
		MeleeBehaviour.new(self, {}),
		MoveBehaviour.new(self, {}),
		WanderBehaviour.new(self, {}),
	]
	attack_range = 1
	health = 6
	melee_damage = 3

func _turn_started_hook():
	
	if health <= 2:
		add_buff('strength', 10, true)
