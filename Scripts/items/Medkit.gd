extends Item2D

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	count = round(rand_range(1,2))
	item_name = "Health"
	NODE_NAME.set_text(item_name)
	pass

# ACTIONS
#---------------------------------------------------------------------------------------
func on_action_pickup():
	Global.NODE_PLAYER.stat_health += count
	if Global.NODE_PLAYER.stat_health >= Global.NODE_PLAYER.stat_health_max: Global.NODE_PLAYER.stat_health = Global.NODE_PLAYER.stat_health_max
	if Global.NODE_PLAYER.stat_health <= Global.NODE_PLAYER.stat_health: pass
	Global.NODE_PLAYER.spawn_text(count,Global.NODE_PLAYER.position/grid_size,Color.greenyellow,0.0)
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_pickup,self.position/grid_size)
	Global.NODE_PLAYER.check_turn()
	item_remove(item_parent)

func on_action_use():
	pass

func on_action_tick():
	pass
