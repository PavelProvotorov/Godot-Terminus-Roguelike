extends Node2D

onready var TILESET = load("res://resources/tilesets/tileset_deco_3.tres")
onready var _level = $Level

func _ready():
	Events.connect("level_generation_complete", self, "_on_level_generation_complete")
	_level.set_tileset(TILESET)
	_level.generate_level(false)

func _on_level_generation_complete(level:Level) -> void:
	Events.emit_signal("change_music", Resources.music_1)
