extends MeleeWeapon

func _init():
	damage = 0

func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var targets:Array = []
	targets.append_array(
		get_reachable_targets([impact_pos], impact_pos)
	)
	stun_targets(targets)
	return targets
	
func stun_targets(targets:Array):
	for target in targets:
		if target is Entity2D and _utility.get_chance(45):
			target.add_buff('stun', 2)
