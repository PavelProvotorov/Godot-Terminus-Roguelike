extends Item2D

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	ammo_count = randi()%4+2
	item_name = "Ammo"
	NODE_NAME.set_text(item_name)
	pass

# SIGNALS
#---------------------------------------------------------------------------------------
signal on_action_finished

# ACTIONS
#---------------------------------------------------------------------------------------
func on_action_pickup():
	Global.NODE_PLAYER.spawn_text(ammo_count,Global.NODE_PLAYER.position/grid_size,Color.gold,0.0)
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_pickup,self.position/grid_size)
	item_action_add_ammo(ammo_count,self)
	item_remove(item_parent)

func on_action_use():
	pass

func on_action_tick():
	pass
