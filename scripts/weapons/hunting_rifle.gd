extends RangedWeapon

func _init():
	damage = 2
	shot_range = 3
	shot_count = 1
	ammo_consumption = 1
	shot_sound = Resources.SOUNDS.shot_hunting_rifle
	
func get_damage(distance:int, offset:int) -> int:
	if distance == shot_range:
		return damage + 1
	return damage
