extends Buff

func _ready():
	original_name = 'bleed'
	duration = 2

func _on_buff_tick_hook() -> void:
	target.receive_damage(1)
