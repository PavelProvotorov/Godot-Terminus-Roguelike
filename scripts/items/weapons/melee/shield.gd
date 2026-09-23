extends Item

const damage:int = 2

func _init():
	category = CATEGORY.MELEE_WEAPON
	action = MeleeItem.new(self, {
		"on_use": funcref(self, "on_use"),
		"get_damage": funcref(self, "get_damage"),
		"get_targets": funcref(self, "get_targets"),
		"sfx": Resources.SOUNDS.hit_0,
	})
	Callback.add(Callback.TYPE.TURN_SKIP, funcref(self, "_on_turn_skip_callback"), self)

func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	return get_reachable_targets([impact_pos], impact_pos)
	
func get_damage(distance:int, offset:int) -> int:
	return damage
		
func _on_turn_skip_callback(entity:Entity2D):
	if not entity == self._entity:
		return
	print("TRIGGERING BULWARK")
	entity.add_buff('bulwark', 1, true)
