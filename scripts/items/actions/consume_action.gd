extends ItemAction
class_name ConsumeItem

func _init(item:Item, config:Dictionary).(item, config):
	pass
	
func check():
	var handler = _utility.call_funcref(_config.get("on_check", null))
	if handler is GDScriptFunctionState:
		yield(handler, "completed")
	return handler
	
func _handler() -> void:
	var _entity:Entity2D = _item._entity
	var handler = _utility.call_funcref(_config.get("on_use", null))
	if handler is GDScriptFunctionState:
		yield(handler, "completed")
	_item.remove_item()
	
	if _config.get("use_turn", true):
		_entity.end_turn()
	else:
		_entity.emit_signal("start_turn")
