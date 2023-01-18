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
	Global.LEVEL.target_entity = Global.NODE_PLAYER
	Global.LEVEL.target_entity.player_to_default()
	
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
	return level_instance

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

func level_change(next_level:String):
	current_level = Global.LEVEL
	
	# Prevent Player action while level loads
	Global.game_state_manager(Global.GAME_STATE_LIST.STATE_PLAYER_TURN)
	
	#Fade in screen
	Global.NODE_GUI_TRANSITION.transition_in(3)
	yield(Global.NODE_GUI_TRANSITION.NODE_ANIMATION_PLAYER,"animation_finished")
	yield(self.get_idle_frame(),"completed")
	
	# Switch player between levels
	level_switch_player(current_level,next_level)
	yield(self.get_idle_frame(),"completed")
	
	#Fade out screen
	Global.NODE_GUI_TRANSITION.transition_out(3)
	yield(Global.NODE_GUI_TRANSITION.NODE_ANIMATION_PLAYER,"animation_finished")
	yield(self.get_idle_frame(),"completed")

	Global.game_state_manager(Global.GAME_STATE_LIST.STATE_PLAYER_TURN)
	pass

func level_switch_player(current_level,next_level):
	# Delete the current level
	Global.LEVEL_LAYER_LOGIC.remove_child(Global.NODE_PLAYER)
	current_level.visible = false
	Global.NODE_MAIN.remove_child(current_level)
	current_level.queue_free()
	yield(self.get_idle_frame(),"completed")
	
	# Load the next level
	level_load(next_level)
	Global.LEVEL_LAYER_LOGIC.add_child(Global.NODE_PLAYER)
	Global.NODE_PLAYER.position = (Global.LEVEL_ENTRANCE * grid_size)
	yield(self.get_idle_frame(),"completed")
	
	Global.LEVEL_LAYER_LOGIC.fog_update()
	pass

func level_game_over():
	#Reset level counter
	Global.LEVEL_COUNT = 1
	
	#Delete current player instance
	Global.NODE_PLAYER.queue_free()
	yield(self.get_idle_frame(),"completed")
	
	#Fade in screen
	Global.NODE_GUI_TRANSITION.transition_in(1)
	yield(Global.NODE_GUI_TRANSITION.NODE_ANIMATION_PLAYER,"animation_finished")
	yield(self.get_idle_frame(),"completed")

	#Add new player instance
	Global.NODE_PLAYER = Global.LEVEL.level_mob_spawn("Player",Global.LEVEL_ENTRANCE)
	Global.LEVEL.target_entity = Global.NODE_PLAYER
	Global.NODE_PLAYER.player_to_default()
	yield(self.get_idle_frame(),"completed")
	
	#Switch player to new Level
	Global.NODE_MAIN.level_switch_player(Global.LEVEL,"Level_1")
	yield(self.get_idle_frame(),"completed")
	
	Global.NODE_MENU.current_button.grab_focus()
	Global.NODE_MENU.NODE_BACKGROUND.visible = true
	Global.NODE_MENU.NODE_VBOX_CONTAINER.visible = true
	Global.NODE_GUI_LAYER_MAIN.visible = false
	yield(self.get_idle_frame(),"completed")
	
	#Fade out screen
	Global.NODE_GUI_TRANSITION.transition_out(1)
	yield(Global.NODE_GUI_TRANSITION.NODE_ANIMATION_PLAYER,"animation_finished")
	yield(self.get_idle_frame(),"completed")

func util_chance(percentage):
	randomize()
	if randi() % 100 <= percentage:  
		return true
	else:                     
		return false

func get_idle_frame():
	yield(get_tree(),"idle_frame")
	pass
