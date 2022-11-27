extends Buff2D

# SIGNALS
#---------------------------------------------------------------------------------------
signal on_action_finished

# READY
#---------------------------------------------------------------------------------------
func _ready():
	buff_infinite == true
	pass

func buff_on_action_add():
	yield(self.get_idle_frame(),"completed")
	emit_signal("on_action_finished")
	pass

func buff_on_action_tick():
	if buff_owner.stat_speed > 0:
		buff_owner.stat_speed = 0
	elif buff_owner.stat_speed == 0:
		buff_owner.stat_speed = 1
	yield(self.get_idle_frame(),"completed")
	emit_signal("on_action_finished")
	pass
	
func buff_on_action_remove():
	buff_owner.stat_speed -= 1
	buff_owner.buff_remove(self,buff_owner)
	pass
