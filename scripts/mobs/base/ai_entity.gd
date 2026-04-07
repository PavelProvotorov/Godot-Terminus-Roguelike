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
onready var hostile_groups = ["PLAYER", "ALLY"]

onready var BEHAVIOUR_TYPE = {
	"IDLE": {
		"check": funcref(self, "idle_behaviour"),
		"handle": funcref(self, "handle_idle"),
		"config": {},
	},
	"MELEE": {
		"check": funcref(self, "melee_behaviour"),
		"handle": funcref(self, "handle_melee_attack"),
		"config": {},
	},
	"RANGED": {
		"check": funcref(self, "ranged_behaviour"),
		"handle": funcref(self, "handle_ranged_attack"),
		"config": {},
	},
	"FLEE": {
		"check": funcref(self, "flee_behaviour"),
		"handle": funcref(self, "handle_flee_behaviour"),
		"config": funcref(self, "get_flee_behaviour_config"),
	},
	"AMBUSH":{
		"check": funcref(self, "ambush_behaviour"),
		"handle": funcref(self, "handle_idle"),
		"config": funcref(self, "ambush_behaviour_config"),
	},
	"RALLY": {
		"check": funcref(self, "rally_behaviour"),
		"handle": funcref(self, "handle_rally_behaviour"),
		"config": {},
	},
	"FOLLOW": {
		"check": funcref(self, "follow_behaviour"),
		"handle": funcref(self, "handle_follow_behaviour"),
		"config": funcref(self, "follow_behaviour_config"),
	},
	"WANDER": {
		"check": funcref(self, "wander_behaviour"),
		"handle": funcref(self, "handle_wander_behaviour"),
		"config": {},
	},
	"OPEN_DOOR": {
		"check": funcref(self, "open_door_behaviour"),
		"handle": funcref(self, "handle_open_door_behaviour"),
		"config": {},
	},
	"SPAWNER": {
		"check": funcref(self, "spawner_behaviour"),
		"handle": funcref(self, "handle_spawning"),
		"config": {},
	},
	"MOVE":{
		"check": funcref(self, "move_behaviour"),
		"handle": funcref(self, "handle_movement"),
		"config": {},
	},
}

onready var LIFECYCLE = {
	TURN_STARTED = funcref(self, "_turn_started_hook"),
	POST_MOVEMENT = funcref(self, "_post_movement_hook"),
	POST_RANGED_ATTACK = funcref(self, "_post_ranged_attack_hook"),
	POST_MELEE_ATTACK = funcref(self, "_post_melee_attack_hook"),
	POST_FLEE_HOOK = funcref(self, "_post_flee_hook")
}

func _on_start_turn() -> void:
	
	if not self.level.node_exists(Global.player):
		return
	
	select_target()
	check_target_visibility()
	build_path_to_target()
	
#	if target == null:
#		print("target is null skipping")
#		target_visible = false
#		return end_turn()
	
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
	for behaviour in behaviours:
		var check:FuncRef = behaviour.get("check")
		var handle = behaviour.get("handle")
		var config = behaviour.get("config")
		
		if config is FuncRef and config.is_valid():
			config = config.call_func()
		else:
			config = {}
		
		if not check.is_valid() or not handle.is_valid():
			push_error("Invalid funcrefs for behaviour: " + behaviour)
			continue
		
		if check.call_funcv([config]):
			handle.call_funcv([config])
			return
			
	print("SKIP")
	end_turn()

func melee_behaviour(config:Dictionary) -> bool:
	
	if not is_active():
		return false
		
	if path.size() == 2 and target_in_sight():
		print("MELEE")
		return true
	return false
	
func flee_behaviour(config:Dictionary) -> bool:
	
	if not is_active():
		return false
	
	var health_threshold:int =  config.get("health_threshold", 0)
	var flee_when_close:int = config.get("flee_when_close", false)
	var skip_chance:int = config.get("skip_chance", 0)
		
	if get_chance(skip_chance):
		print("FLEE - SKIP")
		return false
	
	if get_nearby_cells().size() == 0:
		return false
	
	if self.health <= health_threshold:
		print("FLEE - LOW HEALTH")
		return true
	
	if flee_when_close and path.size() == 2 and target_in_sight():
		print("FLEE")
		return true
		
	return false
	
