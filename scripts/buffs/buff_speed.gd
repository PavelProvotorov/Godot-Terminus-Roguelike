extends Buff

func _ready():
	original_name = 'speed'
	speed_modifier = 1
	duration = 3
	add_to_group('SPEED_BUFF')
