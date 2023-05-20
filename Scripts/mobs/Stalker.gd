extends Mob2D

var AI_state = Global.AI_STATE_LIST.STATE_IDLE
var AI_class = Global.AI_CLASS_LIST.CLASS_MELEE

# STATS
#---------------------------------------------------------------------------------------
var stat_ranged_dmg:int = 1
var stat_melee_dmg:int = 2
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
	var position_a:Vector2 = self.position
	var position_b:Vector2 = Global.NODE_PLAYER.position
	var distance = (round(position_a.distance_to(position_b)/Global.grid_size))
	if distance <= 1 && self.visible == false: 
		self.visible = true
		self.tween_visibility_enable()
		self.stat_speed = 2
	pass

func on_action_attack():
	var position_a:Vector2 = self.position
	var position_b:Vector2 = Global.NODE_PLAYER.position
	var distance = (round(position_a.distance_to(position_b)/Global.grid_size))
	if distance <= 1 && self.visible == false: 
		self.visible = true
		self.tween_visibility_enable()
		self.stat_speed = 2
	pass

func on_action_shoot():
	pass
