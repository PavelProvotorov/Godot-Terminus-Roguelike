extends BaseBehaviour
class_name RangedBehaviour

func _init(entity:EntityAI, config:Dictionary).(entity, config):
	pass

func check() -> bool:
	if not _entity.is_active():
		return false
		
	if (_entity.path.size() > 2) \
	and _entity.target_in_range() \
	and _entity.target_in_sight() \
	and not _entity.target_is_blocked(_entity.position, _entity.target.position):
		print("RANGED")
		return true
	return false
	
func _handler() -> void:
	var start = _entity.position
	var end = _entity.path[1] * GRID_SIZE
	var target = _entity.target
	
	_entity.set_sprite_direction(start, end)
	target.receive_damage(_entity.ranged_damage)
	
	if not _entity.is_path_hidden(start / GRID_SIZE, end / GRID_SIZE):
		yield(_entity.play_ranged_animation(start, end), 'completed')
