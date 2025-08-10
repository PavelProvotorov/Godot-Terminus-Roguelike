extends Weapon

func _init():
	damage = 2
	offset_damage = 1
	shot_range = 3
	shot_count = 1
	ammo_consumption = 1
	
func get_damage(distance:int) -> int:
	if distance == shot_range:
		return damage + 1
	return damage
