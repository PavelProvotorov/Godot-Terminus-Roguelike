extends Entity2D
class_name Enemy2D

onready var target = Global.get_player()
onready var behaviours: Array = []
onready var nearby_free_cells: Array = []
onready var path: Array = []
onready var spawn: bool = false
onready var _sprite = $AnimatedSprite
onready var previous_position: Vector2 = position
onready var _utility:Utility = Utility.new()

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

func _ready():
	Events.connect("level_fog_updated", self, "_on_level_fog_updated")
	set_random_frame()

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
	
func play_appear_animation() -> GDScriptFunctionState:
	return yield(_tween_animations.animation_appear(_sprite), 'completed')
	
func add_target_animation() -> void:
	_sprite_animations.add_animation("target")
	
func remove_target_animation() -> void:
	_sprite_animations.remove_animation("target")
	
func set_random_frame() -> void:
	randomize()
	_sprite.set_frame(rand_range(0,_sprite.get_sprite_frames().get_frame_count("IDLE")))
	_sprite.flip_h = (randi() % 2)
	
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
			handle.call_func()
			return
			
	print("SKIP")
	end_turn()

func melee_behaviour(config:Dictionary) -> bool:
	if path.size() == 2 and target_in_sight():
		print("MELEE")
		return true
	return false
	
func flee_behaviour(config:Dictionary) -> bool:
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
	if (path.size() > 2) \
	and target_in_range() \
	and target_in_sight() \
	and not target_is_blocked(self.position, target.position):
		print("RANGED")
		return true
	return false

func move_behaviour(config:Dictionary) -> bool:
	if path.size() > 2:
		print("MOVE")
		return true
	return false

func ambush_behaviour(config:Dictionary) -> bool:
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
	print("Nearby doors count: ", get_nearby_doors().size())
	if get_nearby_doors().size() > 0:
		print("OPEN DOOR")
		return true
	return false
	
func spawner_behaviour(config:Dictionary) -> bool:
	if get_nearby_cells().size() >= 1:
		print("SPAWNER")
		return true
	return false

func wander_behaviour(config:Dictionary) -> bool:
	if is_in_group("WANDERING"):
		print("WANDER")
		return true
	return false

func rally_behaviour(config:Dictionary) -> bool:
	if path.size() == 0:
		print("RALLY")
		return true
	return false

func idle_behaviour(config:Dictionary) -> bool:
	if path.size() == 0:
		print("IDLE")
		return true
	return false

func handle_idle() -> void:
	end_turn()

func handle_movement() -> void:
	var start = self.position
	var finish = path[1] * grid_size
	
	set_sprite_direction(start, finish)
	
	if is_invisible() or is_path_hidden(start / grid_size, finish / grid_size):
		self.position = finish
	else:
		yield(play_move_animation(start, finish), 'completed')
	
	update_pathfinding(start / grid_size, finish / grid_size)
	
	var hook = _utility.call_lifecycle_hook(LIFECYCLE.POST_MOVEMENT)
	if hook is GDScriptFunctionState: yield(hook, "completed")
	end_turn()
	
func update_pathfinding(prev_pos:Vector2, new_pos:Vector2) -> void:
	previous_position = prev_pos
	self.level.set_pathfinding_points([new_pos], [prev_pos])

func handle_melee_attack() -> void:
	var start = self.position
	var finish = path[1] * grid_size
	var target = self.target
	
	set_sprite_direction(start, finish)
	target.receive_damage(_buff_manager.get_modified_melee_damage(melee_damage))
	yield(play_melee_animation(start, finish), 'completed')
	var hook = _utility.call_lifecycle_hook(LIFECYCLE.POST_MELEE_ATTACK)
	if hook is GDScriptFunctionState: yield(hook, "completed")
	end_turn()

