extends Entity2D
class_name EntityAI

onready var behaviours: Array = []
onready var nearby_free_cells: Array = []
onready var target_visible:bool = false
onready var target = null
onready var path: Array = []
onready var _sprite = $AnimatedSprite
onready var _utility:Utility = Utility.new()
onready var _shadowcaster:BaseShadowcaster = BaseShadowcaster.new(funcref(self.level, 'is_tile_blocking'))

onready var LIFECYCLE = {
	TURN_STARTED = funcref(self, "_turn_started_hook")
}

func _init():
	add_to_group("ENTITY_AI")

func _ready():
	hostile_groups = ["PLAYER", "ALLY"]

func _on_start_turn() -> void:

	if not self.level.node_exists(Global.player):
		return

	select_target()
	check_target_visibility()
	build_path_to_target()

	if not is_active() and not is_stunned() and target_visible:
		set_active(true)

	if _buff_manager.get_modified_speed(self.speed) <= 0:
		return end_turn()

	var hook = _utility.call_lifecycle_hook(LIFECYCLE.TURN_STARTED)
	if hook is GDScriptFunctionState: yield(hook, "completed")

	process_behaviours()

func select_target() -> void:
	
	target = null
	var tree = get_tree()
	var entities:Array = []
	
	for group in hostile_groups:
		entities.append_array(tree.get_nodes_in_group(group))
	
	for entity in entities:
		
		if target == null:
			self.target = entity
		
		var current_target_distance = position.distance_to(target.position)
		var new_target_distance = position.distance_to(entity.position)
		
		if new_target_distance < current_target_distance:
			self.target = entity
			
	print("NEW TARGET: ", target)

func check_target_visibility() -> void:
	
	self.target_visible = false
	
	if target == null:
		return
	
	var visible_cells = _shadowcaster.cast(self.position / grid_size, visibility)
	target_visible = visible_cells.has(target.position / grid_size)
	
func build_path_to_target() -> void:
	path = []
	
	if target == null:
		return
	
	self.level.set_pathfinding_points([], [target.position / grid_size])
	path = (self.level.find_path(self.position, target.position))
	self.level.set_pathfinding_points([target.position / grid_size], [])

func process_behaviours() -> void:
	for i in behaviours:
		var behaviour = i 
#		as BaseBehaviour
		
		assert(behaviour != null, " %s, is not valid behaviour" % behaviour)
		
		if not behaviour.check():
			continue
			
		behaviour.execute()
		return
		
	print("SKIP")
	end_turn()
	
func enemies_near_target() -> Array:
	var target_pos = target.position
	var directions:Array = [
		target_pos + Vector2(0, -1) * grid_size, 
		target_pos + Vector2(0, 1) * grid_size, 
		target_pos + Vector2(-1, 0) * grid_size, 
		target_pos + Vector2(1, 0) * grid_size, 
		target_pos + Vector2(1, 1) * grid_size, 
		target_pos + Vector2(1, -1) * grid_size, 
		target_pos + Vector2(-1, +1) * grid_size, 
		target_pos + Vector2(-1, -1) * grid_size
	]
	var entities:Array = get_tree().get_nodes_in_group("ENTITY")
	var enemies:Array = []
	
	for entity in entities:
		
		if not (entity.position in directions):
			continue
		
		var is_hostile:bool = target.is_entity_hostile(entity)
				
		if not is_hostile:
			continue
		
		enemies.append(entity)
	return enemies

func get_nearby_doors() -> Array:
	var doors: Array = self.level.get_door_cells()
	var nearby_doors: Array = []
	var directions: Array = [
		position + (Vector2.UP * grid_size),
		position + (Vector2.DOWN * grid_size),
		position + (Vector2.LEFT * grid_size),
		position + (Vector2.RIGHT * grid_size)
	]
	
	for door in doors:
		var door_pos = door * grid_size
		if door_pos in directions:
			nearby_doors.append(door_pos) 
	
	return nearby_doors
	
func target_in_sight() -> bool:
	var self_pos = self.position
	var target_pos = target.position
	var direction = self_pos - target_pos
	return direction.x == 0 or direction.y == 0
	
func target_in_range() -> bool:
	return ((path.size()-1) <= attack_range)
	
func target_is_blocked(self_pos: Vector2, target_pos: Vector2) -> bool:
	_raycast.cast_to = target_pos - self_pos
	_raycast.force_raycast_update()
	
	if _raycast.is_colliding():
		var collider = _raycast.get_collider()
		if collider == target:
			return false
	return true

func is_active() -> bool:
	return is_in_group('ACTIVE')
	
func is_wandering() -> bool:
	return is_in_group('WANDERING')

func set_wandering(add:bool) -> void:
	var group_name = 'WANDERING'
	if add:
		add_to_group(group_name)
		return
	
	if get_groups().has(group_name):
		remove_from_group(group_name)
		return

func set_active(add:bool) -> void:
	var group_name = 'ACTIVE'
	if add:
		add_to_group(group_name)
		return
		
	if get_groups().has(group_name):
		remove_from_group(group_name)
		return
		
func is_invisible() -> bool:
	return _sprite.modulate.a == 0

func set_sprite_direction(start:Vector2, finish:Vector2) -> void:
	var direction = (finish - start)/grid_size
	if direction == Vector2.LEFT: _sprite.flip_h = true
	if direction == Vector2.RIGHT: _sprite.flip_h = false
	
func set_random_frame() -> void:
	randomize()
	_sprite.set_frame(rand_range(0,_sprite.get_sprite_frames().get_frame_count("IDLE")))
	_sprite.flip_h = (randi() % 2)
	
func update_pathfinding(prev_pos:Vector2, new_pos:Vector2) -> void:
	previous_position = prev_pos * grid_size
	self.level.set_pathfinding_points([new_pos], [prev_pos])
	
func get_reachable_targets(positions:Array, center:Vector2) -> Array:
	var shadowcast = BaseShadowcaster.new(funcref(self.level, 'is_tile_blocking'))
	var reachable_cells = shadowcast.cast(center / grid_size, 10)
	var entities:Array = get_tree().get_nodes_in_group("ENTITY")
	var targets:Array = []
	
	for entity in entities:
		if (entity.position in positions) and (entity.position / grid_size in reachable_cells):
			targets.append(entity)
	return targets
	
func play_animation(play:bool) -> void:
	if play:
		_sprite.play()
	else:
		_sprite.stop()
