extends Buff

func _ready():
	print("BUFF IS READY")
	icon = Resources.icon_vision
	original_name = 'vision'
	visibility_modifier = 3
	add_to_group('VISIBILITY_BUFF')
	
	if target is Player:
		target.update_fog()

func _on_buff_tick_hook() -> void:
	if duration <= 0 and target is Player:
		target.update_fog()
