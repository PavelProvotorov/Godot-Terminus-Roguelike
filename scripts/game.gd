extends Node2D

onready var _viewport = $ViewportContainer/Viewport
var current_level = 0

func _ready():
	Events.connect("game_started", self, "_on_game_started")

func _on_game_started():
	_viewport.add_child(Resources.factory_scene.instance())
