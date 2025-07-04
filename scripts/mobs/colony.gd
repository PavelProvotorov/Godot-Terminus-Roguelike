extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.SPAWNER
	]
	attack_range = 2
	melee_damage = 1

func handle_spawning(data: Dictionary) -> void:
	var nearby_cells = get_nearby_cells()
	
	if nearby_cells.size() != 0:
		for cell in nearby_cells:
			var instance = Resources.debug_maggot.instance()
			yield(minion_spawn_and_move(
				instance,
				position,
				cell * grid_size
				), 
			"completed"
			)
		handle_death()
	end_turn()
