extends BaseBehaviour
class_name MoveBehaviour

func _init(entity:EntityAI, config:Dictionary).(entity, config):
	pass

func check() -> bool:
	if not _entity.is_active():
		return false
		
	if _entity.path.size() > 2 and _entity.is_active():
		print("MOVE")
		return true
		
	return false
	
func _handler() -> void:
	var start = _entity.position
	var end = _entity.path[1] * GRID_SIZE
	
	_entity.set_sprite_direction(start, end)
	
	_audio.play_sound(start, Resources.SOUNDS.move)
	
	if not _entity.is_invisible() and not _entity.is_path_hidden(start / GRID_SIZE, end / GRID_SIZE):
		yield(_entity.play_move_animation(start, end), 'completed')
	
	_entity.update_position(end)
