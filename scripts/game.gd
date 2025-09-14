extends Node2D

onready var _viewport = $ViewportContainer/Viewport
var current_level = 0

func _ready():
	Events.connect("game_started", self, "_on_game_started")
	Events.connect("level_descended", self, "_on_level_descended")

func _on_game_started():
	_viewport.add_child(Resources.factory_scene.instance())

func _on_level_descended():
	var player = Global.get_player()
	var level = Global.get_level()
	
	player.get_parent().remove_child(player)
	_viewport.remove_child(level.get_parent())
	level.get_parent().queue_free()
	
	_viewport.add_child(Resources.factory_scene.instance())
	
