extends Node

# CONSTANT VARIABLES
#---------------------------------------------------------------------------------------
const map_width = 16
const map_height = 9
const grid_size = 8

onready var NODE_GUI = get_node("/root/Main/GUI")
onready var NODE_TEXT = get_node("/root/Main/GUI/GUI_MISC/Text")
onready var NODE_MUSIC = get_node("/root/Main/GUI/GUI_MISC/Music")
onready var NODE_SOUNDS = get_node("/root/Main/GUI/GUI_MISC/Sounds")
onready var NODE_GUI_TRANSITION= get_node("/root/Main/GUI/GUI_TRANSITION")
onready var NODE_GUI_LAYER_MAIN = get_node("/root/Main/GUI/GUI_LAYER_MAIN")
onready var NODE_UI_TEXT = get_node("/root/Main/GUI/GUI_LAYER_MAIN/UI_TEXT")
onready var NODE_UI_INVENTORY = get_node("/root/Main/GUI/GUI_LAYER_MAIN/UI_INVENTORY")
onready var NODE_UI_WEAPON = get_node("/root/Main/GUI/GUI_LAYER_MAIN/UI_WEAPON")
onready var NODE_UI_ARMOR = get_node("/root/Main/GUI/GUI_LAYER_MAIN/UI_ARMOR")
onready var UI_AMMO = get_node("/root/Main/GUI/GUI_LAYER_MAIN/UI_MAIN/UI_AMMO")
onready var UI_HEALTH = get_node("/root/Main/GUI/GUI_LAYER_MAIN/UI_MAIN/UI_HEALTH")
onready var UI_LEVEL = get_node("/root/Main/GUI/GUI_LAYER_MAIN/UI_MAIN/UI_LEVEL")
onready var UI_TURN = get_node("/root/Main/GUI/GUI_LAYER_MAIN/UI_MAIN/UI_TURN")
onready var NODE_UI_TEXTLOG = get_node("/root/Main/GUI/GUI_LAYER_MAIN/UI_TEXT/UI_TEXTLOG")
onready var NODE_MAIN = get_node("/root/Main")

var CURRENT_MUSIC
var NODE_MENU
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
var GAME_STATE = GAME_STATE_LIST.STATE_MENU

const GROUPS = {
	ITEM = "ITEM",
	WEAPON = "WEAPON",
	PLAYER = "PLAYER",
	HOSTILE = "HOSTILE",
	KINEMATIC = "KINEMATIC",
	TEXTLOG = "TEXTLOG",
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

const DIRECTION_LIST_8:Array = [
	Vector2(1,0),
	Vector2(1,1),
	Vector2(0,1),
	Vector2(0,-1),
	Vector2(1,-1),
	Vector2(-1,-1),
	Vector2(-1,1),
	Vector2(-1,0)
]

enum AI_STATE_LIST {
	STATE_IDLE,
	STATE_WANDER,
	STATE_ENGAGE,
	STATE_SPAWN,
	STATE_NONE
}
enum AI_CLASS_LIST {
	CLASS_MELEE,
	CLASS_RANGED,
	CLASS_AMBUSH,
	CLASS_WAITING,
	CLASS_NONE
}
enum GAME_STATE_LIST {
	STATE_MENU,
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
		# Check through buffs on Player
#		get_tree().call_group("PLAYER","buff_tick")
#		yield(self.get_idle_frame(),"completed")
#		Global.LEVEL_LAYER_LOGIC.fog_update()
#		print("< PLAYER MOVEMENT STARTED >")
		get_tree().call_group("PLAYER","buff_tick")
		yield(self.get_idle_frame(),"completed")
		NODE_PLAYER.turn_count = 0
		NODE_PLAYER.PLAYER_ACTION_INPUT = false
	elif GAME_STATE == GAME_STATE_LIST.STATE_MOB_TURN:
		# Check through buffs on Mobs
		get_tree().call_group("HOSTILE","buff_tick")
		yield(self.get_idle_frame(),"completed")
#		print("< MOB MOVEMENT STARTED >")
		LEVEL.level_queue_prepare()
		LEVEL.on_mob_manager_started()
	else:
		pass
	pass

# LEVEL SPECIFIC FUNCTIONS
#---------------------------------------------------------------------------------------
func get_idle_frame():
	yield(get_tree(),"idle_frame")
