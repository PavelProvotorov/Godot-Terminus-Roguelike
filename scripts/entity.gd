extends KinematicBody2D
class_name Entity2D

onready var _level = get_tree().get_first_node_in_group("LEVEL")
onready var _tween_animations = TweenAnimation2D.new(self)
onready var _sprite_animations = SpriteAnimations2D.new(self)
onready var _sprite = $AnimatedSprite
onready var _raycast = $RayCast2D

const DIRECTIONS = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
]

const grid_size:int = 8
var attack_range:int = 0
var damage:int = 0

func set_sprite_direction(start:Vector2, finish:Vector2) -> void:
	var direction = (finish - start)/grid_size
	if direction == Vector2.LEFT: _sprite.flip_h = true
	if direction == Vector2.RIGHT: _sprite.flip_h = false

func get_nearby_entities() -> Array:
	var entities: Array = []
	for direction in DIRECTIONS:
		_raycast.cast_to = direction * grid_size
		_raycast.force_raycast_update()
		
		if _raycast.is_colliding():
			var collider = _raycast.get_collider()
			if collider.is_in_group("ENEMY"):
				entities.append(collider)
	return entities
	
func get_nearby_free_cells() -> Array:
	var cells: Array = []
	var pos: Vector2 = self.position
	
	for direction in DIRECTIONS:
		var cell_to_check = direction * grid_size
		_raycast.cast_to = cell_to_check
		_raycast.force_raycast_update()
		
		if not _raycast.is_colliding():
			cells.append((pos + cell_to_check) / grid_size)
			
	return cells

func is_path_hidden(start:Vector2, finish:Vector2) -> bool:
	return _level.is_fog_cell(start) && _level.is_fog_cell(finish)
	
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
	
func end_turn():
	print("ENDING TURN")
	Events.emit_signal("end_turn", self)
