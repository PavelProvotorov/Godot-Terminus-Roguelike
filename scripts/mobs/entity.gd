extends KinematicBody2D
class_name Entity2D

onready var _level = get_tree().get_first_node_in_group("LEVEL")
onready var _text_animations = TextAnimations2D.new(_level)
onready var _tween_animations = TweenAnimation2D.new(self)
onready var _sprite_animations = SpriteAnimations2D.new(self)
onready var _collision_shape:CollisionShape2D = $CollisionShape2D
onready var _buff_manager:BuffManager = $BuffManager
onready var _hit_flash = $HitFlashAnimation
onready var _sprite = $AnimatedSprite
onready var _raycast = $RayCast2D

const DIRECTIONS = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
]

const grid_size:int = 8
var attack_range:int = 1
var melee_damage:int = 1
var ranged_damage:int = 1
var min_visibility:int = 1
var max_health:int = 100
var max_ammo:int = 100
var visibility:int = 2
var health:int = 1 setget set_health
var turn_count:int = 0
var speed:int = 1
var ammo:int = 0 setget set_ammo

func _ready():
	add_to_group("ENTITY")

func set_sprite_direction(start:Vector2, finish:Vector2) -> void:
	var direction = (finish - start)/grid_size
	if direction == Vector2.LEFT: _sprite.flip_h = true
	if direction == Vector2.RIGHT: _sprite.flip_h = false
	
func get_nearby_cells() -> Array:
	var nearby_cells:Array = []
	var free_cells = _level.get_free_cells() 
	
	for direction in DIRECTIONS:
		var cell = (position / grid_size) + direction
		if free_cells.has(cell):
			nearby_cells.append(cell)
			
	return nearby_cells

func get_hidden_free_cells() -> Array:
	return _level.get_hidden_free_cells()

func is_path_hidden(start:Vector2, finish:Vector2) -> bool:
	return _level.is_fog_cell(start) && _level.is_fog_cell(finish)
	
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

func play_appear_animation() -> GDScriptFunctionState:
	return yield(_tween_animations.animation_appear(_sprite), 'completed')

func receive_damage(damage:int) -> void:
	play_hit_animation()
	var resisted_damage:int = max(0, _buff_manager.get_resisted_damage(damage))
	self.health -= resisted_damage
	if health <= 0:
		_text_animations.display_damage_number(resisted_damage, position, true)
		handle_death()
	else:
		_text_animations.display_damage_number(resisted_damage, position, false)
		
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
	play_hit_animation()
	_level.set_pathfinding_points([], [self.position / grid_size])
	self.queue_free()
	
func add_buff(buff:String) -> bool:
	return _buff_manager.add_buff(buff)
	
func update_fog() -> void:
	var modified_visibility = _buff_manager.get_modified_visibility(visibility)
	_level.update_level_fog(self.position, max(min_visibility, modified_visibility))
	
func end_turn() -> bool:
	print("USED TURN")
	turn_count += 1

	if  turn_count < _buff_manager.get_modified_speed(speed):
		print("EXTRA TURN")
		_on_start_turn()
		return false
		
	print("ENDING TURN")
	turn_count = 0
	_buff_manager.tick_buffs()
	Events.emit_signal("end_turn", self)
	return true

func get_chance(percentage:int) -> bool:
  return percentage > 0 and randi() % 100 < percentage

func get_attack_range():
	return attack_range

func _on_start_turn():
	pass

func set_ammo(value:int) -> void:
	ammo = value

func set_health(value:int) -> void:
	health = value
