extends ItemAction
class_name ThrowItem

func _init(item:Item, config:Dictionary).(item, config):
	pass
	
func check() -> bool:
	var _entity:Entity2D = _item._entity
	if not _entity:
		return false
	return _entity.get_targets_in_range(_config.get("range", 0)).size() > 0
	
func _handler():
	var _entity:Entity2D = _item._entity
	_entity.state_bind('THROW', self, "_callback", {
		'range': _config.get("range", 0)
	})

func _callback(success:bool, collider:Enemy2D):
	var _entity:Entity2D = _item._entity
	
	if not success:
		return _entity.emit_signal("start_turn")
		
	var origin_pos = _entity.position
	var impact_pos = collider.position
	var direction = _entity.position.direction_to(impact_pos) * 8
	var targets = _utility.call_funcref(_config.get("get_targets", null), [
		_entity.position,
		impact_pos
	])
	
	var on_use_hook = _utility.call_funcref(_config.get("on_use", null), [origin_pos, impact_pos])
	if on_use_hook is GDScriptFunctionState:
		yield(on_use_hook, "completed")
	
	for target in targets:
		var damage = _utility.call_funcref(_config.get("get_damage", null), [
			_entity.position.distance_to(impact_pos) / 8,
			target.position.distance_to(impact_pos) / 8,
		])
		_audio.play_sound(impact_pos, _config.get("sfx", Resources.SOUNDS.explosion_0))
		target.receive_damage(damage)
		
		if target.get_health() > 0:
			var on_damage_hook = _utility.call_funcref(_config.get("on_damage", null), [target])
			if on_damage_hook is GDScriptFunctionState: yield(on_damage_hook, "completed")
	
	var start = origin_pos
	var end = (start - (-direction))
	_entity.set_inventory_animation()
	yield(_entity.play_ranged_animation(start, end), 'completed')
	
	_item.remove_item()
	_entity.end_turn()
