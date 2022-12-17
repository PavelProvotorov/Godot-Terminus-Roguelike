extends Node2D
class_name Buff2D

onready var grid_size = Global.grid_size

var buff_owner
var buff_infinite:bool = false
var buff_duration:int = 0

# READY
#---------------------------------------------------------------------------------------
func _ready():
	pass

func get_idle_frame():
	yield(get_tree(),"idle_frame")
