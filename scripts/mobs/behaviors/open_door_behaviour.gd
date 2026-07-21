extends BaseBehaviour
class_name OpenDoorBehaviour

func _init(entity:EntityAI, config:Dictionary).(entity, config):
	pass

func check() -> bool:
	if _entity.get_nearby_doors().size() > 0:
		print("OPEN DOOR")
		return true
	return false
	
func _handler() -> void:
	var nearby_doors:Array = _entity.get_nearby_doors()
	var door:Vector2 = nearby_doors.pick_random()
	_entity.level.open_door(door)