func ranged_behaviour(config:Dictionary) -> bool:
	
	if not is_active():
		return false
		
	if (path.size() > 2) \
	and target_in_range() \
	and target_in_sight() \
	and not target_is_blocked(self.position, target.position):
		print("RANGED")
		return true
	return false

func move_behaviour(config:Dictionary) -> bool:
	
	if not is_active():
		return false
		
	if path.size() > 2 and is_active():
		print("MOVE")
		return true
	return false

func ambush_behaviour(config:Dictionary) -> bool:
	
	if not is_active():
		return false
	
	var enemies:Array = enemies_near_target()
	var close_in:bool = config.get("close_in", false)
	var pack_size:int = config.get("pack_size", 2)
	
	if path.size() != 3:
		return false
	
	if close_in and enemies.size() >= pack_size:
		print("AMBUSH - PACK")
		return false
	
	if not target_in_sight():
		print("AMBUSH")
		return true
	return false
	
func open_door_behaviour(config:Dictionary) -> bool:
	
#	if not is_active() or not is_wandering():
#		return false
		
	if get_nearby_doors().size() > 0:
		print("OPEN DOOR")
		return true
	return false
	
func spawner_behaviour(config:Dictionary) -> bool:
	
	if not is_active():
		return false
		
	if get_nearby_cells().size() >= 1:
		print("SPAWNER")
		return true
	return false

func wander_behaviour(config:Dictionary) -> bool:
	
	if not is_active():
		print("WANDER")
		return true
	return false

func rally_behaviour(config:Dictionary) -> bool:
	
	if not is_active():
		return false
	
	if path.size() == 0 and is_active():
		print("RALLY")
		return true
	return false
	
func follow_behaviour(config:Dictionary) -> bool:
	
	var follower = config.get("follower", null)
	
	if follower == null:
		print("FOLLOWER NULL")
		return false
	
	if not target_visible or path.size() >= 4:
		print("FOLLOW")
		return true
	return false

func idle_behaviour(config:Dictionary) -> bool:
	if path.size() == 0:
		print("IDLE")
		return true
	return false
	
func handle_idle(config:Dictionary) -> void:
	end_turn()

func handle_movement(config:Dictionary) -> void:
	var start = self.position
	var finish = path[1] * grid_size
	
	set_sprite_direction(start, finish)
	
	_audio.play_sound(self.position, Resources.SOUNDS.move)
	
	if not is_invisible() and not is_path_hidden(start / grid_size, finish / grid_size):
		yield(play_move_animation(start, finish), 'completed')
	
	update_position(finish)
	
	var hook = _utility.call_lifecycle_hook(LIFECYCLE.POST_MOVEMENT)
	if hook is GDScriptFunctionState: yield(hook, "completed")
	end_turn()

func handle_melee_attack(config:Dictionary) -> void:
	var start = self.position
	var finish = path[1] * grid_size
	var target = self.target
	
	set_sprite_direction(start, finish)
	target.receive_damage(_buff_manager.get_modified_melee_damage(melee_damage))
	
	if not is_path_hidden(start / grid_size, finish / grid_size):
		yield(play_melee_animation(start, finish), 'completed')
	
	var hook = _utility.call_lifecycle_hook(LIFECYCLE.POST_MELEE_ATTACK)
	if hook is GDScriptFunctionState: yield(hook, "completed")
	end_turn()

func handle_ranged_attack(config:Dictionary) -> void:
	var start = self.position
	var finish = path[1] * grid_size
	var target = self.target
	
	set_sprite_direction(start, finish)
	target.receive_damage(ranged_damage)
	
	if not is_path_hidden(start / grid_size, finish / grid_size):
		yield(play_ranged_animation(start, finish), 'completed')
		
	var hook = _utility.call_lifecycle_hook(LIFECYCLE.POST_RANGED_ATTACK)
	if hook is GDScriptFunctionState: yield(hook, "completed")
	end_turn()

