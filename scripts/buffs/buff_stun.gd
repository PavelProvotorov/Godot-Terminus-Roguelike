extends Buff

func _ready():
	icon = Resources.icon_stun
	original_name = 'stun'
	speed_modifier = -99
	add_to_group('SPEED_BUFF')
	_sprite_animations.add_animation('stun')
	target.play_animation(false)

func _on_buff_tick_hook() -> void:
	if duration <= 0:
		target.play_animation(true)
