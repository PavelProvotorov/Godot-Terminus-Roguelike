extends Entity2D
class_name Player

onready var _inventory = get_tree().get_first_node_in_group("INVENTORY")
onready var _composite_animation = $CompositeAnimation
onready var _move_raycast:RayCast2D = $MoveCast
onready var _interact_raycast = $Pickup
onready var _state_machine = $States
onready var _camera = $Camera2D

signal throw_successful

func _init():
	Events.connect("level_generation_complete", self, "_on_level_generation_complete")

func _ready():
	self.health = 99
	self.ammo = 99
	attack_range = 2
	melee_damage = 1
	ranged_damage = 2
	visibility = 4

func set_camera_limits() -> void:
	var rect = self.level.level_rect
	_camera.limit_left = ((rect.position.x) * grid_size)
	_camera.limit_right = ((rect.end.x) * grid_size)
	_camera.limit_top = ((rect.position.y) * grid_size)
	_camera.limit_bottom = ((rect.end.y) * grid_size)
	
func mark_targets_in_range(check_range:int) -> bool:
	var target_marked:bool = false
	
	var modified_visibility = _buff_manager.get_modified_visibility(
		min(visibility, check_range)
	)
	var visible_range = max(min_visibility, modified_visibility)
	
	for direction in DIRECTIONS:
		_raycast.cast_to = (direction * visible_range) * grid_size
		_raycast.force_raycast_update()
		
		if _raycast.is_colliding():
			var collider = _raycast.get_collider()
			if collider.is_in_group("ENEMY"):
				collider.add_target_animation()
				target_marked = true
	return target_marked

func throw_in_direction(direction:Vector2, item:Item) -> bool:
	
	var modified_visibility = _buff_manager.get_modified_visibility(
		min(visibility, item.get_throw_range())
	)
	var visible_range = max(min_visibility, modified_visibility)
	
	_raycast.cast_to = (direction * visible_range)
	_raycast.force_raycast_update()
	
	if _raycast.is_colliding():
		var collider = _raycast.get_collider()
		
		if not collider.is_in_group("ENEMY"):
			return false
			
		var targets = item.get_targets(
			self.position, collider.position
		)
			
		handle_throw_attack(
			self.position, 
			(self.position - (-direction)),
			targets,
			collider.position,
			item
		)
		return true
	return false
	
func shoot_in_direction(direction: Vector2) -> bool:
	var ranged_weapon:Weapon = _inventory.get_ranged_weapon()
	var modified_visibility = _buff_manager.get_modified_visibility(
		min(visibility, ranged_weapon.get_shot_range())
	)
	var visible_range = max(min_visibility, modified_visibility)
	var weapon_shot:bool = false
	
	for idx in ranged_weapon.get_shot_count():

		if is_ammo_depleted():
			break
		
		_raycast.cast_to = (direction * visible_range)
		_raycast.force_raycast_update()
		
		if _raycast.is_colliding():
			var collider = _raycast.get_collider()
			
			if not collider.is_in_group("ENEMY"):
				break
			
			var targets  = ranged_weapon.get_targets(
				self.position,
				collider.position
			)
			self.ammo = ranged_weapon.get_ammo_consumption(self.ammo)
			yield(handle_ranged_attack(position, (position - (-direction)), targets, collider.position), 'completed')
			weapon_shot = true
			
		else: 
			break
			
	if weapon_shot:
		end_turn()
		return true
	return false

func check_move_direction(pos: Vector2) -> bool:
	_move_raycast.cast_to = pos
	_move_raycast.force_raycast_update()
	
	if _move_raycast.is_colliding():
		var collider = _move_raycast.get_collider()
		if collider.is_in_group("LEVEL"):
			return process_tilemap_collision(self.position + pos)
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
	_composite_animation.play_idle_animation()

func set_ranged_animation() -> void:
	_composite_animation.play_ranged_animation()
	
func set_throw_animation() -> void:
	_composite_animation.play_throw_animation()

func set_inventory_animation() -> void:
	_composite_animation.play_inventory_animation()

func flip_animation(flip:bool) -> void:
	_composite_animation.flip_animation(flip)

func process_tilemap_collision(pos:Vector2) -> bool:
	print('COLISSION WITH: ', self.level.get_tile_position_name(pos))
	match self.level.get_tile_position_name(pos):
		"DOOR":
			self.level.open_door(self.position, pos, visibility)
			end_turn()
			return true
		_:
			return false

func handle_idle(data:Dictionary) -> void:
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

func handle_ranged_attack(start:Vector2, finish:Vector2, targets:Array, impact_pos:Vector2) -> GDScriptFunctionState:
	var ranged_weapon:Weapon = _inventory.get_ranged_weapon()
	
	for target in targets:
		
		var offset = target.position.distance_to(impact_pos) / grid_size
		var distance = self.position.distance_to(impact_pos) / grid_size
		
		if target is Entity2D: 
			target.receive_damage(ranged_weapon.get_shot_damage(distance, offset))
			
	return yield(play_ranged_animation(start, finish), 'completed')

func handle_throw_attack(start:Vector2, finish:Vector2, targets:Array, impact_pos:Vector2, item:Item) -> void:
	
	for target in targets:
		
		var offset = target.position.distance_to(impact_pos) / grid_size
		var distance = self.position.distance_to(impact_pos) / grid_size
		
		if target is Entity2D:
			target.receive_damage(item.get_throw_damage(distance, offset))
			
	yield(play_ranged_animation(start, finish), 'completed')
	end_turn()
	
func handle_interaction() -> bool:
	
	if self.level.get_tile_position_name(self.position) == "EXIT":
		Events.emit_signal("level_descended")
		return true
	
	_interact_raycast.cast_to = Vector2.ZERO
	_interact_raycast.force_raycast_update()
	
	if _interact_raycast.is_colliding():
		
		var collider = _interact_raycast.get_collider()
		var parent = collider.get_parent()
		
		if not parent is Item:
			return false

		if parent is Consumable:
			if _inventory.pickup_item_and_use(collider.get_parent(), self):
				return true
			return false
			
		if parent is Item:
			if _inventory.pickup_item(collider.get_parent(), self):
				end_turn()
				return true
			return false
				
	return false

func is_position_occupied() -> bool:
	_interact_raycast.cast_to = Vector2.ZERO
	_interact_raycast.force_raycast_update()
	return _interact_raycast.is_colliding()
	
func throw_state_bind(caller:Node, callback:String, data:Dictionary) -> void:
	connect('throw_successful', caller, callback, [], CONNECT_ONESHOT)
	_state_machine.change_state('THROW', data)
	
func throw_state_notify(success:bool) -> void:
	emit_signal("throw_successful", success)
	
func get_shot_range() -> int:
	var ranged_weapon:Weapon = _inventory.get_ranged_weapon()
	return ranged_weapon.get_shot_range()

func set_ammo(value:int) -> void:
	ammo = value
	Events.emit_signal("player_ammo_changed", value)

func set_health(value:int) -> void:
	health = value
	Events.emit_signal("player_health_changed", value)
	
func is_ammo_depleted() -> bool:
	if self.ammo == 0:
		return true
		
	var ranged_weapon:Weapon = _inventory.get_ranged_weapon()
	if ranged_weapon.get_ammo_consumption(self.ammo) < 0:
		return true
	
	return false

func _on_level_generation_complete(level:Level) -> void:
	self.position = level.get_entrance()
	_camera.reset_smoothing()
	set_camera_limits()
	update_fog()

func _on_start_turn() -> void:
	_state_machine.change_state('IDLE')
