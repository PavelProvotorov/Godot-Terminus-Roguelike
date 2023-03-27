extends Mob2D

var AI_state = Global.AI_STATE_LIST.STATE_IDLE
var AI_class = Global.AI_CLASS_LIST.CLASS_MELEE

# SOUNDS
#---------------------------------------------------------------------------------------
var sound_on_move = Sound.sfx_move
var sound_on_hit = Sound.sfx_hit_0
var sound_on_melee = Sound.sfx_punch_0
var sound_on_ranged = Sound.sfx_spit
var sound_on_death = Sound.sfx_death_1

# STATS
#---------------------------------------------------------------------------------------
var stat_ranged_dmg:int = 1
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
	var break_weapon = get_chance(15)
	if break_weapon == true && Global.NODE_PLAYER.equiped_weapon != null:
		spawn_text("weapon broken",Global.NODE_PLAYER.position/grid_size,Color.white,0.0)
		Global.NODE_PLAYER.equiped_weapon.item_remove(Global.NODE_UI_WEAPON.get_child(0))
		Global.NODE_PLAYER.equiped_weapon = null
	elif break_weapon == false && Global.NODE_PLAYER.stat_ammo != 0:
		Global.NODE_PLAYER.stat_ammo -= 1
		pass
	pass

func on_action_shoot():
	pass
