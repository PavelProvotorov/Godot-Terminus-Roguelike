extends Weapon

func _init():
	damage = 3
	offset_damage = 1
	shot_range = 2
	shot_count = 1
	ammo_consumption = 1
	
func get_shot_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var direction = origin_pos.direction_to(impact_pos)
	var targets:Array = []
	
	if is_horizontal(direction):
		targets.append_array(match_pos_to_target([
			impact_pos,
			impact_pos + (Vector2.UP * grid_size),
			impact_pos + (Vector2.DOWN * grid_size),
		]))
	
	if is_vertical(direction):
		targets.append_array(match_pos_to_target([
			impact_pos,
			impact_pos + (Vector2.LEFT * grid_size),
			impact_pos + (Vector2.RIGHT * grid_size),
		]))
		
	return targets
