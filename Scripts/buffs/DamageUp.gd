extends Buff2D

# READY
#---------------------------------------------------------------------------------------
func _ready():
	buff_duration = 8
	pass

func buff_on_action_add():
	buff_owner.stat_melee_dmg += 2
	pass

func buff_on_action_tick():
	pass
	
func buff_on_action_remove():
	buff_owner.stat_melee_dmg -= 2
	buff_owner.spawn_text("Damage Down",buff_owner.position/grid_size,Color.white,0.0)
	buff_owner.buff_remove(self,buff_owner)
	pass
