extends RangedWeapon

func _init():
	damage = 3
	shot_range = 2
	shot_count = 1
	ammo_consumption = 1
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var direction = origin_pos.direction_to(impact_pos)
	var targets:Array = []
	
	if is_horizontal(direction):
		targets.append_array(get_reachable_targets([
			impact_pos,
			impact_pos + (Vector2.UP * grid_size),
			impact_pos + (Vector2.DOWN * grid_size),
		], impact_pos))
	
	if is_vertical(direction):
		targets.append_array(get_reachable_targets([
			impact_pos,
			impact_pos + (Vector2.LEFT * grid_size),
			impact_pos + (Vector2.RIGHT * grid_size),
		], impact_pos))
		
	return targets

func get_damage(distance:int, offset:int) -> int:
	if offset == 0:
		return damage
	return damage - 2
