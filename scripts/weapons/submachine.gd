extends Weapon

func _init():
	shot_damage = 2
	shot_range = 3
	shot_count = 2
	ammo_consumption = 1
	
func get_shot_damage(distance:int, offset:int) -> int:
	if _utility.get_chance(15):
		return shot_damage + 1
	return shot_damage
