extends Weapon

func _init():
	shot_damage = 3
	shot_range = 3
	shot_count = 3
	ammo_consumption = 1
	
func get_shot_damage(distance:int, offset:int) -> int:
	return shot_damage
