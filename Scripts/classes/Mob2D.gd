extends KinematicBody2D
class_name Mob2D

onready var NODE_BUFFS = $Buffs
onready var NODE_POSITION_2D = $Position2D
onready var NODE_ANIMATED_SPRITE = $AnimatedSprite
onready var NODE_ANIMATED_SPRITE_TARGET = $AnimatedSpriteTarget
onready var NODE_ANIMATED_SPRITE_SHIELD = $AnimatedSpriteShield
onready var NODE_COLLISION_2D = $CollisionShape2D
onready var NODE_RAYCAST_COLLIDE = $RayCastCollide
onready var NODE_TWEEN = $Tween
onready var NODE_MAIN = self

var tween_speed_move = 25
var tween_speed_attack = 25
const grid_size = 8

const ANIMATIONS= {
	IDLE   = "IDLE",
	MELEE  = "MELEE",
	RANGED = "RANGED",
	THROW = "THROW"
}

# CONDITION FLAGS
var is_vulnerable:bool = true

# SOUNDS
#---------------------------------------------------------------------------------------
var sound_on_move = Sound.sfx_move
var sound_on_hit = Sound.sfx_hit_0
var sound_on_melee = Sound.sfx_punch_0
var sound_on_ranged = Sound.sfx_spit

# READY
#---------------------------------------------------------------------------------------
func _ready():
	pass

# UTILITY
#---------------------------------------------------------------------------------------
func calculate_melee_damage(is_attacker,is_target):
	if is_target.is_vulnerable == false:
		spawn_text(0,is_target.position/grid_size,Color.gray,0.0)
		return false
	else:
		is_target.stat_health -= is_attacker.stat_melee_dmg
		if is_target != Global.NODE_PLAYER:
			Global.score_damage_dealt += is_attacker.stat_melee_dmg
			pass
		if is_target == Global.NODE_PLAYER:
			Global.score_damage_received += is_attacker.stat_melee_dmg
			pass
		if is_target.stat_health <= 0 and is_target != Global.NODE_PLAYER:
			Global.score_mobs += 1
			Global.LEVEL_LAYER_LOGIC.remove_child(is_target)
			spawn_text(is_attacker.stat_melee_dmg,is_target.position/grid_size,Color.lightcoral,0.0)
		elif is_target.stat_health <= 0 and is_target == Global.NODE_PLAYER:
			spawn_text(is_attacker.stat_melee_dmg,is_target.position/grid_size,Color.lightcoral,0.0)
			Global.NODE_PLAYER.stat_health = 0
			Global.NODE_PLAYER.NODE_ANIMATED_SPRITE.visible = false
			Global.GAME_STATE = Global.GAME_STATE_LIST.STATE_NONE
		else:
			spawn_text(is_attacker.stat_melee_dmg,is_target.position/grid_size,Color.lightgray,0.0)
	return true
	
func calculate_ranged_damage(is_attacker,is_target,attacker_ranged_damage):
	if is_target.is_vulnerable == false:
		spawn_text(0,is_target.position/grid_size,Color.gray,0.0)
		return false
	else:
		is_target.stat_health -= attacker_ranged_damage
		if is_target != Global.NODE_PLAYER:
			Global.score_damage_dealt += attacker_ranged_damage
			pass
		if is_target == Global.NODE_PLAYER:
			Global.score_damage_received += attacker_ranged_damage
			pass
		if is_target.stat_health <= 0 and is_target != Global.NODE_PLAYER:
			Global.score_mobs += 1
			Global.LEVEL_LAYER_LOGIC.remove_child(is_target)
			spawn_text(attacker_ranged_damage,is_target.position/grid_size,Color.lightcoral,0.0)
		elif is_target.stat_health <= 0 and is_target == Global.NODE_PLAYER:
			spawn_text(attacker_ranged_damage,is_target.position/grid_size,Color.lightcoral,0.0)
			Global.NODE_PLAYER.stat_health = 0
			Global.NODE_PLAYER.NODE_ANIMATED_SPRITE.visible = false
			Global.GAME_STATE = Global.GAME_STATE_LIST.STATE_NONE
		else:
			spawn_text(attacker_ranged_damage,is_target.position/grid_size,Color.lightgray,0.0)
	return true

