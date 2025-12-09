extends Buff

func _ready():
	icon = Resources.icon_bleed
	original_name = 'bleed'

func _on_buff_tick_hook() -> void:
	target.receive_damage(1)
