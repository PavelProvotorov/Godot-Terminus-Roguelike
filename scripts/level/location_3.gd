extends Node2D

onready var TILESET = load("res://resources/tilesets/tileset_deco_3.tres")
onready var _level = $Level

func _ready():
	Events.connect("level_generation_complete", self, "_on_level_generation_complete")
	_level.set_tileset(TILESET)
	_level.furniture = [
		{
			"object": Resources.obj_corner_vent_1,
			"solid": true,
			"cells": [
				Vector2(0, 0),
				Vector2(0, 1),
				Vector2(2, 0),
			]
		},
		{
			"object": Resources.obj_corner_vent_2,
			"solid": true,
			"cells": [
				Vector2(0, 2),
				Vector2(2, 2),
				Vector2(2, 1),
			]
		},
		{
			"object": Resources.obj_corner_vent_3,
			"solid": true,
			"cells": [
				Vector2(0, 0),
				Vector2(0, 2),
				Vector2(1, 2),
			]
		},
		{
			"object": Resources.obj_corner_vent_4,
			"solid": true,
			"cells": [
				Vector2(1, 0),
				Vector2(2, 0),
				Vector2(2, 2),
			]
		},
		{
			"object": Resources.obj_generator,
			"solid": false,
			"cells": [
				Vector2(0, 0),
				Vector2(1, 0),
				Vector2(2, 0),
				Vector2(0, 1),
				Vector2(1, 1),
				Vector2(2, 1),
			]
		},
		{
			"object": Resources.obj_power_relay,
			"solid": false,
			"cells": [
				Vector2(0, 0),
				Vector2(1, 0),
				Vector2(2, 0)
			]
		}
	]
	_level.generate_level(false)

func _on_level_generation_complete(level:Level) -> void:
	Events.emit_signal("change_music", Resources.music_1)
