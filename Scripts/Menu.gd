extends CenterContainer

onready var grid_size = Global.grid_size
onready var current_button = $VBoxContainer/Button1
onready var NODE_BACKGROUND = $Background
onready var NODE_VBOX_CONTAINER = $VBoxContainer

func _ready():
	current_button.grab_focus()

# START BUTTON PRESSED
func _on_Button1_pressed():
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_menu_move,Global.NODE_PLAYER.position/grid_size)
	
	#Fade in screen
	Global.NODE_GUI_TRANSITION.transition_in(1)
#	yield(Global.NODE_GUI_TRANSITION.NODE_ANIMATION_PLAYER,"animation_finished")
	
	NODE_BACKGROUND.visible = false
	NODE_VBOX_CONTAINER.visible = false
	Global.NODE_GUI_LAYER_MAIN.visible = true
	
	#Fade out screen
	Global.NODE_GUI_TRANSITION.transition_out(2)
#	yield(Global.NODE_GUI_TRANSITION.NODE_ANIMATION_PLAYER,"animation_finished")
	
	Global.game_state_manager(Global.GAME_STATE_LIST.STATE_PLAYER_TURN)
	pass

# PLAY SOUND ON BUTTON CHANGE
func _on_Button_focus_exited():
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_menu_move,Vector2(7,4))
	pass 