func calculate_other_damage(is_attacker_damage,is_target):
	if is_target.is_vulnerable == false:
		spawn_text(0,is_target.position/grid_size,Color.gray,0.0)
		return false
	else:
		is_target.stat_health -= is_attacker_damage
		if is_target != Global.NODE_PLAYER:
			Global.score_damage_dealt += is_attacker_damage
			pass
		if is_target == Global.NODE_PLAYER:
			Global.score_damage_received += is_attacker_damage
			pass
		if is_target.stat_health <= 0 and is_target != Global.NODE_PLAYER:
			Global.score_mobs += 1
			Global.LEVEL_LAYER_LOGIC.remove_child(is_target)
			spawn_text(is_attacker_damage,is_target.position/grid_size,Color.lightcoral,0.0)
		elif is_target.stat_health <= 0 and is_target == Global.NODE_PLAYER:
			spawn_text(is_attacker_damage,is_target.position/grid_size,Color.lightcoral,0.0)
			Global.NODE_PLAYER.stat_health = 0
			Global.NODE_PLAYER.NODE_ANIMATED_SPRITE.visible = false
			Global.GAME_STATE = Global.GAME_STATE_LIST.STATE_NONE
		else:
			spawn_text(is_attacker_damage,is_target.position/grid_size,Color.gray,0.0)
	return true

func animation_flip(is_flip_h:bool, is_flip_v:bool):
	NODE_ANIMATED_SPRITE.flip_h = is_flip_h
	NODE_ANIMATED_SPRITE.flip_v = is_flip_v
	pass

func animation_change(animation_type:String,is_playing:bool,is_random:bool):
	NODE_ANIMATED_SPRITE.set_animation(animation_type)
	NODE_ANIMATED_SPRITE.playing = is_playing
	if is_random == true:
		NODE_ANIMATED_SPRITE.set_frame(rand_range(0,NODE_ANIMATED_SPRITE.get_sprite_frames().get_frame_count(animation_type)))
	if is_random == false:
		pass
	pass

func action_move_notween(start,finish):
	self.position = finish
	NODE_TWEEN.start()
	yield(NODE_TWEEN,"tween_completed")
#	NODE_TWEEN.emit_signal("tween_all_completed")
	pass

