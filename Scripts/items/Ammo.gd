extends Item2D

onready var NODE_SOUND = $Sound

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	NODE_SOUND.stream = Sound.sfx_pickup
	count = round(rand_range(3,6))
	pass

# ACTIONS
#---------------------------------------------------------------------------------------
func on_action_pickup():
	Global.NODE_PLAYER.stat_ammo += count
	if Global.NODE_PLAYER.stat_ammo >= Global.NODE_PLAYER.stat_ammo_max: Global.NODE_PLAYER.stat_ammo = Global.NODE_PLAYER.stat_ammo_max
	if Global.NODE_PLAYER.stat_ammo <= Global.NODE_PLAYER.stat_ammo_max: pass
	Sound.play_sound(Global.NODE_PLAYER,Sound.sfx_pickup)
	item_remove()

func on_action_use():
	pass

func on_action_tick():
	pass
