extends Item2D

onready var sound_on_ranged = Sound.sfx_shoot_0
onready var stat_ranged_dmg = 3
onready var stat_shoot_count = 1
onready var stat_range = 3

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	ammo_count = randi()%2+0 
	item_name = "Pistol"
	NODE_NAME.set_text(item_name)
	pass

# ACTIONS
#---------------------------------------------------------------------------------------
func on_action_pickup():
	Global.NODE_PLAYER.spawn_text(item_name,self.position/grid_size,Color.white,0.0)
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_pickup,self.position/grid_size)
	item_action_add_ammo(ammo_count,self)
	weapon_add_to_inventory(self,Global.NODE_PLAYER.position)
	pass

func on_action_shoot():
	var extra_turn = util_chance(50)
	if extra_turn == true:
		Global.NODE_PLAYER.spawn_text(">>>",Global.NODE_PLAYER.position/grid_size,Color.white,0.0)
		Global.NODE_PLAYER.turn_count -= 1
	else:
		pass
	pass

func on_action_read():
	pass
