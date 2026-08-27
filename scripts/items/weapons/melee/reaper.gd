extends Item

const damage:int = 3

func _init():
	category = CATEGORY.MELEE_WEAPON
	action = MeleeItem.new(self, {
		"on_damage": funcref(self, "on_damage"),
		"get_damage": funcref(self, "get_damage"),
		"get_targets": funcref(self, "get_targets"),
		"sfx": Resources.SOUNDS.hit_0,
	})

func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var direction = origin_pos.direction_to(impact_pos)
	var left = Vector2(-direction.y, direction.x)
	var right = Vector2(direction.y, -direction.x)
	
	var positions = [
		impact_pos
	]
	
	if _utility.get_chance(50):
		positions.append(impact_pos + left * grid_size)
	else:
		positions.append(impact_pos + right * grid_size)
		
	return get_reachable_targets(positions, impact_pos)
	
func get_damage(distance:int, offset:int) -> int:
	if offset > 0:
		return damage - 1
	return damage
	
func on_damage(target:Entity2D, alive:bool, received_damage:int) -> void:
	if received_damage == 0:
		return
	
	if _utility.get_chance(15):
		_entity.restore_health(1)

