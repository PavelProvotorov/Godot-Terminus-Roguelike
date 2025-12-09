extends Buff

func _ready():
	icon = Resources.icon_blindness
	original_name = 'blindness'
	visibility_modifier = -99
	add_to_group('VISIBILITY_BUFF')
