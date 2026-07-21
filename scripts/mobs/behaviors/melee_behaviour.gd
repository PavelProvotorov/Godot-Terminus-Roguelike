extends BaseBehaviour
class_name MeleeBehaviour

func _init(entity:EntityAI, config:Dictionary).(entity, config):
	pass

func check() -> bool:
	if not _entity.is_active():
		return false
		
	if _entity.path.size() == 2 and _entity.target_in_sight():
		print("MELEE")
		return true
		
	return false
	
func _handler() -> void:
	var start = _entity.position
	var end = _entity.path[1] * GRID_SIZE
	var target = _entity.target
	
	_entity.set_sprite_direction(start, end)
	target.receive_damage(_entity.get_melee_damage())
	
	if not _entity.is_path_hidden(start / GRID_SIZE, end / GRID_SIZE):
		yield(_entity.play_melee_animation(start, end), 'completed')
