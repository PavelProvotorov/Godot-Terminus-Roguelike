extends Buff2D

# READY
#---------------------------------------------------------------------------------------
func _ready():
	buff_duration = 5
	pass

func buff_on_action_add():
	buff_owner.stat_speed += 1
	pass

func buff_on_action_tick():
	pass
	
func buff_on_action_remove():
	buff_owner.stat_speed -= 1
	buff_owner.spawn_text("Speed Down",buff_owner.position/grid_size,Color.white,0.0)
	buff_owner.buff_remove(self,buff_owner)
	pass
