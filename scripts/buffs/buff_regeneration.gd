extends Buff

func _ready():
	original_name = 'regeneration'
	duration = 2

func _on_buff_tick_hook() -> void:
	print("Regen ticked")
	target.restore_health(1)
