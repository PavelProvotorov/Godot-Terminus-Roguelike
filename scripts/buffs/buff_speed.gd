extends Buff

func _ready():
	icon = Resources.icon_speed
	original_name = 'speed'
	speed_modifier = 1
	add_to_group('SPEED_BUFF')
