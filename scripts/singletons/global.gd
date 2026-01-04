extends Node

onready var level:Level
onready var player:Player
onready var depth:int = 3

func _init():
	pass

func _ready():
	set_player(Resources.player.instance())

func set_depth(value:int) -> void:
	depth = value

func get_depth() -> int:
	return depth

func set_player(player:Player) -> void:
	self.player = player
	
func get_player() -> Player:
	return self.player

func set_level(level:Level) -> void:
	self.level = level

func get_level() -> Level:
	return level
