extends BaseBehaviour
class_name WanderBehaviour

func _init(entity:EntityAI, config:Dictionary).(entity, config):
	pass

func check() -> bool:
	if not _entity.is_active():
		print("WANDER")
		return true
	return false
	
func _handler() -> void:
	var nearby_cells:Array = _entity.get_nearby_cells()
	
	if nearby_cells.size() > 1:
		nearby_cells.erase(_entity.previous_position / GRID_SIZE)
	
	if nearby_cells.size() > 0:
		var cell = nearby_cells.pick_random()
		var start = _entity.position / GRID_SIZE
		var end = cell
		
		_entity.set_sprite_direction(start * GRID_SIZE, end * GRID_SIZE)
		
		if not _entity.is_invisible() and not _entity.is_path_hidden(start, end):
			yield(_entity.play_move_animation(start * GRID_SIZE, end * GRID_SIZE), 'completed')

		_entity.update_position(end * GRID_SIZE)
