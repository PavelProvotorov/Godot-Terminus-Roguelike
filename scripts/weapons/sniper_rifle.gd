extends Weapon

func _init():
	shot_damage = 3
	shot_range = 3
	shot_count = 1
	ammo_consumption = 2
	
func get_shot_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var direction = origin_pos.direction_to(impact_pos)
	var targets:Array = []
	
	targets.append_array(match_pos_to_target([
		impact_pos,
		impact_pos + (direction * grid_size)
	]))
	
	return targets
	
func get_shot_damage(distance:int, offset:int) -> int:
	if offset > 0:
		return shot_damage - 1
	if distance == shot_range and offset == 0:
		return shot_damage + 1
	return shot_damage