func handle_flee_behaviour(config:Dictionary) -> void:
	var nearby_cells:Array = get_nearby_cells()
	var sorted_cells = nearby_cells
	sorted_cells.sort_custom(self, "sort_by_distance")
	
	if sorted_cells.size() > 0:
		
		var cell = sorted_cells[0]
		var start = position / grid_size
		var finish = cell
		
		if not is_invisible() and not is_path_hidden(start, finish):
			yield(play_move_animation(start * grid_size, finish * grid_size), 'completed')
		
		update_position(finish * grid_size)
		
	var hook = _utility.call_lifecycle_hook(LIFECYCLE.POST_FLEE_HOOK)
	if hook is GDScriptFunctionState: yield(hook, "completed")
	
	end_turn()
	
func handle_open_door_behaviour(config:Dictionary) -> void:
	var nearby_doors:Array = get_nearby_doors()
	var door:Vector2 = nearby_doors.pick_random()
	self.level.open_door(door)
	end_turn()
	
func handle_wander_behaviour(config:Dictionary) -> void:
	var nearby_cells:Array = get_nearby_cells()
	
	
	if nearby_cells.size() > 1:
		nearby_cells.erase(previous_position / grid_size)
	
	if nearby_cells.size() > 0:
		var cell = nearby_cells.pick_random()
		var start = position / grid_size
		var finish = cell
		
		set_sprite_direction(start * grid_size, finish * grid_size)
		
		_audio.play_sound(self.position, Resources.SOUNDS.move)
		
		if not is_invisible() and not is_path_hidden(start, finish):
			yield(play_move_animation(start * grid_size, finish * grid_size), 'completed')

		update_position(finish * grid_size)
	end_turn()

func handle_rally_behaviour(config:Dictionary) -> void:
	var nearby_cells:Array = get_nearby_cells()
	var move_to_cell:Vector2  = self.position / grid_size
	var shortest_distance:int = round((self.position / grid_size).distance_to(target.position / grid_size))
	
	if nearby_cells.size() > 0:
		
		for cell in nearby_cells:
			var distance = cell.distance_to(target.position / grid_size)
			
			if distance < shortest_distance:
				shortest_distance = distance
				move_to_cell = cell
		
		if move_to_cell == self.position / grid_size and shortest_distance > 1:
			move_to_cell = nearby_cells.pick_random()
		
		var start = position / grid_size
		var finish = move_to_cell
		
		set_sprite_direction(start * grid_size, finish * grid_size)
		
		if not is_invisible() and not is_path_hidden(start, finish):
			yield(play_move_animation(start * grid_size, finish * grid_size), 'completed')
		
		update_position(finish * grid_size)
	end_turn()
	
func handle_follow_behaviour(config:Dictionary) -> void:
	var follower = config.get("follower")
	var nearby_cells:Array = get_nearby_cells()
	var move_to_cell:Vector2  = self.position / grid_size
	var shortest_distance:int = round((self.position / grid_size).distance_to(follower.position / grid_size))
	
	if nearby_cells.size() > 0:
		
		for cell in nearby_cells:
			var distance = cell.distance_to(follower.position / grid_size)
			
			if distance < shortest_distance:
				shortest_distance = distance
				move_to_cell = cell
		
		if move_to_cell == self.position / grid_size and shortest_distance > 1:
			move_to_cell = nearby_cells.pick_random()
		
		var start = position / grid_size
		var finish = move_to_cell
		
		set_sprite_direction(start * grid_size, finish * grid_size)
		
		if not is_invisible() and not is_path_hidden(start, finish):
			yield(play_move_animation(start * grid_size, finish * grid_size), 'completed')
		
		update_position(finish * grid_size)
	end_turn()

func handle_spawning(config:Dictionary) -> void:
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
		if (entity.position in directions):
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
	
func play_animation(play:bool) -> void:
	if play:
		_sprite.play()
	else:
		_sprite.stop()
