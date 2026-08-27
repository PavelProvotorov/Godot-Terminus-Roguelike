extends Item

const damage:int = 3

func _init():
	category = CATEGORY.RANGED_WEAPON
	action = ShootItem.new(self, {
		"get_damage": funcref(self, "get_damage"),
		"get_targets": funcref(self, "get_targets"),
		"on_damage": funcref(self, "on_damage"),
		"sfx": Resources.SOUNDS.shot_1,
		"consumption": 1,
		"range": 3,
		"shots": 1,
	})
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	return get_reachable_targets([impact_pos], impact_pos)
	
func get_damage(distance:int, offset:int) -> int:
	return damage
	
func on_damage(target:Entity2D, alive:bool, received_damage:int) -> void:
	if not alive or received_damage == 0:
		return
	
	if _utility.get_chance(50):
		target.add_buff('bleed', 2)
