extends MeleeWeapon

func _init():
	damage = 3

func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:

	var targets:Array = get_reachable_targets([impact_pos], impact_pos)
	var nearby_cells = _utility.get_nearby_cells_8(origin_pos)
	var nearby_targets:Array = get_reachable_targets(
		nearby_cells, 
		impact_pos
	)
	
	stun_targets(nearby_targets, nearby_cells)
	return targets
	
func stun_targets(targets:Array, cells:Array):
	if not _utility.get_chance(35):
		return
		
	for target in targets:
		if target is Entity2D:
			target.add_buff('stun', 2)
	
	for cell in cells:
		if not self.level.is_tile_blocking(cell / grid_size):
			_sprite_animations.add_animation('spark', self.level, true, cell)
