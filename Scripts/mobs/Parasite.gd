extends Mob2D

var AI_state = Global.AI_STATE_LIST.STATE_IDLE
var AI_class = Global.AI_CLASS_LIST.CLASS_MELEE

# STATS
#---------------------------------------------------------------------------------------
var stat_ranged_damage:int = 1
var stat_melee_dmg:int = 1
var stat_ambition:int = 1
var stat_health:int = 2
var stat_speed:int = 2

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
	pass
