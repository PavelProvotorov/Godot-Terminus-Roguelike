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
	
	if _utility.get_chance(skip_chance):
		print("AMBUSH - SKIP")
		return false
	
	if _entity.path.size() != 3:
		return false
	
	if close_in and enemies.size() >= pack_size:
		print("AMBUSH - PACK")
		return false
	
	if not _entity.target_in_sight():
		print("AMBUSH")
		return true
	return false
	
func _handler() -> void:
	._handler()
