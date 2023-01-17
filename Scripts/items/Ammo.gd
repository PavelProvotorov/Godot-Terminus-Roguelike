extends Item2D

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	count = round(rand_range(3,6))
	item_name = "Ammo"
	NODE_NAME.set_text(item_name)
	pass

# SIGNALS
#---------------------------------------------------------------------------------------
signal on_action_finished

# ACTIONS
#---------------------------------------------------------------------------------------
func on_action_pickup():
	item_action_add_ammo(count)
	item_remove(item_parent)

func on_action_use():
	pass

func on_action_tick():
	pass
