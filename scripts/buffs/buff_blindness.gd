extends Buff

func _ready():
	icon = Resources.icon_blindness
	original_name = 'blindness'
	visibility_modifier = -99
	add_to_group('VISIBILITY_BUFF')

func _on_buff_tick_hook() -> void:
	pass
