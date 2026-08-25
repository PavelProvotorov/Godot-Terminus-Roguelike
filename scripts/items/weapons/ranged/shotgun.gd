extends Item

const damage:int = 3

func _init():
	category = CATEGORY.RANGED_WEAPON
	action = ShootItem.new(self, {
		"get_damage": funcref(self, "get_damage"),
		"get_targets": funcref(self, "get_targets"),
		"sfx": Resources.SOUNDS.shot_shotgun,
		"consumption": 1,
		"range": 2,
		"shots": 1,
	})

func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var direction = origin_pos.direction_to(impact_pos)
	var left = Vector2(-direction.y, direction.x)
	var right = Vector2(direction.y, -direction.x)

	var positions = [
		impact_pos,
		impact_pos + left * grid_size,
		impact_pos + right * grid_size,
	]

	return get_reachable_targets(positions, impact_pos)

func get_damage(distance:int, offset:int) -> int:
	if offset == 0:
		return damage
	return damage - 2
