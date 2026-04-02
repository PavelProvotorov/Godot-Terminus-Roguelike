extends RangedWeapon
 
func _init():
	damage = 5
	shot_range = 4
	shot_count = 1
	ammo_consumption = 2
	shot_sound = Resources.SOUNDS.shot_hunting_rifle
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var direction = origin_pos.direction_to(impact_pos)
	var targets:Array = []
	
	targets.append_array(get_reachable_targets([
		impact_pos,
		impact_pos + (direction * grid_size)
	], impact_pos))
	
	return targets
	
func get_damage(distance:int, offset:int) -> int:
	if offset > 0:
		return 2
	return max(3, damage - (shot_range - distance)) as int
