extends Enemy2D

var max_spawn_count:int = 4
var spawn_count:int = 0

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 1
	melee_damage = 3
	health = 6
	
func _post_movement_hook() -> void:
	var nearby_cells = get_nearby_cells()
	
	if nearby_cells.size() > 0 \
		and get_chance(25) \
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
