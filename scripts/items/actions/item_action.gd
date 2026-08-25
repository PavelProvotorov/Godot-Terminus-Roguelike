extends Node
class_name ItemAction

var _utility:Utility = Utility.new()
var _audio:Audio2D = Audio2D.new()
var _config:Dictionary
var key:String
var _item:Item

func _init(item:Item, config:Dictionary):
	self._config = config
	self._item = item
		
func _handler() -> void:
	pass
	
func get_key() -> String:
	return self.key
	
func check() -> bool:
	return false

func execute() -> void:
	var handler = _handler()
	if handler is GDScriptFunctionState:
		yield(handler, "completed")
