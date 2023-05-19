extends CenterContainer

onready var grid_size = Global.grid_size
onready var current_button = $MenuContainer/Button1
onready var NODE_BACKGROUND = $Background
onready var NODE_MENU_CONTAINER = $MenuContainer
onready var NODE_SETTINGS_CONTAINER = $SettingsContainer
onready var NODE_ABOUT_CONTAINER = $AboutContainer
onready var NODE_STAT_CONTAINER = $StatContainer

func _ready():
	Global.NODE_MENU = self
	current_button.grab_focus()

func _input(event):
	if event is InputEventKey and NODE_MENU_CONTAINER.visible == false:
		if NODE_ABOUT_CONTAINER.visible or NODE_STAT_CONTAINER.visible:
			if Input.is_action_just_pressed("ui_accept",true):
				current_button = $MenuContainer/Button3
				#Fade in screen
				Global.NODE_GUI_TRANSITION.transition_in(1)

				NODE_MENU_CONTAINER.visible = true
				NODE_SETTINGS_CONTAINER.visible = false
				NODE_ABOUT_CONTAINER.visible = false
				NODE_STAT_CONTAINER.visible = false

				#Fade out screen
				Global.NODE_GUI_TRANSITION.transition_out(5)
				yield(Global.NODE_GUI_TRANSITION.NODE_ANIMATION_PLAYER,"animation_finished")
				Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_menu_move,Vector2(7,4))
				current_button.grab_focus()
				pass

func fill_stat_container():
	var content_node = $StatContainer/Content
	content_node.text = "Moves Done: {turns}\nDamage Dealt: {dealt}\nDamage Taken: {received}\nMobs Killed: {mobs}\nShots Fired: {shots}\nItems Used: {items}".format([
		["turns",Global.score_turns],
		["dealt",Global.score_damage_dealt],
		["received",Global.score_damage_received],
		["mobs",Global.score_mobs],
		["shots",Global.score_shots],
		["items",Global.score_items]
		])
	pass

# START BUTTON PRESSED
func _on_Button1_pressed():
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_menu_move,Global.NODE_PLAYER.position/grid_size)
	current_button = $MenuContainer/Button3
	current_button.grab_focus()
	
	#Fade in screen
	Global.NODE_GUI_TRANSITION.transition_in(1)
	
	NODE_BACKGROUND.visible = false
	NODE_MENU_CONTAINER.visible = false
	Global.NODE_GUI_LAYER_MAIN.visible = true
	
	#Fade out screen
	Global.NODE_GUI_TRANSITION.transition_out(2)
	
	Sound.music_spawn(Global.NODE_MUSIC,Data.LEVEL_DATA[Global.LEVEL_COUNT].get("SETTINGS")["Music"])
	Global.game_state_manager(Global.GAME_STATE_LIST.STATE_PLAYER_TURN)
	pass

func _on_Button2_pressed():
	#Fade in screen
	current_button = $SettingsContainer/ButtonFullScreen
	
	Global.NODE_GUI_TRANSITION.transition_in(1)
	
	NODE_MENU_CONTAINER.visible = false
	NODE_SETTINGS_CONTAINER.visible = true
	NODE_ABOUT_CONTAINER.visible = false
	NODE_STAT_CONTAINER.visible = false
	
	#Fade out screen
	Global.NODE_GUI_TRANSITION.transition_out(1)
	
	current_button.grab_focus()
	pass

func _on_Button3_pressed():
	#Fade in screen
	current_button = $MenuContainer/Button3
	
	Global.NODE_GUI_TRANSITION.transition_in(1)
	
	NODE_MENU_CONTAINER.visible = false
	NODE_SETTINGS_CONTAINER.visible = false
	NODE_ABOUT_CONTAINER.visible = true
	NODE_STAT_CONTAINER.visible = false
	
	#Fade out screen
	Global.NODE_GUI_TRANSITION.transition_out(1)
	pass

func _on_ButtonReturn_pressed():
	#Fade in screen
	current_button = $MenuContainer/Button2
	
	Global.NODE_GUI_TRANSITION.transition_in(1)
	
	NODE_MENU_CONTAINER.visible = true
	NODE_SETTINGS_CONTAINER.visible = false
	NODE_ABOUT_CONTAINER.visible = false
	NODE_STAT_CONTAINER.visible = false
	
	#Fade out screen
	Global.NODE_GUI_TRANSITION.transition_out(5)
	yield(Global.NODE_GUI_TRANSITION.NODE_ANIMATION_PLAYER,"animation_finished")
	current_button.grab_focus()
	pass
	
func _on_ButtonFullScreen_pressed():
	var fullscreen_on = OS.window_fullscreen
	if fullscreen_on == false: OS.window_fullscreen = true
	if fullscreen_on == true: OS.window_fullscreen = false
	pass

func _on_ButtonResolution_pressed():
	var current_size = OS.window_size
	if current_size == Vector2(640,360): OS.window_size = Vector2(1280,720)
	if current_size == Vector2(1280,720): OS.window_size = Vector2(1600,900)
	if current_size == Vector2(1600,900): OS.window_size = Vector2(640,360)
	pass

# PLAY SOUND ON BUTTON CHANGE
func _on_Button_focus_exited():
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_menu_move,Vector2(7,4))
	pass 
