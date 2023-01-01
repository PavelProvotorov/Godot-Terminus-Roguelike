extends Buff2D

onready var stat_original

# SIGNALS
#---------------------------------------------------------------------------------------
signal on_action_finished

# READY
#---------------------------------------------------------------------------------------
func _ready():
	buff_duration = 5
	pass

func buff_on_action_add():
	stat_original = buff_owner.stat_visibility_max
	buff_owner.stat_visibility = 1
	Global.LEVEL_LAYER_LOGIC.fog_update()
#	yield(self.get_idle_frame(),"completed")
	emit_signal("on_action_finished")
	pass

func buff_on_action_tick():
	if buff_owner.stat_visibility == stat_original:
		buff_owner.stat_visibility = 1
		Global.LEVEL_LAYER_LOGIC.fog_update()
	yield(self.get_idle_frame(),"completed")
	emit_signal("on_action_finished")
	pass
	
func buff_on_action_remove():
	buff_owner.stat_visibility = stat_original
	Global.LEVEL_LAYER_LOGIC.fog_update()
	buff_owner.buff_remove(self,buff_owner)
	pass