func action_move_tween(start,finish):
	NODE_TWEEN.interpolate_property(self,'position',start,finish,1.0/tween_speed_move, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	NODE_TWEEN.start()
	pass

func action_attack_tween(start,finish):
	NODE_TWEEN.interpolate_property(self,"position",start,finish,0.75/12)
	NODE_TWEEN.start()
	yield(NODE_TWEEN,"tween_completed")
	NODE_TWEEN.interpolate_property(self,"position",finish,start,1.0/12)
	NODE_TWEEN.start()
	yield(NODE_TWEEN,"tween_completed")
#	NODE_TWEEN.emit_signal("tween_all_completed")
	pass

func action_shoot_tween(start,finish):
	if start - finish == Vector2(0,-grid_size): finish = Vector2(finish.x,finish.y-(grid_size/2))
	if start - finish == Vector2(grid_size,0):  finish = Vector2((grid_size/2)+finish.x,finish.y)
	if start - finish == Vector2(-grid_size,0): finish = Vector2(finish.x-(grid_size/2),finish.y)
	if start - finish == Vector2(0,grid_size):  finish = Vector2(finish.x,finish.y+(grid_size/2))
	
	NODE_TWEEN.interpolate_property(self,"position",start,finish,0.75/12)
	NODE_TWEEN.start()
	yield(NODE_TWEEN,"tween_completed")
	NODE_TWEEN.interpolate_property(self,"position",finish,start,1.0/12)
	NODE_TWEEN.start()
	yield(NODE_TWEEN,"tween_completed")
#	NODE_TWEEN.emit_signal("tween_all_completed")

func tween_spawn_enable():
	NODE_TWEEN.interpolate_property(NODE_ANIMATED_SPRITE, "scale", Vector2(0,0), Vector2(1,1), 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)

func tween_visibility_enable():
	NODE_TWEEN.interpolate_property(self, "modulate:a", 0.3, 1.0, 0.3, Tween.TRANS_SINE, Tween.EASE_IN_OUT)

func tween_visibility_disable():
	pass

func get_negative_vector(origin_vector, destination_vector):
	var negative_vector = (destination_vector - origin_vector).tangent().tangent() + origin_vector
	return Vector2(negative_vector.x,negative_vector.y)

func raycast_cast_to(node_name,cell_start,cell_finish):
	var cell_cast_to = Vector2(((cell_finish.x-cell_start.x)*grid_size),((cell_finish.y-cell_start.y)*grid_size))
	node_name.cast_to = Vector2(cell_cast_to.x,cell_cast_to.y)
	node_name.force_raycast_update()

func spawn_text(text_value,text_position:Vector2,color_type:Color,_time_seconds:float):
#	yield(get_tree().create_timer(time_seconds),"timeout")
	var text_data = load("res://Scenes/FloatingText.tscn")
	var text_instance = text_data.instance()
	text_instance.text = text_value
	text_instance.color_type = color_type
	Global.NODE_TEXT.add_child(text_instance)
	text_instance.set_global_position(Vector2((text_position.x+0.5)*Global.grid_size,(text_position.y)*Global.grid_size))
	pass

func disable_target():
	NODE_ANIMATED_SPRITE_TARGET.visible = false

func buff_tick():
	for buff in NODE_BUFFS.get_children():
		if buff.buff_infinite == false:
			buff.buff_duration -= 1
			if buff.buff_duration == 0: 
				buff.buff_on_action_remove()
			else: 
				buff.buff_on_action_tick()
		elif buff.buff_infinite == true:
			buff.buff_on_action_tick()
			pass
		else:
			pass
	Global.LEVEL_LAYER_LOGIC.fog_update()

func buff_add(buff_name,buff_owner):
	var buff_data = load("res://Buffs/%s.tscn" %buff_name)
	var buff_instance = buff_data.instance()
	buff_owner.NODE_BUFFS.add_child(buff_instance)
	buff_instance.buff_owner = buff_owner
	buff_instance.buff_on_action_add()
#	yield(buff_instance,"on_action_finished")

func buff_remove(buff_name,buff_owner):
	buff_owner.NODE_BUFFS.remove_child(buff_name)
	yield(self.get_idle_frame(),"completed")

func get_free_cells_4(mob):
	var mob_position = (mob.position/grid_size)
	var occupied_cells = Global.LEVEL_LAYER_LOGIC.util_get_occupied_cells()
	var mob_nearby_cells = []
	var free_cells = []
	
	for direction in Global.DIRECTION_LIST:
		var cell_vector = mob_position + direction
		var cell_id = Global.LEVEL_LAYER_LOGIC.get_cellv(cell_vector)
		# Check if tile is either FLOOR, ENTRANCE or EXIT
		if cell_id == 0 or cell_id == 4 or cell_id == 5:
			mob_nearby_cells.append(cell_vector)
			pass
		pass
		
	for cell in mob_nearby_cells:
		if occupied_cells.has(cell) == false:
			free_cells.append(cell)
			
	return free_cells

func get_raycast_exceptions(raycast,group):
	var node_to_scan = Global.LEVEL_LAYER_LOGIC
	var node_to_scan_size:int = node_to_scan.get_child_count()
	for i in node_to_scan_size:
		var node_child = node_to_scan.get_child(i)
		if node_child.is_in_group(group) == true:
			raycast.add_exception(node_child)
	pass

func get_raycast_exceptions_by_visibility(raycast):
	var node_to_scan = Global.LEVEL_LAYER_LOGIC
	var node_to_scan_size:int = node_to_scan.get_child_count()
	for i in node_to_scan_size:
		var node_child = node_to_scan.get_child(i)
		if node_child.visible == false:
			raycast.add_exception(node_child)
	pass

func get_animation(a,b):
	randomize()
	var animation = ANIMATIONS.keys()
	animation = animation[rand_range(a,b)]
	return animation

func get_chance(percentage):
	randomize()
	if randi() % 100 <= percentage:  
		return true
	else:                     
		return false

func get_idle_frame():
	yield(get_tree(),"idle_frame")
