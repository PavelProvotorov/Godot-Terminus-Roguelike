extends Enemy2D

func _ready():
	behaviours = [
		SpawnBehaviour.new(self, {
			"minion": Resources.debug_maggot,
			"minion_count": 4,
			"animation": "burst",
			"spawn_chance": 100,
			"die": true,
		})
	]
	blood = Blood.COLOUR.WHITE
	attack_range = 0
	melee_damage = 0
