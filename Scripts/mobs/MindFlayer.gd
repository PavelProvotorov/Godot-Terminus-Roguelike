extends Mob2D

var AI_state = Global.AI_STATE_LIST.STATE_IDLE
var AI_class = Global.AI_CLASS_LIST.CLASS_RANGED

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
	var position_a:Vector2 = Vector2(self.position.x/grid_size,self.position.y/grid_size)
	var position_b:Vector2
	
	yield(get_idle_frame(),"completed")
	emit_signal("on_action_finished")
	pass

func on_action_attack():
	yield(self.get_idle_frame(),"completed")
	emit_signal("on_action_finished")
	pass

func on_action_shoot():
	var position_a:Vector2 = self.get_position() / grid_size
	var position_b:Vector2 = Global.NODE_PLAYER.get_position() / grid_size
	
	# VECTOR DECIMALS FIX
	position_a = Vector2(int(position_a.x),int(position_a.y)) * grid_size
	position_b = Vector2(int(position_b.x),int(position_b.y)) * grid_size
	
	var occupied_cells_list = Global.LEVEL_LAYER_LOGIC.util_get_occupied_cells()
	var cell_type = Global.LEVEL_LAYER_LOGIC.get_cellv(position_a/grid_size)
	
	AI_class = Global.AI_CLASS_LIST.CLASS_MELEE
	if cell_type == Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_FLOOR or cell_type == Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_EXIT or cell_type == Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_ENTRANCE:
		Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_blink,Global.NODE_PLAYER.position/grid_size)
		Global.NODE_PLAYER.set_position(position_a)
		yield(get_tree(),"idle_frame")
		self.set_position(position_b)
		yield(get_tree(),"idle_frame")
		yield(self.get_idle_frame(),"completed")
		emit_signal("on_action_finished")
	else:
		yield(self.get_idle_frame(),"completed")
		emit_signal("on_action_finished")
	pass
