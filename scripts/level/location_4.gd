extends Node2D

onready var TILESET = load("res://resources/tilesets/tileset_deco_4.tres")
onready var _level = $Level

func _ready():
	_level.light_level = 4
	_level.set_tileset(TILESET)
	_level.generate_level(false)
