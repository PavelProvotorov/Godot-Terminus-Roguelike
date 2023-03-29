extends Mob2D

var AI_state = Global.AI_STATE_LIST.STATE_IDLE
var AI_class = Global.AI_CLASS_LIST.CLASS_NONE

# SOUNDS
#---------------------------------------------------------------------------------------
var sound_on_move = Sound.sfx_move
var sound_on_hit = Sound.sfx_hit_0
var sound_on_melee = Sound.sfx_punch_0
var sound_on_ranged = Sound.sfx_spit
var sound_on_death = Sound.sfx_death_3

# STATS
#---------------------------------------------------------------------------------------
var stat_ranged_dmg:int = 0
var stat_melee_dmg:int = 0
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
	var directions_array = Global.DIRECTION_LIST
	var position_a:Vector2 = Vector2(self.position.x/grid_size,self.position.y/grid_size)
	var position_b:Vector2
	var spawn:bool = get_chance(50)
	directions_array.shuffle()
	
	# Get exceptions
	get_raycast_exceptions(NODE_RAYCAST_COLLIDE,Global.GROUPS.ITEM)
	
	if spawn == true:
		# Burst into maggots and die
		for direction in directions_array:
			position_b = position_a + direction
			raycast_cast_to(NODE_RAYCAST_COLLIDE,position_a,position_b)
			if NODE_RAYCAST_COLLIDE.is_colliding() == false:
				var mob_instance = Global.LEVEL.level_mob_spawn_tween("Maggot",position_a,position_b)
				mob_instance.AI_state = Global.AI_STATE_LIST.STATE_SPAWN
				Global.LEVEL.level_queue.insert(Global.LEVEL.level_queue_mob_count+1,mob_instance.name)
		Global.LEVEL_LAYER_LOGIC.remove_child(self)
	pass

func on_action_attack():
	pass

func on_action_shoot():
	pass
