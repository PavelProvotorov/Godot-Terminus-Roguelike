extends StaticBody2D
class_name Item2D

onready var NODE_SPRITE = $Sprite
onready var count

# READY
#---------------------------------------------------------------------------------------
func _ready():
	pass
	
func item_remove():
	Global.LEVEL_LAYER_LOGIC.remove_child(self)
	pass

func get_idle_frame():
	yield(get_tree(),"idle_frame")
