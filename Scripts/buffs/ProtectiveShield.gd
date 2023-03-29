extends Buff2D

# SIGNALS
#---------------------------------------------------------------------------------------
signal on_action_finished

# READY
#---------------------------------------------------------------------------------------
func _ready():
	buff_duration = 3
	pass

func buff_on_action_add():
	buff_owner.is_vulnerable = false
	buff_owner.NODE_ANIMATED_SPRITE_SHIELD.visible = true
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_shield_enable,buff_owner.position/grid_size)
#	yield(self.get_idle_frame(),"completed")
	emit_signal("on_action_finished")
	pass

func buff_on_action_tick():
#	yield(self.get_idle_frame(),"completed")
	emit_signal("on_action_finished")
	pass
	
func buff_on_action_remove():
	buff_owner.is_vulnerable = true
	buff_owner.NODE_ANIMATED_SPRITE_SHIELD.visible = false
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_shield_disable,buff_owner.position/grid_size)
	buff_owner.buff_remove(self,buff_owner)
	pass
