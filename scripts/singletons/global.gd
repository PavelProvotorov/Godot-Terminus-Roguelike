extends Node

onready var level:Level
onready var player:Player

func _init():
	Events.connect("level_generation_complete", self, "_on_level_generation_complete")

func _ready():
	set_player(Resources.player.instance())

func _on_level_generation_complete(level:Level) -> void:
	set_level(level)

func set_player(player:Player) -> void:
	self.player = player
	
func get_player() -> Player:
	return self.player

func set_level(level:Level) -> void:
	self.level = level

func get_level() -> Level:
	return level
