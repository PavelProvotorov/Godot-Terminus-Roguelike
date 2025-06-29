extends Buff

func _ready():
	original_name = 'shield'
	duration = 5
	resistance_modifier = -99
	add_to_group('RESISTANCE_BUFF')
	_sprite_animations.add_animation('shield')
