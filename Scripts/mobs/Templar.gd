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
var stat_melee_dmg:int = 3
var stat_ambition:int = 1
var stat_health:int = 4
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
		var mobs_spawned:int = 0
		var mob_count = randi()%3+2
		for mob in mob_count:
			var occupied_cells_list = Global.LEVEL_LAYER_LOGIC.util_get_occupied_cells()
			var cell = spawn_directions[randi() % spawn_directions.size()]
			var cell_position = cell + (position_a / grid_size)
			var cell_type = Global.LEVEL_LAYER_LOGIC.get_cellv(cell_position)
			if cell_type == Global.LEVEL_LAYER_LOGIC.TILESET_BASE.TILE_FLOOR && occupied_cells_list.has(cell_position) == false:
				var mob_instance
				mob_instance = Global.LEVEL.level_mob_spawn_tween("Templar",cell_position,cell_position)
				Global.LEVEL.level_queue.insert(Global.LEVEL.level_queue_mob_count+1,mob_instance.name)
				mob_instance.AI_state = Global.AI_STATE_LIST.STATE_SPAWN
				mob_instance.stat_melee_dmg = 1
				mob_instance.stat_health = 1
				mob_instance.stat_speed = 1
				mob_instance.spawn = false
				mob_instance.visible = true
				spawn_directions.erase(cell)
				mob_instance.tween_visibility_enable()
		Sound.sound_spawn(Global.NODE_SOUNDS,Sound.sfx_mob_appear,Global.NODE_PLAYER.position/grid_size)
	pass

func on_action_attack():
	pass

func on_action_shoot():
	pass
