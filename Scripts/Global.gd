extends Node

# CONSTANT VARIABLES
#---------------------------------------------------------------------------------------
const map_width = 16
const map_height = 9
const grid_size = 8

onready var NODE_GUI = get_node("/root/Main/GUI")
onready var NODE_UI_TEXT = get_node("/root/Main/GUI/GUI_LAYER_MAIN/UI_TEXT")
onready var UI_AMMO = get_node("/root/Main/GUI/GUI_LAYER_MAIN/UI_MAIN/UI_AMMO")
onready var UI_HEALTH = get_node("/root/Main/GUI/GUI_LAYER_MAIN/UI_MAIN/UI_HEALTH")
onready var NODE_UI_TEXTLOG = get_node("/root/Main/GUI/GUI_LAYER_MAIN/UI_TEXT/UI_TEXTLOG")
onready var NODE_TEXTLOG = get_node("/root/Main/Control/TextLog")
onready var NODE_MAIN = get_node("/root/Main")

var NODE_PLAYER

# LEVEL VARIABLES
#---------------------------------------------------------------------------------------
var LEVEL_LIST = []
var LEVEL_LAYER_LOGIC
var LEVEL_LAYER_BASE
var LEVEL_LAYER_WALL
var LEVEL_LAYER_DECO
var LEVEL_LAYER_FOG
var LEVEL_QUEUE
var LEVEL_NEXT
var LEVEL

var LEVEL_ENTRANCE
var LEVEL_EXIT

var LEVEL_COUNT = 1

#---------------------------------------------------------------------------------------
var GAME_STATE = GAME_STATE_LIST.STATE_PLAYER_TURN

const GROUPS = {
	ITEM = "ITEM",
	WEAPON = "WEAPON",
	PLAYER = "PLAYER",
	HOSTILE = "HOSTILE",
	KINEMATIC = "KINEMATIC",
	OBJECT = "OBJECT",
	QUEEN = "QUEEN",
	ALLY = "ALLY",
	NONE = "NONE"
}

const DIRECTION_LIST:Array = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
	]

enum AI_STATE_LIST {
	STATE_IDLE,
	STATE_WANDER,
	STATE_ENGAGE,
	STATE_NONE
}
enum AI_CLASS_LIST {
	CLASS_MELEE,
	CLASS_RANGED,
	CLASS_NONE
}
enum GAME_STATE_LIST {
	STATE_PLAYER_TURN,
	STATE_MOB_TURN,
	STATE_PAUSE,
	STATE_NONE
}

var gameTargetNode
var gameMovingNode

#---------------------------------------------------------------------------------------
func _ready():
	pass

func game_state_manager(state):
	GAME_STATE = state
	if GAME_STATE == GAME_STATE_LIST.STATE_NONE:
		print("< NO GAME STATE>")
	elif GAME_STATE == GAME_STATE_LIST.STATE_PLAYER_TURN:
#		print("< PLAYER MOVEMENT STARTED >")
		NODE_PLAYER.turn_count = 0
	elif GAME_STATE == GAME_STATE_LIST.STATE_MOB_TURN:
#		print("< MOB MOVEMENT STARTED >")
		LEVEL.level_queue_prepare()
		LEVEL.manager_mob()
	else:
		pass
	pass

# LEVEL SPECIFIC FUNCTIONS
#---------------------------------------------------------------------------------------
func get_idle_frame():
	yield(get_tree(),"idle_frame")
