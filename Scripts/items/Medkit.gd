extends Item2D

onready var count

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	count = round(rand_range(1,2))
	item_name = "Medkit"
	item_text = "<%s>\n\n" + Data.DESCRIPTION_DATA.get("item_medkit")
	item_text = item_text % [item_name]
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
	item_remove(item_parent)
