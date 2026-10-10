extends BaseBehaviour
class_name AmbushBehaviour

func _init(entity:EntityAI, config:Dictionary).(entity, config):
	pass

func check() -> bool:
	if not _entity.is_active():
		return false
	
	var enemies:Array = _entity.enemies_near_target()
	var close_in:bool = _config.get("close_in", false)
	var pack_size:int = _config.get("pack_size", 2)
	var skip_chance:int = _config.get("skip_chance", 0)
	
	if _entity.target.is_stunned():
		return false
	
	if Utility.get_chance(skip_chance):
		Utility.print_debug("AMBUSH - SKIP", _entity)
		return false
	
	if _entity.path.size() != 3:
		return false
	
	if close_in and enemies.size() >= pack_size:
		Utility.print_debug("AMBUSH - PACK", _entity)
		return false
	
	if not _entity.target_in_sight():
		Utility.print_debug("AMBUSH", _entity)
		return true
	return false
	
func _handler() -> void:
	._handler()
