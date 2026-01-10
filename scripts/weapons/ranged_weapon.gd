extends Weapon
class_name RangedWeapon

var shot_sound:AudioStream = Resources.SOUNDS.shot_1

func _ready():
	add_to_group('RANGED_WEAPON')

func sfx() -> AudioStream:
	return self.shot_sound
