extends ItemAction
class_name ShootItem

func _init(item:Item, config:Dictionary).(item, config):
	pass
	
func check() -> bool:
	var _entity:Entity2D = _item._entity
	
	if not _entity:
		return false
	
	if not _has_ammo():
		return false
		
	return _entity.get_targets_in_range(_config.get("range", 0)).size() > 0
	
func _handler():
	var _entity:Entity2D = _item._entity
	_entity.state_bind('RANGED', self, "_callback", {
		'range': _config.get("range", 0),
	})

func _callback(success:bool, direction:Vector2) -> void:
	if not success:
		return
		
	var on_use_hook = _utility.call_funcref(_config.get("on_use", null), [])
	if on_use_hook is GDScriptFunctionState: yield(on_use_hook, "completed")
	
	_shoot(direction)

func _shoot(direction:Vector2):
	var _entity:Entity2D = _item._entity
	var shots:int = _config.get("shots", 0)
	var shot_range:int = min(_entity.visibility, _config.get("range", 0))
	var ammo_consumption:int = _config.get("consumption", 0)
	
	for idx in shots:
		
		if not _has_ammo():
			break
			
		var collider = _entity.cast_in_direction(direction, shot_range)
		if not collider or not collider is Enemy2D:
			return _entity.emit_signal("start_turn")
			
		var impact_pos = collider.position
		_entity.ammo -= ammo_consumption
		
		var targets = _utility.call_funcref(_config.get("get_targets", null), [
			_entity.position,
			impact_pos
		])
		for target in targets:
			var damage = _utility.call_funcref(_config.get("get_damage", null), [
				_entity.position.distance_to(impact_pos) / 8,
				target.position.distance_to(impact_pos) / 8,
			])
			_audio.play_sound(_entity.position, _config.get("sfx", Resources.SOUNDS.shot_0))
			
			var received_damage:int = target.receive_damage(damage)
			
			var on_damage_hook = _utility.call_funcref(_config.get("on_damage", null), [
				target,
				target.get_health() > 0,
				received_damage,
			])
			if on_damage_hook is GDScriptFunctionState: yield(on_damage_hook, "completed")
		
		var start = _entity.position
		var end = (start - (-direction))
		yield(_entity.play_ranged_animation(start, end), 'completed')
		
	_entity.end_turn()
	
func _has_ammo() -> bool:
	var _entity:Entity2D = _item._entity
	var ammo_consumption:int = _config.get("consumption", 0)
		
	if _entity.ammo == 0:
		return false
		
	if _entity.ammo - ammo_consumption < 0:
		return false
		
	return true
