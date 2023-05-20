extends Mob2D

var AI_state = Global.AI_STATE_LIST.STATE_IDLE
var AI_class = Global.AI_CLASS_LIST.CLASS_MELEE

# STATS
#---------------------------------------------------------------------------------------
var stat_ranged_dmg:int = 0
var stat_melee_dmg:int = 1
var stat_ambition:int = 1
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
	var free_cells = get_free_cells_4(Global.NODE_PLAYER)
	if get_chance(15) == true:
		free_cells.shuffle()
		for cell in free_cells:
			Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_blink,Global.NODE_PLAYER.position/grid_size)
			self.set_position(cell * grid_size)
			break
		pass
	pass

func on_action_attack():
	pass

func on_action_shoot():
	pass
