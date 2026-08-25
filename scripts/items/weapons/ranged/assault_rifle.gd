extends Item

const damage:int = 3

func _init():
	category = CATEGORY.RANGED_WEAPON
	action = ShootItem.new(self, {
		"on_damage": funcref(self, "on_damage"),
		"on_use": funcref(self, "on_use"),
		"get_damage": funcref(self, "get_damage"),
		"get_targets": funcref(self, "get_targets"),
		"sfx": Resources.SOUNDS.shot_1,
		"consumption": 1,
		"range": 2,
		"shots": 2,
	})
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	return get_reachable_targets([impact_pos], impact_pos)
	
func get_damage(distance:int, offset:int) -> int:
	if _utility.get_chance(25):
		return damage - 1
	return damage
