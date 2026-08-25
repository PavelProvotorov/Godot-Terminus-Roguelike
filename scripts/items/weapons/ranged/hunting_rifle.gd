extends Item

const shot_range:int = 3
const damage:int = 2

func _init():
	category = CATEGORY.RANGED_WEAPON
	action = ShootItem.new(self, {
		"get_damage": funcref(self, "get_damage"),
		"get_targets": funcref(self, "get_targets"),
		"sfx": Resources.SOUNDS.shot_hunting_rifle,
		"consumption": 1,
		"range": shot_range,
		"shots": 1,
	})
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	return get_reachable_targets([impact_pos], impact_pos)
	
func get_damage(distance:int, offset:int) -> int:
	if distance == shot_range:
		return damage + 1
	return damage
