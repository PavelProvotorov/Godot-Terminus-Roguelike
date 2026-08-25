extends Item

const shot_range:int = 4
const damage:int = 5

func _init():
	category = CATEGORY.RANGED_WEAPON
	action = ShootItem.new(self, {
		"get_damage": funcref(self, "get_damage"),
		"get_targets": funcref(self, "get_targets"),
		"sfx": Resources.SOUNDS.shot_hunting_rifle,
		"consumption": 2,
		"range": shot_range,
		"shots": 1,
	})
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var direction = origin_pos.direction_to(impact_pos)
	return get_reachable_targets([
		impact_pos,
		impact_pos + (direction * grid_size)
	], impact_pos)
	
func get_damage(distance:int, offset:int) -> int:
	if offset > 0:
		return 3
	return max(3, damage - (shot_range - distance)) as int
