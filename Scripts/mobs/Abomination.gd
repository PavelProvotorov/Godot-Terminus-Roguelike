extends Mob2D

var AI_state = Global.AI_STATE_LIST.STATE_IDLE
var AI_class = Global.AI_CLASS_LIST.CLASS_WAITING

# STATS
#---------------------------------------------------------------------------------------
var stat_ranged_dmg:int = 1
var stat_melee_dmg:int = 2
var stat_ambition:int = 1
var stat_health:int = 4
var stat_speed:int = 1
var minion_count:int

# SIGNALS
#---------------------------------------------------------------------------------------
signal on_action_finished

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	minion_count = randi()%3+1
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
			var spawn = get_chance(50)
			if spawn == true && minion_count != 0:
				minion_count -= 1
				var mob_instance = Global.LEVEL.level_mob_spawn_tween("Vermin",position_a,position_b)
				mob_instance.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
				yield(mob_instance.get_node("Tween"),"tween_all_completed")
				break
			elif spawn == false:
				break
		elif NODE_RAYCAST_COLLIDE.is_colliding() == true:
			pass
	pass

func on_action_attack():
	pass

func on_action_shoot():
	pass
