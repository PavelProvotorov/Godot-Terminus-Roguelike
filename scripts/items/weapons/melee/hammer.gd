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
	
func on_use(origin_pos:Vector2, impact_pos:Vector2) -> void:
	var trigger_stun = _utility.get_chance(35)
	
	if not trigger_stun:
		return
	
	var nearby_cells = _utility.get_nearby_cells_8(origin_pos)
	var entities:Array = get_reachable_targets(
		nearby_cells, 
		impact_pos
	)
	
	for entity in entities:
		entity.add_buff('stun', 2)
	
	for cell in nearby_cells:
		if not self.level.is_tile_blocking(cell / grid_size):
			_sprite_animations.add_animation('spark', self.level, true, cell)
