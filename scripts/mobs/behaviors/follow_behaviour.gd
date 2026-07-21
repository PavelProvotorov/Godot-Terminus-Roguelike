extends BaseBehaviour
class_name FollowBehaviour

func _init(entity:EntityAI, config:Dictionary).(entity, config):
	pass

func check() -> bool:
	var follower = _config.get("follower", null)
	
	if follower == null:
		print("FOLLOWER NULL")
		return false
	
	if not _entity.target_visible or _entity.path.size() >= 4:
		print("FOLLOW")
		return true
	return false
	
func _handler() -> void:
	var follower = _config.get("follower")
	var nearby_cells:Array = _entity.get_nearby_cells()
	var move_to_cell:Vector2  = _entity.position / GRID_SIZE
	var shortest_distance:int = round((_entity.position / GRID_SIZE).distance_to(follower.position / GRID_SIZE))
	
	if nearby_cells.size() > 0:
		
		for cell in nearby_cells:
			var distance = cell.distance_to(follower.position / GRID_SIZE)
			
			if distance < shortest_distance:
				shortest_distance = distance
				move_to_cell = cell
		
		if move_to_cell == _entity.position / GRID_SIZE and shortest_distance > 1:
			move_to_cell = nearby_cells.pick_random()
		
		var start = _entity.position / GRID_SIZE
		var end = move_to_cell
		
		_entity.set_sprite_direction(start * GRID_SIZE, end * GRID_SIZE)
		
		if not _entity.is_invisible() and not _entity.is_path_hidden(start, end):
			yield(_entity.play_move_animation(start * GRID_SIZE, end * GRID_SIZE), 'completed')
		
		_entity.update_position(end * GRID_SIZE)
