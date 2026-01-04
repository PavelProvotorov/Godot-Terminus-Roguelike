extends MeleeWeapon

func _init():
	damage = 3

func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var targets:Array = []
	targets.append_array(
		get_reachable_targets([impact_pos], impact_pos)
	)
	buff_owner()
	return targets
	
func buff_owner():
	if _utility.get_chance(40):
		_owner.add_buff('speed', 1)
