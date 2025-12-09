extends Buff

func _ready():
	icon = Resources.icon_stun
	original_name = 'stun'
	speed_modifier = -99
	add_to_group('SPEED_BUFF')
