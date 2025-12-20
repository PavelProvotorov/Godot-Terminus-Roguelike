extends Node2D

onready var TILESET = load("res://resources/tilesets/tileset_deco_1.tres")
onready var _level = $Level

func _ready():
	_level.furniture = [
		{
			"object": Resources.obj_factory,
			"cells": [
				Vector2(0, 0),
				Vector2(1, 0),
				Vector2(0, 1),
				Vector2(1, 1)
			]
		},
		{
			"object": Resources.obj_cistern,
			"cells": [
				Vector2(0, 0),
				Vector2(1, 0),
				Vector2(0, 1),
				Vector2(1, 1)
			]
		},
	]
	_level.set_tileset(TILESET)
	_level.generate_level()
