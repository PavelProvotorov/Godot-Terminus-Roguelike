extends Entity2D
class_name Enemy2D

onready var target = get_tree().get_first_node_in_group("PLAYER")
onready var behaviours: Array = []
onready var nearby_free_cells: Array = []
onready var path: Array = []
onready var spawn: bool = false

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

func _ready():
	Events.connect("level_fog_updated", self, "_on_level_fog_updated")
	set_random_frame()

func target_in_sight(self_pos: Vector2, target_pos: Vector2) -> bool:
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
	if path.size() == 2 and target_in_sight(self.position, target.position):
		print("MELEE")
		return true
	return false

func ranged_behaviour() -> bool:
	if (path.size() > 2) \
	and target_in_range() \
	and target_in_sight(self.position, target.position) \
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
	if path.size() == 3 and !target_in_sight(self.position, target.position):
		print("AMBUSH")
		return true
	return false
	
func spawner_behaviour() -> bool:
	if get_nearby_cells().size() >= 1:
		print("SPAWNER")
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
	
	if is_path_hidden(start / grid_size, finish / grid_size):
		self.position = finish
	else:
		yield(play_move_animation(start, finish), 'completed')
	
	post_handle_movement({
		"prev_pos": start / grid_size,
		"new_pos": finish / grid_size,
	})
	end_turn()
	
func post_handle_movement(data:Dictionary) -> void:
	_level.set_pathfinding_points(
		[data.get('new_pos', Vector2.ZERO)],
		[data.get('prev_pos', Vector2.ZERO)]
	)

func handle_melee_attack(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	var target = data.target
	set_sprite_direction(start, finish)
	target.receive_damage(_buff_manager.get_modified_melee_damage(melee_damage))
	yield(play_melee_animation(start, finish), 'completed')
	end_turn()

func handle_ranged_attack(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	var target = data.target
	set_sprite_direction(start, finish)
	target.receive_damage(ranged_damage)
	yield(play_ranged_animation(start, finish), 'completed')
	end_turn()

func handle_spawning(data:Dictionary) -> void:
	end_turn()
	
func minion_spawn_and_move(instance:KinematicBody2D, start:Vector2, finish:Vector2) -> void:
	instance.add_to_group("ACTIVE")
	_level.spawn_enemy(start / grid_size, instance)
	yield(instance.play_move_animation(Vector2.ZERO, finish), 'completed')
	post_handle_movement({
		"prev_pos": finish / grid_size,
		"new_pos": finish / grid_size,
	})
	
func _on_level_fog_updated(cells:Array) -> void:
	if cells.has(self.position / grid_size) && !(self.is_in_group("ACTIVE")):
		self.add_to_group("ACTIVE")
	pass

func _on_start_turn() -> void:
	path = (_level.find_path(self.position, target.position))
	process_behaviours()
