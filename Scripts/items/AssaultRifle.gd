extends Item2D

#var sound_on_ranged = Sound.
onready var sound_on_ranged = Sound.sfx_shoot_4
onready var stat_ranged_dmg = 2
onready var stat_shoot_count = 3
onready var stat_range = 4

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	ammo_count = randi()%3+0
	item_name = "Assault Rifle"
	item_text = "<%s>\n\n" + Data.DESCRIPTION_DATA.get("item_assault_rifle") + "\n\n* Damage: %s\n* Range: %s"
	item_text = item_text % [item_name,stat_ranged_dmg,stat_range]
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
