extends Buff

func _ready():
	original_name = 'blindness'
	visibility_modifier = -99
	duration = 3
	add_to_group('VISIBILITY_BUFF')
