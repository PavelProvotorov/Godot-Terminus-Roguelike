extends Buff

func _ready():
	original_name = 'poison'
	duration = 3

func _on_buff_tick_hook() -> void:
	target.receive_damage(1)
