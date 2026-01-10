extends Node
class_name Audio2D

const sfx_move = preload("res://sfx/move.ogg")
onready var level setget set_level, get_level

func play_sound(pos:Vector2, sfx:AudioStream) -> void:
	var instance:Sfx2D = Resources.sfx_2D.instance()
	instance.position = pos
	instance.set_stream(sfx)
	self.level.add_child(instance)
	
func play_global_sound(sfx:AudioStream) -> void:
	var instance:Sfx = Resources.sfx.instance()
	instance.stream = sfx
	Global.get_root().add_child(instance)

func get_level():
	return Global.get_level()
	
func set_level(level):
	return level
