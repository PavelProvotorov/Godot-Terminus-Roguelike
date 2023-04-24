extends Item2D

onready var sound_on_throw = Sound.sfx_explosion_0
onready var stat_throwable_range = 3
onready var stat_frag_dmg = 0
onready var stat_dmg = 2

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	item_name = "EMP Grenade"
	item_text = "<%s>\n\n" + Data.DESCRIPTION_DATA.get("item_emp_grenade")
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
	var remove_item:bool = Global.NODE_PLAYER.action_targets_check_throw(stat_throwable_range)
	if remove_item == true:
		Global.NODE_PLAYER.action_throw_item = self
	if remove_item == false:
		pass
	pass

func on_action_throw():
	if item_last_target != null && item_last_target.NODE_BUFFS.has_node("Slowness") == false:
		item_last_target.buff_add("Slowness",item_last_target)
	item_remove_from_inventory(item_parent)
	pass
