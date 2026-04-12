extends Buff

func _ready():
	icon = Resources.icon_speed
	original_name = 'speed'
	speed_modifier = 1
	_sprite_animations.add_animation('speed', self)
	add_to_group('SPEED_BUFF')
