extends Mob2D

var AI_state = Global.AI_STATE_LIST.STATE_IDLE
var AI_class = Global.AI_CLASS_LIST.CLASS_MELEE

# SOUNDS
#---------------------------------------------------------------------------------------
var sound_on_move = Sound.sfx_move
var sound_on_hit = Sound.sfx_hit_0
var sound_on_melee = Sound.sfx_punch_0
var sound_on_ranged = Sound.sfx_spit
var sound_on_death = Sound.sfx_death_0

# STATS
#---------------------------------------------------------------------------------------
var stat_ranged_dmg:int = 1
var stat_melee_dmg:int = 2
var stat_ambition:int = 1
var stat_health:int = 4
var stat_speed:int = 1
var buff_use:int = 1

# SIGNALS
#---------------------------------------------------------------------------------------
signal on_action_finished

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	NODE_ANIMATED_SPRITE.set_animation(ANIMATIONS.IDLE)
	NODE_ANIMATED_SPRITE.set_frame(rand_range(0,NODE_ANIMATED_SPRITE.get_sprite_frames().get_frame_count(ANIMATIONS.IDLE)))
	animation_flip(randi()%2,false)
	pass

func on_action_move():
	var position_a:Vector2 = self.position
	var position_b:Vector2 = Global.NODE_PLAYER.position
	var distance = (round(position_a.distance_to(position_b)/Global.grid_size))
	if distance <= 2 && buff_use != 0: 
		NODE_MAIN.buff_add("ProtectiveShield",NODE_MAIN)
		buff_use -= 1
	yield(self.get_idle_frame(),"completed")
	emit_signal("on_action_finished")
	pass

func on_action_attack():
	var position_a:Vector2 = self.position
	var position_b:Vector2 = Global.NODE_PLAYER.position
	var distance = (round(position_a.distance_to(position_b)/Global.grid_size))
	if distance <= 2 && buff_use != 0: 
		NODE_MAIN.buff_add("ProtectiveShield",NODE_MAIN)
		buff_use -= 1
	yield(self.get_idle_frame(),"completed")
	emit_signal("on_action_finished")
	pass

func on_action_shoot():
	yield(self.get_idle_frame(),"completed")
	emit_signal("on_action_finished")
	pass
