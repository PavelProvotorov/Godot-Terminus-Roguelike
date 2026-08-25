extends Entity2D
class_name Player

onready var _inventory:Inventory = get_tree().get_first_node_in_group("INVENTORY")
onready var _composite_animation = $CompositeAnimation
onready var _move_raycast:RayCast2D = $MoveCast
onready var _interact_raycast = $Pickup
onready var _state_machine = $States
onready var _camera = $Camera2D

signal throw_successful(success, impact_position)
signal melee_successful(success, collider)
signal shoot_successful(success, direction)

func _init():
	Events.connect("level_generation_complete", self, "_on_level_generation_complete")
	Events.connect("level_door_opened", self, "_on_level_door_opened")

func _ready():
	_buff_manager.connect("buff_added", self, "_on_buff_added")
	_buff_manager.connect("buff_removed", self, "_on_buff_removed")
	hostile_groups = ["ENEMY"]
	self.health = 10
	self.ammo = 25
	max_health = 10
	max_ammo = 30
	attack_range = 2
	melee_damage = 1
	ranged_damage = 2
	visibility = 4
	
func _process(delta):
	if Input.is_action_just_pressed("ui_read"):
		add_buff('regeneration', 50, true)
		_sprite_animations.add_animation('explosion', self.level, true, self.position)
	pass

func set_camera_limits() -> void:
	var rect = self.level.level_rect
	_camera.limit_left = ((rect.position.x) * grid_size)
	_camera.limit_right = ((rect.end.x) * grid_size)
	_camera.limit_top = ((rect.position.y) * grid_size)
	_camera.limit_bottom = ((rect.end.y) * grid_size)
	
func get_targets_in_range(check_range:int) -> Array:
	
	var visible_range = min(self.visibility, check_range)
	var targets:Array = []
	
	for direction in DIRECTIONS:
		_raycast.cast_to = (direction * visible_range) * grid_size
		_raycast.force_raycast_update()
		
		if _raycast.is_colliding():
			var collider = _raycast.get_collider()
			if collider is Enemy2D:
				targets.append(collider)
	return targets
	
func cast_in_direction(direction:Vector2, cast_range:int):
	var visible_range = min(self.visibility, cast_range)
	
	_raycast.cast_to = (direction * visible_range)
	_raycast.force_raycast_update()
	
	if _raycast.is_colliding():
		return _raycast.get_collider()
	return null

func check_throw_direction(direction:Vector2, throw_range:int) -> bool:
	var collider = cast_in_direction(direction, throw_range)
	
	if collider and collider is Enemy2D:
		emit_signal("throw_successful", true, collider)
		return true
	emit_signal("throw_successful", false, null)
	return false

func check_move_direction(pos: Vector2) -> bool:
	_move_raycast.cast_to = pos
	_move_raycast.force_raycast_update()
	
	if _move_raycast.is_colliding():
		var collider = _move_raycast.get_collider()
		
		if collider.is_in_group("LEVEL"):
			return process_tilemap_collision(self.position + pos)
		
		if collider is Ally:
			var player_pos = self.position
			var ally_pos = collider.position
			
			yield(self.play_move_animation(player_pos, ally_pos), 'completed')
			yield(collider.play_move_animation(ally_pos, player_pos), 'completed')
			
			self.update_position(ally_pos, false)
			collider.update_position(player_pos, false)

			end_turn()
			return true
			
		if collider is Enemy2D:
			var melee_weapon:Item = _inventory.get_melee_weapon()
			if melee_weapon.usable(): melee_weapon.use()
			emit_signal("melee_successful", true, collider)
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
			self.level.open_door(pos)
			return false
		_:
			return false

func handle_movement(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	_audio.play_sound(self.position, Resources.SOUNDS.move)
	yield(play_move_animation(start, finish), 'completed')
	update_position(finish)
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
			
		if parent is Item:
			if _inventory.pickup_item(parent, self):
				return true
			return false
				
	return false

func is_position_occupied() -> bool:
	_interact_raycast.cast_to = Vector2.ZERO
	_interact_raycast.force_raycast_update()
	return _interact_raycast.is_colliding()
	
func state_bind(state:String, caller:Node, callback:String, data:Dictionary) -> void:
	if state == "THROW":
		connect('throw_successful', caller, callback, [], CONNECT_ONESHOT)
	if state == "RANGED":
		connect('shoot_successful', caller, callback, [], CONNECT_ONESHOT)
	_state_machine.change_state(state, data)

func set_ammo(value:int) -> void:
	ammo = value
	Events.emit_signal("player_ammo_changed", value)

func set_health(value:int) -> void:
	health = value
	Events.emit_signal("player_health_changed", value)
	
func is_ammo_depleted() -> bool:
	return self.ammo == 0

func _on_level_generation_complete(level:Level) -> void:
	self.position = level.get_entrance()
	previous_position = self.position
	_camera.reset_smoothing()
	set_camera_limits()
	update_position(self.position)

func _on_level_door_opened() -> void:
	update_fog()

func _on_buffs_changed(buffs:Array) -> void:
	Events.emit_signal("player_buffs_changed", buffs)

func _on_start_turn() -> void:
	if self.speed < 1:
		end_turn()
		return
	_state_machine.change_state('IDLE')

func handle_death() -> void:
	var parent = self.get_parent()
	parent.remove_child(self)
	
func update_fog() -> void:
	self.level.update_level_fog(self.position, self.visibility)

func play_animation(play:bool) -> void:
	if play:
		_composite_animation.play()
	else:
		_composite_animation.stop()

func get_visibility():
	var light_level = self.level.get_light_level()
	var modified_visibility = min(_buff_manager.get_modified_visibility(visibility), light_level)
	return max(min_visibility, modified_visibility)
	
func receive_damage(damage:int, true_damage:bool = false) -> void:
	_audio.play_sound(self.position, Resources.SOUNDS.hit_0)
	.receive_damage(damage, true_damage)
	
func update_position(pos:Vector2, free_previous:bool = true) -> void:
	.update_position(pos, free_previous)
	update_fog()
	
func _on_buff_added() -> void:
	update_fog()
	
func _on_buff_removed() -> void:
	update_fog()
