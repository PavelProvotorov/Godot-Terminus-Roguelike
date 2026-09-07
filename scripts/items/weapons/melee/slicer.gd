extends Item

const damage:int = 3

func _init():
	category = CATEGORY.MELEE_WEAPON
	action = MeleeItem.new(self, {
		"on_use": funcref(self, "on_use"),
		"get_damage": funcref(self, "get_damage"),
		"get_targets": funcref(self, "get_targets"),
		"sfx": Resources.SOUNDS.hit_0,
	})

func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	return get_reachable_targets([impact_pos], impact_pos)
	
func get_damage(distance:int, offset:int) -> int:
	return damage
		
func on_damage(target:Entity2D, alive:bool, received_damage:int) -> void:
	if received_damage == 0:
		return
	
	if _utility.get_chance(40):
		target.add_buff('bleed', 2)
