extends Node

onready var config = ConfigFile.new()
const file_path = "user://config.cfg"
const SECTION = {
	PLAYER = 'player'
}

func _ready():
	
	if config.load(file_path) != OK:
		print("CONFIG DOES NOT EXIST, CREATING FILE AT ", file_path)
		set_player_body(get_player_body())
		set_player_head(get_player_head())
		config.save(file_path)

	print("The player head is: ", get_player_head())
	print("The player body is: ", get_player_body())

func get_player_head() -> int:
	return config.get_value(SECTION.PLAYER, 'head', 0)

func set_player_head(value:int) -> void:
	config.set_value(SECTION.PLAYER, 'head', value)
	config.save(file_path)

func get_player_body() -> int:
	return config.get_value(SECTION.PLAYER, 'body', 0)

func set_player_body(value:int) -> void:
	config.set_value(SECTION.PLAYER, 'body', value)
	config.save(file_path)
