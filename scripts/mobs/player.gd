extends Entity2D
class_name Player

onready var _inventory = get_tree().get_first_node_in_group("INVENTORY")
onready var _state_machine = $States
onready var _camera = $Camera2D
onready var _pickup = $Pickup

const ANIMATION = {
	IDLE = 'IDLE',
	RANGED = 'RANGED',
	THROW = 'THROW'
}
enum STATE {
	IDLE,
	ACTIVE,
	RANGED,
	MELEE,
	THROW
}

signal throw_successful

func _ready():
	health = 100
	attack_range = 2
	melee_damage = 1
	ranged_damage = 2
	visibility = 4
	Events.connect("level_generation_complete", self, "_on_level_generation_complete")
	set_camera_limits()

func set_camera_limits() -> void:
	var rect = _level.level_rect
	_camera.limit_left = ((rect.position.x) * grid_size)
	_camera.limit_right = ((rect.end.x) * grid_size)
	_camera.limit_top = ((rect.position.y) * grid_size)
	_camera.limit_bottom = ((rect.end.y) * grid_size)
	
func check_targets_in_range(check_range:int) -> void:
	
	var modified_visibility = _buff_manager.get_modified_visibility(visibility)
	var visible_range = min(
		max(min_visibility, modified_visibility), 
		check_range
	)
	
	for direction in DIRECTIONS:
		_raycast.cast_to = (direction * visible_range) * grid_size
		_raycast.force_raycast_update()
		
		if _raycast.is_colliding():
			var collider = _raycast.get_collider()
			if collider.is_in_group("ENEMY"):
				collider.add_target_animation()
				
func throw_in_direction(direction:Vector2, throw_range:int, throw_damage:int) -> bool:
	
	var modified_visibility = _buff_manager.get_modified_visibility(visibility)
	var visible_range = min(
		max(min_visibility, modified_visibility), 
		throw_range
	)
	
	_raycast.cast_to = (direction * visible_range)
	_raycast.force_raycast_update()
	
	if _raycast.is_colliding():
		var collider = _raycast.get_collider()
		if collider.is_in_group("ENEMY"):
			handle_throw_attack({
				"start": self.position,
				"finish": (self.position - (-direction)),
				"target": collider,
				"throw_damage": throw_damage
			})
			return true
	return false
	
func shoot_in_direction(direction: Vector2) -> bool:
	
	var modified_visibility = _buff_manager.get_modified_visibility(visibility)
	var visible_range = min(
		max(min_visibility, modified_visibility), 
		attack_range
	)
	
	_raycast.cast_to = (direction * visible_range)
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
	
func set_throw_animation() -> void:
	_sprite.set_animation(ANIMATION.THROW)

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
	target.receive_damage(_buff_manager.get_modified_melee_damage(melee_damage))
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

func handle_throw_attack(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	var target = data.target
	set_sprite_direction(start, finish)
	get_tree().call_group("ENEMY", "remove_target_animation")
	target.receive_damage(data.get('throw_damage', 0))
	yield(play_ranged_animation(start, finish), 'completed')
	end_turn()
	
func handle_item_pickup() -> bool:
	_pickup.cast_to = Vector2.ZERO
	_pickup.force_raycast_update()
	
	if _pickup.is_colliding():
		
		var collider = _pickup.get_collider()
		
		if collider.is_in_group("ITEM") and collider.is_in_group('CONSUMABLE'):
			_inventory.pickup_item(collider.get_parent(), self)
			end_turn()
			return true
		
		if collider.is_in_group("ITEM") and collider.is_in_group('INSTANT'):
			_inventory.pickup_item_and_use(collider.get_parent(), self)
			end_turn()
			return true
	return false
	
func throw_state_bind(caller:Node, callback:String, data:Dictionary) -> void:
	connect('throw_successful', caller, callback, [], CONNECT_ONESHOT)
	_state_machine.change_state('THROW', data)
	
func throw_state_notify(success:bool) -> void:
	print("Notifying about throw state")
	emit_signal("throw_successful", success)

func _on_level_generation_complete(entrance:Vector2) -> void:
	self.position = entrance
	_camera.reset_smoothing()
	update_fog()

func _on_start_turn() -> void:
	_state_machine.change_state('IDLE')
