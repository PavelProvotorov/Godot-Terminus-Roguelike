extends Enemy2D

var max_spawn_count:int = 4
var spawn_count:int = 0

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.FLEE,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.RALLY,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 1
	melee_damage = 3
	health = 7
	
func _post_movement_hook() -> void:
	var nearby_cells = get_nearby_cells()
	
	if nearby_cells.size() > 0 \
		and get_chance(45) \
		and spawn_count < max_spawn_count \
		:
		spawn_count += 1
		var cell = nearby_cells.pick_random()
		var instance = Resources.debug_goo.instance()
		yield(minion_spawn_and_move(
			instance,
			position,
			cell * grid_size
			), 
		"completed"
		)

func _post_flee_hook() -> void:
	self.add_buff('regeneration', true)

func get_flee_behaviour_config() -> Dictionary:
	return {
		"health_threshold": 2,
		"flee_when_close": false,
		"skip_chance": 0,
	}
