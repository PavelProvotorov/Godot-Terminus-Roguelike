extends ItemAction
class_name MeleeItem

func _init(item:Item, config:Dictionary).(item, config):
	pass
	
func check() -> bool:
	var _entity:Entity2D = _item._entity
	if not _entity:
		return false
	return true
	
func _handler():
	var _entity:Entity2D = _item._entity
	_entity.connect("melee_successful", self, "_callback", [], CONNECT_ONESHOT)

func _callback(success:bool, collider:Entity2D) -> void:
	if not success:
		return

	var _entity:Entity2D = _item._entity
	var origin_pos = _entity.position
	var impact_pos = collider.position
	
	var on_use_hook = _utility.call_funcref(_config.get("on_use", null), [
		origin_pos, 
		impact_pos
	])
	if on_use_hook is GDScriptFunctionState: yield(on_use_hook, "completed")
	
	var targets = _utility.call_funcref(_config.get("get_targets", null), [
		origin_pos,
		impact_pos
	])
	
	for target in targets:
		var damage = _utility.call_funcref(_config.get("get_damage", null), [
			origin_pos.distance_to(impact_pos) / 8,
			target.position.distance_to(impact_pos) / 8,
		])
		_audio.play_sound(_entity.position, _config.get("sfx", Resources.SOUNDS.hit_0))
		var received_damage:int = target.receive_damage(damage)
		
		var on_damage_hook = _utility.call_funcref(_config.get("on_damage", null), [
			target,
			target.get_health() > 0,
			received_damage,
		])
		if on_damage_hook is GDScriptFunctionState: yield(on_damage_hook, "completed")
	
	yield(_entity.play_melee_animation(origin_pos, impact_pos), 'completed')
		
	_entity.end_turn()
