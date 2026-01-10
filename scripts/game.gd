extends Node2D

onready var _viewport = $ViewportContainer/Viewport
onready var _audio:Audio2D = Audio2D.new()
var current_level = 0

func _ready():
	Events.connect("game_started", self, "_on_game_started")
	Events.connect("level_descended", self, "_on_level_descended")

func _on_game_started():
	load_next_level()

func _on_level_descended():
	_audio.play_global_sound(Resources.SOUNDS.descend)
	var config = Resources.level_configuration
	var current_depth = Global.get_depth()
	var player = Global.get_player()
	var level = Global.get_level()
	Global.set_depth(current_depth + 1)
	
	player.get_parent().remove_child(player)
	_viewport.remove_child(level.get_parent())
	level.get_parent().queue_free()
	
	load_next_level()

func load_next_level():
	var config = Resources.level_configuration
	var current_depth = Global.get_depth()
	var next_scene:PackedScene = config.get(current_depth, 0).get('scene', Resources.factory_scene)
	print("LEVEL DEPTH IS: ", Global.get_depth())
	_viewport.add_child(next_scene.instance())
	

