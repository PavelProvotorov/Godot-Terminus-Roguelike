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
		"data": {},
	},
	"MELEE": {
		"check": funcref(self, "melee_behaviour"),
		"handle": funcref(self, "handle_melee_attack"),
		"data": funcref(self, "get_melee_data"),
	},
	"RANGED": {
		"check": funcref(self, "ranged_behaviour"),
		"handle": funcref(self, "handle_ranged_attack"),
		"data": funcref(self, "get_ranged_data"),
	},
	"AMBUSH":{
		"check": funcref(self, "ambush_behaviour"),
		"handle": funcref(self, "handle_idle"),
		"data": {},
	},
	"RALLY": {
		"check": funcref(self, "rally_behaviour"),
		"handle": funcref(self, "handle_rally_behaviour"),
		"data": {},
	},
	"WANDER": {
		"check": funcref(self, "wander_behaviour"),
		"handle": funcref(self, "handle_wander_behaviour"),
		"data": {},
	},
	"SPAWNER": {
		"check": funcref(self, "spawner_behaviour"),
		"handle": funcref(self, "handle_spawning"),
		"data": {},
	},
	"MOVE":{
		"check": funcref(self, "move_behaviour"),
		"handle": funcref(self, "handle_movement"),
		"data": funcref(self, "get_movement_data"),
	},
}

onready var LIFECYCLE = {
	TURN_STARTED = funcref(self, "_turn_started_hook"),
	POST_MOVEMENT = funcref(self, "_post_movement_hook"),
	POST_RANGED_ATTACK = funcref(self, "_post_ranged_attack_hook"),
	POST_MELEE_ATTACK = funcref(self, "_post_melee_attack_hook"),
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
		var check = behaviour.get("check")
		if check.call_func():
			var handle = behaviour.get("handle")
			var data = behaviour.get("data")
			if (typeof(data) == TYPE_OBJECT): data = data.call_func()
			handle.call_funcv([data])
			return
	print("SKIP")
	end_turn()

func get_melee_data() -> Dictionary:
	return {
		"start": self.position,
		"finish": path[1] * grid_size,
		"target": target
	}

func get_ranged_data() -> Dictionary:
	return {
		"start": self.position,
		"finish": path[1] * grid_size,
		"target": target
	}

func get_movement_data() -> Dictionary:
	return {
		"start": self.position,
		"finish": path[1] * grid_size,
	}

func melee_behaviour() -> bool:
	if path.size() == 2 and target_in_sight():
		print("MELEE")
		return true
	return false

func ranged_behaviour() -> bool:
	if (path.size() > 2) \
	and target_in_range() \
	and target_in_sight() \
	and not target_is_blocked(self.position, target.position):
		print("RANGED")
		return true
	return false

func move_behaviour() -> bool:
	if path.size() > 2:
		print("MOVE")
		return true
	return false

func ambush_behaviour() -> bool:
	if path.size() == 3 and !target_in_sight():
		print("AMBUSH")
		return true
	return false
	
func spawner_behaviour() -> bool:
	if get_nearby_cells().size() >= 1:
		print("SPAWNER")
		return true
	return false

func wander_behaviour() -> bool:
	if is_in_group("WANDERING"):
		print("WANDER")
		return true
	return false

func rally_behaviour() -> bool:
	if path.size() == 0:
		print("RALLY")
		return true
	return false

func idle_behaviour() -> bool:
	if path.size() == 0:
		print("IDLE")
		return true
	return false

func handle_idle(data:Dictionary) -> void:
	end_turn()

func handle_movement(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	
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

func handle_melee_attack(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	var target = data.target
	set_sprite_direction(start, finish)
	target.receive_damage(_buff_manager.get_modified_melee_damage(melee_damage))
	yield(play_melee_animation(start, finish), 'completed')
	var hook = _utility.call_lifecycle_hook(LIFECYCLE.POST_MELEE_ATTACK)
	if hook is GDScriptFunctionState: yield(hook, "completed")
	end_turn()

func handle_ranged_attack(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	var target = data.target
	set_sprite_direction(start, finish)
	target.receive_damage(ranged_damage)
	yield(play_ranged_animation(start, finish), 'completed')
	var hook = _utility.call_lifecycle_hook(LIFECYCLE.POST_RANGED_ATTACK)
	if hook is GDScriptFunctionState: yield(hook, "completed")
	end_turn()
	
func handle_wander_behaviour(data:Dictionary) -> void:
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

func handle_rally_behaviour(data:Dictionary) -> void:
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

func handle_spawning(data:Dictionary) -> void:
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

func is_invisible() -> bool:
	return _sprite.modulate.a == 0

func is_active() -> bool:
	return is_in_group('ACTIVE')

func set_active() -> void:
	add_to_group('ACTIVE')
