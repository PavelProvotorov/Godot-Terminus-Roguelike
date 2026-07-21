extends Enemy2D

var max_spawn_count:int = 4
var spawn_count:int = 0

func _ready():
	behaviours = [
		FleeBehaviour.new(self, {
			"health_threshold": 2,
			"flee_when_close": false,
			"skip_chance": 0,
			"post_hook": funcref(self, "post_flee"),
		}),
		MeleeBehaviour.new(self, {}),
		RallyBehaviour.new(self, {}),
		MoveBehaviour.new(self, {
			"post_hook": funcref(self, "post_move")
		}),
	]
	attack_range = 1
	melee_damage = 3
	health = 7
	
func post_move() -> void:
	var nearby_cells = get_nearby_cells()
	
	if nearby_cells.size() > 0 \
		and get_chance(45) \
		and spawn_count < max_spawn_count \
		:
		spawn_count += 1
		var cell = nearby_cells.pick_random()
		var instance = Resources.debug_goo.instance()
		print("SPAWN GOO - START: ", self)
		yield(minion_spawn_and_move(
			instance,
			position,
			cell * grid_size
			), 
		"completed"
		)
		print("SPAWN GOO - END: ", self)

func post_flee() -> void:
	self.add_buff('regeneration', 3, true)
