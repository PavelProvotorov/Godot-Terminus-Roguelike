extends Item

var rng = RandomNumberGenerator.new()

const damage:int = 4

func _init():
	category = CATEGORY.RANGED_WEAPON
	action = ShootItem.new(self, {
		"get_damage": funcref(self, "get_damage"),
		"get_targets": funcref(self, "get_targets"),
		"sfx": Resources.SOUNDS.shot_shotgun,
		"consumption": 1,
		"range": 1,
		"shots": 1,
	})
	
func _ready():
	rng.randomize()

func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var direction = origin_pos.direction_to(impact_pos)
	var forward_cell = (impact_pos + (direction * grid_size))
	var targets:Array = []

	var left = Vector2(-direction.y, direction.x)
	var right = Vector2(direction.y, -direction.x)

	var positions = [
		impact_pos,
		forward_cell,
		forward_cell + left * grid_size,
		forward_cell + right * grid_size,
	]

	return get_reachable_targets(positions, impact_pos)

func get_damage(distance:int, offset:int) -> int:
	if offset == 0:
		return rng.randi_range(3, damage)
	return rng.randi_range(1, 2)
