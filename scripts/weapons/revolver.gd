extends RangedWeapon

func _init():
	damage = 3
	shot_range = 3
	shot_count = 1
	ammo_consumption = 2
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var direction = origin_pos.direction_to(impact_pos)
	var targets:Array = []
	
	targets.append_array(get_reachable_targets([
		impact_pos,
	], impact_pos))
	
	bleed_targets(targets)
	
	return targets

func bleed_targets(targets:Array):
	for target in targets:
		if target is Entity2D and _utility.get_chance(50):
			target.add_buff('bleed')
