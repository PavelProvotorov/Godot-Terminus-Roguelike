extends Item2D

onready var sound_on_ranged = Sound.sfx_shoot_3
onready var stat_ranged_dmg = 4
onready var stat_shoot_count = 1
onready var stat_range = 5

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	ammo_count = randi()%1+0 
	item_name = "Sniper Rifle"
	item_text = "<%s>\n\n" + Data.DESCRIPTION_DATA.get("item_sniper_rifle") + "\n\n* Damage: %s\n* Range: %s"
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

func weapon_calculate_final_damage(distance):
	randomize()
	var final_damage:int = stat_ranged_dmg
	if distance == 1:
		final_damage = 2
	elif distance == 2:
		pass
	elif distance == 3:
		pass
	elif distance == 4:
		final_damage += 1
		pass
	elif distance == 5:
		final_damage += 2
		pass
	else:
		pass
	return final_damage
