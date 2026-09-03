extends Enemy2D

var max_spawn_count:int = 4
var spawn_count:int = 0

func _ready():
	behaviours = [
		MeleeBehaviour.new(self, {
			"post_hook": funcref(self, "post_melee")
		}),
		SpawnBehaviour.new(self, {
			"minion": Resources.debug_vermin,
			"minion_count": 1,
			"minion_reservoir": 4,
			"spawn_chance": 25,
		})
	]
	attack_range = 1
	melee_damage = 2
	health = 4

func post_melee():
	if get_chance(50): 
		target.add_buff('blindness', 3)
		target.add_buff('bleed', 3)
