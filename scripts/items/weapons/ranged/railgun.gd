extends Item

const shot_range:int = 5
const damage:int = 4

func _init():
	category = CATEGORY.RANGED_WEAPON
	action = ShootItem.new(self, {
		"get_damage": funcref(self, "get_damage"),
		"get_targets": funcref(self, "get_targets"),
		"sfx": Resources.SOUNDS.shot_0,
		"consumption": 3,
		"range": shot_range,
		"shots": 1,
	})
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var direction = origin_pos.direction_to(impact_pos)
	var check_positions:Array = []

	for idx in shot_range:
		if idx == 0:
			continue
		check_positions.append(origin_pos + (direction * (grid_size * idx)))

	return get_reachable_targets(check_positions, origin_pos)
	
func get_damage(distance:int, offset:int) -> int:
	return damage
