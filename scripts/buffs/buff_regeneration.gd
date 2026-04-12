extends Buff

func _ready():
	icon = Resources.icon_regeneration
	original_name = 'regeneration'
	_sprite_animations.add_animation('regeneration', self)

func _on_buff_tick_hook() -> void:
	target.restore_health(1)
