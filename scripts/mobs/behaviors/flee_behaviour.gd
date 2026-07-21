extends BaseBehaviour
class_name FleeBehaviour

func _init(entity:EntityAI, config:Dictionary).(entity, config):
	pass

func check() -> bool:
	if not _entity.is_active():
		return false
	
	var health_threshold:int =  _config.get("health_threshold", 0)
	var flee_when_close:int = _config.get("flee_when_close", false)
	var skip_chance:int = _config.get("skip_chance", 0)
		
	if _utility.get_chance(skip_chance):
		print("FLEE - SKIP")
		return false
	
	if _entity.get_nearby_cells().size() == 0:
		return false
	
	if _entity.health <= health_threshold:
		print("FLEE - LOW HEALTH")
		return true
	
	if flee_when_close and _entity.path.size() == 2 and _entity.target_in_sight():
		print("FLEE")
		return true
		
	return false
	
func _handler() -> void:
	var nearby_cells:Array = _entity.get_nearby_cells()
	var sorted_cells = nearby_cells
	sorted_cells.sort_custom(_entity, "sort_by_distance")
	
	if sorted_cells.size() > 0:
		
		var cell = sorted_cells[0]
		var start = _entity.position / GRID_SIZE
		var end = cell
		
		if not _entity.is_invisible() and not _entity.is_path_hidden(start, end):
			yield(_entity.play_move_animation(start * GRID_SIZE, end * GRID_SIZE), 'completed')
		
		_entity.update_position(end * GRID_SIZE)
