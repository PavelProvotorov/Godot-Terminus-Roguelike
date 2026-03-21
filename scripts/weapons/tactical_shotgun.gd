extends RangedWeapon

func _init():
	damage = 3
	shot_range = 3
	shot_count = 1
	ammo_consumption = 1
	shot_sound = Resources.SOUNDS.shot_shotgun
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var direction = origin_pos.direction_to(impact_pos)
	var targets:Array = []
	
	var left = Vector2(-direction.y, direction.x)
	var right = Vector2(direction.y, -direction.x)

	var positions = [
		impact_pos,
		impact_pos + left * grid_size,
		impact_pos + right * grid_size,
	]
	
	targets.append_array(get_reachable_targets(positions, impact_pos))
		
	return targets

func get_damage(distance:int, offset:int) -> int:
	if offset > 0:
		return damage - 1
	if distance == 1 and offset == 0:
		return damage + 1
	return damage
