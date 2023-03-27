extends Item2D

onready var stat_melee_dmg = 1

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	item_name = "Shield Generator"
	item_text = "<%s>\n\n" + Data.DESCRIPTION_DATA.get("item_shield_generator")
	item_text = item_text % [item_name]
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
	if Global.NODE_PLAYER.is_vulnerable == true:
		Global.NODE_PLAYER.buff_add("ProtectiveShield",Global.NODE_PLAYER)
		Global.NODE_PLAYER.spawn_text("Shield Activated",Global.NODE_PLAYER.position/grid_size,Color.white,0.2)
		Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_shield_enable,Global.NODE_PLAYER.position/grid_size)
		item_remove_from_inventory(item_parent)
	else:
		pass
	pass
