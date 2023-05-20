extends Mob2D

var AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
var AI_class = Global.AI_CLASS_LIST.CLASS_RANGED

# STATS
#---------------------------------------------------------------------------------------
var stat_ranged_dmg:int = 2
var stat_melee_dmg:int = 2
var stat_ambition:int = 3
var stat_health:int = 4
var stat_speed:int = 1

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
	pass

func on_action_attack():
	pass

func on_action_shoot():
	var position_a:Vector2 = Global.LEVEL.moving_entity_position * grid_size
	var position_b:Vector2 = Global.LEVEL.target_entity_position * grid_size
	Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_blink,Global.NODE_PLAYER.position/grid_size)
	Global.NODE_PLAYER.set_position(position_a)
	self.set_position(position_b)
	pass
