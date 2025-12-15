extends Buff
class_name BuffShield

func _ready():
	icon = Resources.icon_shield
	original_name = 'shield'
	resistance_modifier = -99
	add_to_group('RESISTANCE_BUFF')
	_sprite_animations.add_animation('shield', self)
