extends Buff

var poision_tick:bool = false

func _ready():
	icon = Resources.icon_poison
	original_name = 'poison'

func _on_buff_tick_hook() -> void:
	set_poison_tick()
		
	if poision_tick == true:
		target.receive_damage(1, true)

func set_poison_tick() -> void:
	poision_tick = not poision_tick
