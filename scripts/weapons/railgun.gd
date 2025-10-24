extends Weapon
 
func _init():
	shot_damage = 4
	shot_range = 4
	shot_count = 1
	ammo_consumption = 3
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var direction = origin_pos.direction_to(impact_pos)
	var check_positions:Array = []
	var targets:Array = []
	
	for idx in shot_range:
		print(impact_pos + (direction * (grid_size * idx)))
		check_positions.append(impact_pos + (direction * (grid_size * idx)))
	
	targets.append_array(get_reachable_targets(check_positions, impact_pos))
	
	return targets
	
func get_shot_damage(distance:int, offset:int) -> int:
	return shot_damage
