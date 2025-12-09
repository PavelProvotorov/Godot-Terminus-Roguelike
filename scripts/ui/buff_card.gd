extends Control
class_name BuffCard

onready var _duration = $Duration
onready var _card =  $Card
onready var _icon = $Icon
var buff_name:String = ""

func set_card(buff_name:String, duration:int, icon) -> void:
	self.buff_name = buff_name
	_duration.text = str(duration)
	_icon.texture = icon

func set_duration(duration:int) -> void:
	if duration == 0:
		queue_free()
	else:
		_duration.text = str(duration)
	
func get_name() -> String:
	return self.buff_name
