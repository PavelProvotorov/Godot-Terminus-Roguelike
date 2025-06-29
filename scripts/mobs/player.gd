extends Entity2D

onready var _inventory = get_tree().get_first_node_in_group("INVENTORY")
onready var _state_machine = $States
onready var _camera = $Camera2D
onready var _pickup = $Pickup

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
	health = 100
	attack_range = 2
	melee_damage = 1
	ranged_damage = 2
	visibility = 4
	Events.connect("level_generation_complete", self, "_on_level_generation_complete")
	set_camera_limits()
	
	add_buff('speed')

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
				"finish": (self.position - (-direction)),
				"target": collider
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
				"target": collider
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
			_level.open_door(self.position, pos, visibility)
		_:
			pass

func handle_idle(data:Dictionary) -> void:
	update_fog()
	end_turn()

func handle_movement(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	yield(play_move_animation(start, finish), 'completed')
	update_fog()
	end_turn()

func handle_melee_attack(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	var target = data.target
	target.receive_damage(melee_damage)
	yield(play_melee_animation(start, finish), 'completed')
	end_turn()

func handle_ranged_attack(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	var target = data.target
	set_sprite_direction(start, finish)
	get_tree().call_group("ENEMY", "remove_target_animation")
	target.receive_damage(ranged_damage)
	yield(play_ranged_animation(start, finish), 'completed')
	end_turn()
	
func handle_item_pickup() -> bool:
	_pickup.cast_to = Vector2.ZERO
	_pickup.force_raycast_update()
	
	if _pickup.is_colliding():
		
		var collider = _pickup.get_collider()
		
		if collider.is_in_group("ITEM"):
			_inventory.pickup_item(collider.get_parent(), self)
			end_turn()
			return true
	return false
	
func _on_level_generation_complete(entrance:Vector2) -> void:
	self.position = entrance
	_camera.reset_smoothing()
	update_fog()

func _on_start_turn() -> void:
	_state_machine.change_state('IDLE')
