extends Node2D

var grid_size = Global.grid_size

var next_level
var current_level
var player_position

# READY
#---------------------------------------------------------------------------------------
func _ready():
	level_load("Level_1")
	yield(get_tree(),"idle_frame")
	Global.LEVEL.level_mob_spawn("Player",Global.LEVEL_ENTRANCE)
#	Global.LEVEL.level_mob_spawn("Grunt",Global.LEVEL_EXIT)
	Global.LEVEL.target_entity = Global.NODE_PLAYER
	
#	Global.NODE_PLAYER.buff_add("Speed",Global.NODE_PLAYER)
	yield(get_tree(),"idle_frame")
	Global.LEVEL_LAYER_LOGIC.fog_update()
	yield(get_tree(),"idle_frame")

func level_load(level_name:String):
	var level_data = load("res://Scenes/%s.tscn" %level_name)
	var level_instance = level_data.instance()
	add_child(level_instance)
	# Temporary bug fix
	Global.LEVEL_LAYER_LOGIC.set_cellv(Global.LEVEL_ENTRANCE,Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_ENTRANCE)
	Global.LEVEL_LAYER_LOGIC.set_cellv(Global.LEVEL_EXIT,Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_EXIT)
	pass

func level_select():
	Global.LEVEL_COUNT += 1
	var level_list = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("LEVELS").keys()
	for level in level_list:
		randomize()
		var level_name = level_list[randi() % level_list.size()]
		var level_chance = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("LEVELS")[level_name]
		var spawn_chance = util_chance(level_chance)
		if spawn_chance == true:
			level_change(level_name)
	pass

func level_change(level_name:String):
	current_level = Global.LEVEL
	
	# Prevent Player action while level loads
	Global.game_state_manager(Global.GAME_STATE_LIST.STATE_PLAYER_TURN)
	
	# Delete the current level
	Global.LEVEL_LAYER_LOGIC.remove_child(Global.NODE_PLAYER)
	current_level.visible = false
	Global.NODE_MAIN.remove_child(current_level)
	current_level.queue_free()
#	print("test 1")
#	yield(self.get_idle_frame(),"completed")
	
	# Load the next level
	level_load(level_name)
#	print("test 2")
#	yield(self.get_idle_frame(),"completed")
	Global.LEVEL_LAYER_LOGIC.add_child(Global.NODE_PLAYER)
	Global.NODE_PLAYER.position = (Global.LEVEL_ENTRANCE * grid_size)
#	print("test 3")
	yield(self.get_idle_frame(),"completed")

	Global.LEVEL_LAYER_LOGIC.fog_update()
	Global.game_state_manager(Global.GAME_STATE_LIST.STATE_PLAYER_TURN)
	pass

func util_chance(percentage):
	randomize()
	if randi() % 100 <= percentage:  
		return true
	else:                     
		return false

func get_idle_frame():
	yield(get_tree(),"idle_frame")
	pass
