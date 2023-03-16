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
var stat_melee_dmg:int = 2
var stat_ambition:int = 1
var stat_health:int = 3
var stat_speed:int = 1
var spawn:bool = true

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
	if distance <= 2 && spawn == true: 
		spawn = false
		var spawn_directions = Global.DIRECTION_LIST_8
		var mob_count = (round(rand_range(1,2))as int)
		for mob in mob_count:
			var occupied_cells_list = Global.LEVEL_LAYER_LOGIC.util_get_occupied_cells()
			var cell = spawn_directions[randi() % spawn_directions.size()]
			var cell_position = cell + (position_a / grid_size)
			var cell_type = Global.LEVEL_LAYER_LOGIC.get_cellv(cell_position)
			if cell_type == Global.LEVEL_LAYER_LOGIC.TILESET_BASE.TILE_FLOOR && occupied_cells_list.has(cell_position) == false:
				var mob_instance = Global.LEVEL.level_mob_spawn_invisible("Templar",cell_position)
				mob_instance.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
				mob_instance.stat_melee_dmg = 0
				mob_instance.stat_health = 1
				mob_instance.stat_speed = 1
				mob_instance.spawn = false
				spawn_directions.erase(cell)
				mob_instance.tween_visibility_enable()
				if mob_instance.visible == false:
					mob_instance.visible = true
					mob_instance.tween_visibility_enable()
				if mob == mob_count-1:
					self.tween_visibility_enable()
					self.position = mob_instance.position
					mob_instance.position = position_a
	yield(self.get_idle_frame(),"completed")
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
