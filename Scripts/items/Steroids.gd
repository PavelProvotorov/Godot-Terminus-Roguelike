extends Item2D

onready var stat_melee_dmg = 1

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	item_name = "Steroids"
	item_text = "<%s>\n\n" + Data.DESCRIPTION_DATA.get("item_steroids")
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
	Global.NODE_PLAYER.buff_add("DamageUp",Global.NODE_PLAYER)
#	Global.NODE_PLAYER.calculate_melee_damage(self,Global.NODE_PLAYER)
	Global.NODE_PLAYER.spawn_text("Damage Up",Global.NODE_PLAYER.position/grid_size,Color.white,0.2)
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_hit_0,Global.NODE_PLAYER.position/grid_size)
	if Global.GAME_STATE == Global.GAME_STATE_LIST.STATE_NONE:
		Global.NODE_MAIN.level_game_over()
	item_remove_from_inventory(item_parent)
	pass
