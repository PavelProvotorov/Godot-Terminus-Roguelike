extends Buff

var poision_tick:bool = true

func _ready():
	original_name = 'poison'
	duration = 6

func _on_buff_tick_hook() -> void:
	set_poison_tick()
		
	if poision_tick == true:
		target.receive_damage(1)

func set_poison_tick() -> void:
	if poision_tick == false: 
		poision_tick = true
	else:
		poision_tick = false
