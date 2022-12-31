extends Item2D

var sound_on_ranged = Sound.sfx_shoot_1
var stat_ranged_dmg = 4
var stat_shoot_count = 1
var stat_range = 2

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	item_name = "Tactical Shotgun"
	NODE_NAME.set_text(item_name)
	pass

# ACTIONS
#---------------------------------------------------------------------------------------
func on_action_pickup():
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_pickup,self.position/grid_size)
	Global.NODE_PLAYER.spawn_text(item_name,self.position/grid_size,Color.white,0.0)
	weapon_add_to_inventory(self,Global.NODE_PLAYER.position)
	pass
