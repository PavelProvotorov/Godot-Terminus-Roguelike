extends Mob2D

var AI_state = Global.AI_STATE_LIST.STATE_IDLE
var AI_class = Global.AI_CLASS_LIST.CLASS_MELEE

# SOUNDS
#---------------------------------------------------------------------------------------
var sound_on_move = Sound.sfx_move
var sound_on_hit = Sound.sfx_hit_0
var sound_on_melee = Sound.sfx_punch_0
var sound_on_ranged = Sound.sfx_spit
var sound_on_death = Sound.sfx_death_4

# STATS
#---------------------------------------------------------------------------------------
var stat_ranged_dmg:int = 1
var stat_melee_dmg:int = 2
var stat_ambition:int = 3
var stat_health:int = 8
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
	NODE_MAIN.buff_add("Slowness",NODE_MAIN)
	pass

func on_action_move():
	var directions_array = Global.DIRECTION_LIST
	var position_a:Vector2 = Vector2(self.position.x/grid_size,self.position.y/grid_size)
	var position_b:Vector2
	directions_array.shuffle()
	
	# Get exceptions
	get_raycast_exceptions(NODE_RAYCAST_COLLIDE,Global.GROUPS.ITEM)
	
	for direction in directions_array:
		position_b = position_a+direction
		raycast_cast_to(NODE_RAYCAST_COLLIDE,position_a,position_b)
		if NODE_RAYCAST_COLLIDE.is_colliding() == false:
			var spawn = get_chance(75)
			if spawn == true:
				var mob_instance = Global.LEVEL.level_mob_spawn_tween("Goo",position_a,position_b)
				mob_instance.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
				yield(mob_instance.get_node("Tween"),"tween_all_completed")
				break
			if spawn == false:
				break
		elif NODE_RAYCAST_COLLIDE.is_colliding() == true:
			pass
	yield(get_idle_frame(),"completed")
	emit_signal("on_action_finished")
	pass

func on_action_attack():
	yield(self.get_idle_frame(),"completed")
	emit_signal("on_action_finished")
	pass

func on_action_shoot():
	yield(self.get_idle_frame(),"completed")
	emit_signal("on_action_finished")
	pass
