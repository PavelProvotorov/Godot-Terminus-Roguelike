extends Item2D

onready var sound_on_throw = Sound.sfx_explosion_0
onready var stat_throwable_range = 3
onready var stat_dmg = 8

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	item_name = "Grenade"
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
	var remove_item:bool = Global.NODE_PLAYER.action_targets_check_throw(stat_throwable_range)
	if remove_item == true:
		Global.NODE_PLAYER.action_throw_item = self
	if remove_item == false:
		pass
	pass

func on_action_throw():
	item_remove_from_inventory(item_parent)
	pass

func on_action_tick():
	pass

func on_action_read():
	pass
