extends Buff2D

# READY
#---------------------------------------------------------------------------------------
func _ready():
	buff_infinite == true
	pass

func buff_on_action_add():
	pass

func buff_on_action_tick():
	if buff_owner.stat_speed > 0:
		buff_owner.stat_speed = 0
	elif buff_owner.stat_speed == 0:
		buff_owner.stat_speed = 1
	pass
	
func buff_on_action_remove():
	buff_owner.stat_speed -= 1
	buff_owner.buff_remove(self,buff_owner)
	pass
