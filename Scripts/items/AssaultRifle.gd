extends Item2D

var sound_on_ranged = Sound.sfx_shoot_2
var stat_ranged_dmg = 2
var stat_shoot_count = 3
var stat_range = 4

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	item_name = "Assault Rifle"
	NODE_NAME.set_text(item_name)
	pass

# ACTIONS
#---------------------------------------------------------------------------------------
func on_action_pickup():
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_pickup,self.position/grid_size)
	Global.NODE_PLAYER.spawn_text(item_name,self.position/grid_size,Color.white,0.0)
	weapon_add_to_inventory(self,Global.NODE_PLAYER.position)
	pass