func handle_ranged_attack() -> void:
	var start = self.position
	var finish = path[1] * grid_size
	var target = self.target
	
	set_sprite_direction(start, finish)
	target.receive_damage(ranged_damage)
	yield(play_ranged_animation(start, finish), 'completed')
	var hook = _utility.call_lifecycle_hook(LIFECYCLE.POST_RANGED_ATTACK)
	if hook is GDScriptFunctionState: yield(hook, "completed")
	end_turn()
	
func handle_flee_behaviour() -> void:
	var nearby_cells:Array = get_nearby_cells()
	var sorted_cells = nearby_cells
	sorted_cells.sort_custom(self, "sort_by_distance")
	
	if sorted_cells.size() > 0:
		
		var cell = sorted_cells[0]
		var start = position / grid_size
		var finish = cell
		
		if is_invisible() or is_path_hidden(start, finish):
			self.position = finish * grid_size
		else:
			yield(play_move_animation(start * grid_size, finish * grid_size), 'completed')
		
		update_pathfinding(start, finish)
		
	var hook = _utility.call_lifecycle_hook(LIFECYCLE.POST_FLEE_HOOK)
	if hook is GDScriptFunctionState: yield(hook, "completed")
	
	end_turn()
	
func handle_open_door_behaviour() -> void:
	var nearby_doors:Array = get_nearby_doors()
	var door:Vector2 = nearby_doors.pick_random()
	self.level.open_door(door)
	end_turn()
	
func sort_by_distance(a, b) -> bool:
	var pos:Vector2 = target.position / grid_size
	return a.distance_to(pos) > b.distance_to(pos)
	
func handle_wander_behaviour() -> void:
	var nearby_cells:Array = get_nearby_cells()
	nearby_cells.erase(previous_position / grid_size)
	
	if nearby_cells.size() > 0:
		
		var cell = nearby_cells.pick_random()
		var start = position / grid_size
		var finish = cell
		
		if is_invisible() or is_path_hidden(start, finish):
			self.position = finish * grid_size
		else:
			yield(play_move_animation(start * grid_size, finish * grid_size), 'completed')
		
		update_pathfinding(start, finish)
	end_turn()

func handle_rally_behaviour() -> void:
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
		
		if is_invisible() or is_path_hidden(start, finish):
			self.position = finish * grid_size
		else:
			yield(play_move_animation(start * grid_size, finish * grid_size), 'completed')
		
		update_pathfinding(start, finish)
	end_turn()

func handle_spawning() -> void:
	end_turn()
	
func minion_spawn_and_move(instance:KinematicBody2D, start:Vector2, finish:Vector2) -> void:
	instance.set_active()
	self.level.spawn_enemy(start / grid_size, instance)
	yield(instance.play_move_animation(Vector2.ZERO, finish), 'completed')
	update_pathfinding(finish / grid_size, finish / grid_size)
	
func _on_level_fog_updated(cells:Array) -> void:
	if cells.has(self.position / grid_size) && not (self.is_in_group("ACTIVE")):
		self.set_active()
	
	if cells.has(self.position / grid_size) && (self.is_in_group("WANDERING")):
		self.remove_from_group("WANDERING")

func _on_start_turn() -> void:
	
	if not self.level.node_exists(target):
		return
		
	path = (self.level.find_path(self.position, target.position))
	var hook = _utility.call_lifecycle_hook(LIFECYCLE.TURN_STARTED)
	if hook is GDScriptFunctionState: yield(hook, "completed")
	process_behaviours()
	
func set_sprite_direction(start:Vector2, finish:Vector2) -> void:
	var direction = (finish - start)/grid_size
	if direction == Vector2.LEFT: _sprite.flip_h = true
	if direction == Vector2.RIGHT: _sprite.flip_h = false
	
func setup():
	if behaviours.has(BEHAVIOUR_TYPE.WANDER): add_to_group("WANDERING")
	
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

func is_invisible() -> bool:
	return _sprite.modulate.a == 0

func is_active() -> bool:
	return is_in_group('ACTIVE')

func set_active() -> void:
	add_to_group('ACTIVE')

