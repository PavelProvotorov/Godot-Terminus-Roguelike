extends Node

onready var DEBUG_LABEL = preload("res://scenes/DebugLabel.tscn")

onready var TILEMAP_LOGIC = $Logic
onready var TILEMAP_DEBUG = $Debug

func _ready():
	debug_add_cell_positions(TILEMAP_LOGIC.get_used_cells())
	pass

func debug_add_cell_positions(cells:PoolVector2Array):
	for cell in cells:
		var label = DEBUG_LABEL.instance()
		label.text = str(cell)
		label.set_position(TILEMAP_DEBUG.map_to_world(cell))
		TILEMAP_DEBUG.add_child(label)
	pass
