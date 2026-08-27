extends KinematicBody2D
class_name Entity2D

onready var level setget set_level, get_level
onready var _audio:Audio2D = Audio2D.new()
onready var _text_animations = TextAnimations2D.new()
onready var _tween_animations = TweenAnimation2D.new(self)
onready var _sprite_animations = SpriteAnimations2D.new()
onready var _collision_shape:CollisionShape2D = $CollisionShape2D
onready var _buff_manager:BuffManager = $BuffManager
onready var _hit_flash = $HitFlashAnimation
onready var _raycast = $RayCast2D
onready var previous_position = position
onready var hostile_groups = []

signal start_turn

const DIRECTIONS = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
]

const grid_size:int = 8
var attack_range:int = 1
var melee_damage:int = 1 setget , get_melee_damage
var ranged_damage:int = 1 setget , get_ranged_damage
var min_visibility:int = 1
var max_health:int = 100
var max_ammo:int = 100
var visibility:int = 4 setget , get_visibility
var health:int = 1 setget set_health, get_health
var turn_count:int = 0
var speed:int = 1 setget , get_speed
var ammo:int = 0 setget set_ammo

func _ready():
	connect("start_turn", self, "_on_start_turn")
	_buff_manager.init(funcref(self, "_on_buffs_changed"))
	add_to_group("ENTITY")
	
func get_nearby_cells() -> Array:
	var nearby_cells:Array = []
	var free_cells = self.level.get_entity_free_cells() 
	
	for direction in DIRECTIONS:
		var cell = (position / grid_size) + direction
		if free_cells.has(cell):
			nearby_cells.append(cell)
			
	return nearby_cells

func get_hidden_free_cells() -> Array:
	return self.level.get_hidden_free_cells()

func is_path_hidden(start:Vector2, finish:Vector2) -> bool:
	return self.level.is_fog_cell(start) && self.level.is_fog_cell(finish)
	
func play_hit_animation() -> void:
	_hit_flash.play("RESET")
	_hit_flash.advance(0)
	_hit_flash.play('hit')
	
func play_move_animation(start:Vector2, finish:Vector2) -> void:
	self.z_index += 1
	yield(_tween_animations.animation_move_to(finish, self, 'position'), 'completed')
	self.z_index -= 1

func play_melee_animation(start:Vector2, finish:Vector2) -> void:
	self.z_index += 1
	yield(_tween_animations.animation_melee(start, finish, self, 'position'), 'completed')
	self.z_index -= 1

func play_ranged_animation(start:Vector2, finish:Vector2) -> void:
	self.z_index += 1
	var half = start - ((finish - start) / 2)
	yield(_tween_animations.animation_ranged(start, half, self, 'position'), 'completed')
	self.z_index -= 1

func receive_damage(damage:int, true_damage:bool = false) -> int:
	play_hit_animation()
	
	var received_damage:int = 0
	
	if true_damage:
		received_damage = damage
	else:
		var resisted_damage:int = max(0, _buff_manager.get_resisted_damage(damage))
		received_damage = resisted_damage
		
	self.health -= received_damage
	
	if health <= 0:
		_text_animations.display_damage_number(received_damage, position, true)
		handle_death()
	else:
		_text_animations.display_damage_number(received_damage, position, false)
	return received_damage
		
func restore_health(heal:int) -> bool:
	if (health != max_health):
		var value = min(heal, max_health - health)
		self.health += value
		_text_animations.display_heal_number(value, position)
		return true
	return false
	
func recharge_ammo(recharge:int) -> bool:
	if (ammo != max_ammo):
		var value = min(recharge, max_ammo - ammo)
		self.ammo += value
		_text_animations.display_recharge_number(value, position)
		return true
	return false

func handle_death() -> void:
	var parent = self.get_parent()
	if parent:
		parent.remove_child(self)
		
	self.level.set_pathfinding_points([], [self.position / grid_size])
	self.queue_free()
	
func add_buff(buff:String, duration:int, self_applied:bool=false) -> bool:
	return _buff_manager.add_buff(buff, duration, self_applied)

func remove_buff(buff:String) -> bool:
	return _buff_manager.remove_buff(buff)
	
func update_position(new_position:Vector2, free_previous:bool = true) -> void:
	var disable_points = [new_position / grid_size]
	var enable_points = [previous_position / grid_size]
	
	if not free_previous:
		enable_points = []
		
	self.level.set_pathfinding_points(
		disable_points, 
		enable_points
	)
	
	previous_position = new_position
	self.position = new_position

func end_turn() -> bool:
	print("USED TURN: ", self)
	turn_count += 1

	if turn_count < self.speed:
		print("EXTRA TURN: ", self)
		_on_start_turn()
		return false
		
	turn_count = 0
	
	var buffs = _buff_manager.tick_buffs()
	
	if buffs is GDScriptFunctionState:
		yield(buffs, "completed")
	
	print("ENDING TURN: ", self)
	Events.emit_signal("end_turn", self)
	return true

func get_chance(percentage:int) -> bool:
  return percentage > 0 and randi() % 100 < percentage

func get_attack_range():
	return attack_range

func _on_start_turn():
	pass
	
func is_max_health():
	return health == max_health

func set_ammo(value:int) -> void:
	ammo = value

func set_health(value:int) -> void:
	health = value

func set_level(level):
	return level
	
func _on_buffs_changed(buffs:Array) -> void:
	pass

func get_visibility():
	var modified_visibility = _buff_manager.get_modified_visibility(visibility)
	return max(min_visibility, modified_visibility)

func get_level():
	return Global.get_level()

func is_shielded() -> bool:
	return _buff_manager.is_shielded()

func is_stunned() -> bool:
	return _buff_manager.is_stunned()
	
func is_entity_hostile(entity:Entity2D) -> bool:
	for group in hostile_groups:
		if entity.is_in_group(group):
			return true
	return false
	
func get_speed() -> int:
	return _buff_manager.get_modified_speed(speed)
	
func get_health() -> int:
	return health
	
func get_ranged_damage() -> int:
	return _buff_manager.get_modified_ranged_damage(ranged_damage)
	
func get_melee_damage() -> int:
	return _buff_manager.get_modified_melee_damage(melee_damage)
