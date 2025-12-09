extends RangedWeapon

func _init():
	damage = 3
	shot_range = 3
	shot_count = 2
	ammo_consumption = 1
	
func get_damage(distance:int, offset:int) -> int:
	if _utility.get_chance(25):
		return damage - 1
	return damage
