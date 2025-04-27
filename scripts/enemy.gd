extends Entity2D
class_name Enemy2D

onready var _raycast = $RayCast2D
onready var target = get_tree().get_first_node_in_group("PLAYER")
onready var behaviours:Array = []
onready var path:Array = []

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
	"MOVE":{
		"check": funcref(self, "move_behaviour"),
		"handle": funcref(self, "handle_movement"),
		"data": funcref(self, "get_movement_data"),
	},
}

func _ready():
	Events.connect("level_fog_updated", self, "_on_level_fog_updated")
	set_random_frame()

func _on_level_fog_updated(cells:Array) -> void:
	if cells.has(self.position / grid_size) && !(self.is_in_group("ACTIVE")):
		self.add_to_group("ACTIVE")
	pass

func _on_start_turn() -> void:
	path = (_level.find_path(self.position, target.position))
	process_behaviours()

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
		if collider.is_in_group("PLAYER"):
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
	
func process_behaviours():
	for behaviour in behaviours:
		var check = behaviour.get("check")
		if check.call_func():
			var handle = behaviour.get("handle")
			var data = behaviour.get("data")
			if (typeof(data) == TYPE_OBJECT): data = data.call_func()
			handle.call_funcv([data])
			return
	print("SKIP")
	Events.emit_signal("end_turn", self)

func get_melee_data() -> Dictionary:
	return {
		"start": self.position,
		"finish": path[1] * grid_size,
	}

func get_ranged_data() -> Dictionary:
	return {
		"start": self.position,
		"finish": path[1] * grid_size,
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
		return true
	return false

func idle_behaviour() -> bool:
	if path.size() == 0:
		print("IDLE")
		return true
	return false
