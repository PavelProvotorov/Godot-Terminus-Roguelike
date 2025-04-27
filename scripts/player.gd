extends Entity2D

onready var _state_machine = $States
onready var _camera = $Camera2D

const visibility = 4
const ANIMATION = {
	IDLE = 'IDLE',
	RANGED = 'RANGED'
}
enum STATE {
	IDLE,
	ACTIVE,
	RANGED,
	MELEE,
	THROW
}

func _ready():
	attack_range = 2
	damage = 2
	Events.connect("level_generation_complete", self, "_on_level_generation_complete")
	set_camera_limits()

func set_camera_limits() -> void:
	var rect = _level.level_rect
	_camera.limit_left = ((rect.position.x) * grid_size)
	_camera.limit_right = ((rect.end.x) * grid_size)
	_camera.limit_top = ((rect.position.y) * grid_size)
	_camera.limit_bottom = ((rect.end.y) * grid_size)
	
func check_targets_in_range() -> void:
	for direction in DIRECTIONS:
		_raycast.cast_to = (direction * attack_range) * grid_size
		_raycast.force_raycast_update()
		
		if _raycast.is_colliding():
			var collider = _raycast.get_collider()
			if collider.is_in_group("ENEMY"):
				collider.add_target_animation()
	
func shoot_in_direction(direction: Vector2) -> bool:
	_raycast.cast_to = (direction * attack_range)
	_raycast.force_raycast_update()
	
	if _raycast.is_colliding():
		var collider = _raycast.get_collider()
		if collider.is_in_group("ENEMY"):
			handle_ranged_attack({
				"start": self.position,
				"finish": (self.position - (-direction))
			})
			return true
	return false

func check_move_direction(pos: Vector2) -> bool:
	_raycast.cast_to = pos
	_raycast.force_raycast_update()
	
	if _raycast.is_colliding():
		var collider = _raycast.get_collider()
		if collider.is_in_group("LEVEL"):
			process_tilemap_collision(self.position + pos)
		elif collider.is_in_group("ENEMY"):
			handle_melee_attack({
				"start": self.position, 
				"finish": collider.position,
			})
			return true
	else:
		handle_movement({
			"start": self.position, 
			"finish": self.position + pos,
		})
		return true
	return false

func set_idle_animation() -> void:
	_sprite.set_animation(ANIMATION.IDLE)

func set_ranged_animation() -> void:
	_sprite.set_animation(ANIMATION.RANGED)

func process_tilemap_collision(pos:Vector2) -> void:
	print(_level.get_tile_position_name(pos))
	match _level.get_tile_position_name(pos):
		"DOOR":
			Events.emit_signal("level_door_open", self.position, pos, visibility)
		_:
			pass

func handle_idle(data:Dictionary) -> void:
	Events.emit_signal("player_moved", self.position, visibility)
	Events.emit_signal("end_turn", self)

func handle_movement(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	_tween_animations.animation_move_to(finish, self, 'position')

func handle_melee_attack(data:Dictionary) -> void:
	self.z_index += 1
	var start = data.start
	var finish = data.finish
	_tween_animations.animation_melee(start, finish, self, 'position')

func handle_ranged_attack(data:Dictionary) -> void:
	self.z_index += 1
	var start = data.start
	var finish = data.finish
	set_sprite_direction(start, finish)
	get_tree().call_group("ENEMY", "remove_target_animation")
	_tween_animations.animation_ranged(start, start - ((finish - start) / 2), self, 'position')
	
func _on_level_generation_complete(entrance:Vector2) -> void:
	self.position = entrance
	_camera.reset_smoothing()
	Events.emit_signal("player_moved", self.position, visibility)
	
func _on_animation_move_finished(tween:SceneTreeTween) -> void:
	if tween.is_running(): printerr("Move tween animation not complete")
	Events.emit_signal("player_moved", self.position, visibility)
	Events.emit_signal("end_turn", self)
	
func _on_animation_ranged_finished(tween:SceneTreeTween) -> void:
	self.z_index -= 1
	if tween.is_running(): printerr("Ranged tween animation not complete")
	Events.emit_signal("player_ranged_attack", self.position, visibility)
	Events.emit_signal("end_turn", self)

func _on_animation_melee_finished(tween:SceneTreeTween) -> void:
	self.z_index -= 1
	if tween.is_running(): printerr("Melee tween animation not complete")
	Events.emit_signal("player_melee_attack", self.position, visibility)
	Events.emit_signal("end_turn", self)

func _on_start_turn() -> void:
	_state_machine.change_state('IDLE')
