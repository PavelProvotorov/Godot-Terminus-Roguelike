extends Item2D

onready var stat_melee_dmg = 1

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	item_name = "Teleport"
	NODE_NAME.set_text(item_name)
	pass

# ACTIONS
#---------------------------------------------------------------------------------------
func on_action_pickup():
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_pickup,self.position/grid_size)
	Global.NODE_PLAYER.spawn_text(item_name,self.position/grid_size,Color.white,0.0)
	item_add_to_inventory(self)
	pass

func on_action_use():
	var free_cells = []
	var floor_cells = Global.LEVEL_LAYER_LOGIC.get_used_cells_by_id(Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_FLOOR)
	var occupied_cells = Global.LEVEL_LAYER_LOGIC.util_get_occupied_cells()
	for cell in floor_cells:
		if occupied_cells.has(cell) != true:
			free_cells.append(cell)
		pass
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_teleport,Global.NODE_PLAYER.position/grid_size)
	Global.NODE_PLAYER.position = (free_cells[randi() % free_cells.size()]*grid_size)
	Global.LEVEL_LAYER_LOGIC.fog_update()
	item_remove_from_inventory(item_parent)
	pass
