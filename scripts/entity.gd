extends KinematicBody2D
class_name Entity2D

onready var _level = get_tree().get_first_node_in_group("LEVEL")
onready var _tween_animations = TweenAnimation2D.new(self)
onready var _sprite_animations = SpriteAnimations2D.new(self)
onready var _sprite = $AnimatedSprite

const grid_size:int = 8
var attack_range:int = 0
var damage:int = 0

func set_sprite_direction(start:Vector2, finish:Vector2) -> void:
	var direction = (finish - start)/grid_size
	if direction == Vector2.LEFT: _sprite.flip_h = true
	if direction == Vector2.RIGHT: _sprite.flip_h = false

func is_path_hidden(start:Vector2, finish:Vector2) -> bool:
	return _level.is_fog_cell(start) && _level.is_fog_cell(finish)

func handle_idle(data:Dictionary) -> void:
	Events.emit_signal("end_turn", self)

func handle_movement(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	Events.emit_signal("enemy_moved", start, finish)
	set_sprite_direction(start, finish)
	
	if is_path_hidden(start / grid_size, finish / grid_size):
		self.position = finish
		Events.emit_signal("end_turn", self)
	else:
		_tween_animations.animation_move_to(finish, self, 'position')

func handle_melee_attack(data:Dictionary) -> void:
	self.z_index += 1
	var start = data.start
	var finish = data.finish
	set_sprite_direction(start, finish)
	_tween_animations.animation_melee(start, finish, self, 'position')

func handle_ranged_attack(data:Dictionary) -> void:
	self.z_index += 1
	var start = data.start
	var finish = data.finish
	set_sprite_direction(start, finish)
	_tween_animations.animation_ranged(start, start - ((finish - start) / 2), self, 'position')

func _on_animation_move_finished(tween:SceneTreeTween) -> void:
	if tween.is_running(): printerr("Move tween animation not complete")
	Events.emit_signal("end_turn", self)
	
func _on_animation_ranged_finished(tween:SceneTreeTween) -> void:
	self.z_index -= 1
	if tween.is_running(): printerr("Ranged tween animation not complete")
	Events.emit_signal("end_turn", self)

func _on_animation_melee_finished(tween:SceneTreeTween) -> void:
	self.z_index -= 1
	if tween.is_running(): printerr("Melee tween animation not complete")
	Events.emit_signal("end_turn", self)

func _on_start_turn() -> void:
	Events.emit_signal("end_turn", self)
