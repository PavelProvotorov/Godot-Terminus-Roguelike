extends Mob2D

var AI_state = Global.AI_STATE_LIST.STATE_IDLE
var AI_class = Global.AI_CLASS_LIST.CLASS_RANGED

# SOUNDS
#---------------------------------------------------------------------------------------
var sound_on_move = Sound.sfx_move
var sound_on_hit = Sound.sfx_hit_0
var sound_on_melee = Sound.sfx_punch_0
var sound_on_ranged = Sound.sfx_spit
var sound_on_death = Sound.sfx_death_1

# STATS
#---------------------------------------------------------------------------------------
var stat_ranged_dmg:int = 2
var stat_melee_dmg:int = 1
var stat_ambition:int = 1
var stat_health:int = 3
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
	if Global.NODE_PLAYER.is_vulnerable == true:
		NODE_MAIN.buff_add("Blindness",Global.NODE_PLAYER)
		var cell_list = Global.LEVEL_LAYER_LOGIC.util_get_free_fog_cells()
		var mob_count = (round(rand_range(1,3))as int)
		for mob in mob_count:
			if cell_list != []:
				# Get cell to spawn mob on
				var cell = cell_list[randi() % cell_list.size()]
				cell_list.erase(cell)
				# Spawn mob and set it to engage the player
				var mob_instance = Global.LEVEL.level_mob_spawn("Creep",cell)
				mob_instance.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
			else:
				pass
	pass
