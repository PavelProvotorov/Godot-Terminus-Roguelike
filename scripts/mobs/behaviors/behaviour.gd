extends Node
class_name BaseBehaviour

var GRID_SIZE = Global.GRID_SIZE
var _audio:Audio2D = Audio2D.new()
var _utility:Utility = Utility.new()
var _config:Dictionary
var _entity:EntityAI

func _init(entity:EntityAI, config:Dictionary):
	self._entity = entity
	self._config = config
		
func _handler() -> void:
	pass
	
func check() -> bool:
	return false

func execute() -> void:
	var pre_hook = _utility.call_lifecycle_hook(_config.get("pre_hook", null))
	if pre_hook is GDScriptFunctionState:
		yield(pre_hook, "completed")
	
	var handler = _handler()
	if handler is GDScriptFunctionState:
		yield(handler, "completed")
		
	var post_hook = _utility.call_lifecycle_hook(_config.get("post_hook", null))
	if post_hook is GDScriptFunctionState: 
		yield(post_hook, "completed")
	
	_entity.end_turn()
