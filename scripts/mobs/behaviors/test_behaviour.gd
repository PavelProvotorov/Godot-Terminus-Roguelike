extends BaseBehaviour
class_name TestBehaviour

func _init(entity:EntityAI, config:Dictionary).(entity, config):
	pass

func check() -> bool:
	if not _entity.is_active():
		return false
		
	if _entity.path.size() > 2 and _entity.is_active() and not _entity.target_in_range():
		Utility.print_debug("TEST", _entity)
		return true
		
	return false
	
func _handler() -> void:
	
	var nearby_cells:Array = _entity.get_nearby_cells()
	var new_path = build_path_to_point(nearby_cells.pick_random())
	var next_cell
	
#	var nearby_cells:Array = _entity.get_nearby_cells()
#	nearby_cells.erase(_entity.path[1])
#	nearby_cells.erase(_entity.previous_position / GRID_SIZE)
#	nearby_cells.shuffle()
#	nearby_cells.sort_custom(self, "sort_by_distance")

	if new_path.size() > 2:
		var start = _entity.position
		var end = new_path[1] * GRID_SIZE
		
		_entity.set_sprite_direction(start, end)
		
		_audio.play_sound(start, Resources.SOUNDS.move)
		
		if not _entity.is_invisible() and not _entity.is_path_hidden(start / GRID_SIZE, end / GRID_SIZE):
			yield(_entity.play_move_animation(start, end), 'completed')
		
		_entity.update_position(end)
#		var cell = nearby_cells[0]
#
#		var start = _entity.position / GRID_SIZE
#		var end = cell
#
#		_entity.set_sprite_direction(start * GRID_SIZE, end * GRID_SIZE)
#
#		if not _entity.is_invisible() and not _entity.is_path_hidden(start, end):
#			yield(_entity.play_move_animation(start * GRID_SIZE, end * GRID_SIZE), 'completed')
#
#		_entity.update_position(end * GRID_SIZE)
		
func sort_by_distance(a, b) -> bool:
	var pos:Vector2 = _entity.target.position / GRID_SIZE
	return a.distance_to(pos) < b.distance_to(pos)

#func test() -> bool:
#	var self_pos = _entity.path[1] * GRID_SIZE
#	var target_pos = _entity.target.position
#	var direction = self_pos - target_pos
#	return (direction.x == 0 or direction.y == 0)
	
func build_path_to_point(point:Vector2) -> Array:
	var path = []
	
	print("The point is: ", point);
	
	_entity.level.set_pathfinding_points([], [point])
	path = (_entity.level.find_path(_entity.position, point * GRID_SIZE))
	_entity.level.set_pathfinding_points([point], [])
	
	return path
