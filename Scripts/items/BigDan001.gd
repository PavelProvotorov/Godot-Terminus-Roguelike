extends Item2D

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	item_name = "BigDan-001"
	item_text = item_prepare_text()
	NODE_NAME.set_text(item_name)
	pass

# SIGNALS
#---------------------------------------------------------------------------------------
signal on_action_finished

# ACTIONS
#---------------------------------------------------------------------------------------
func on_action_pickup():
	item_display_text(self,item_text)
	pass

func on_action_use():
	pass

func on_action_tick():
	pass

func on_action_read():
	pass
