extends Container

onready var _timer = $Timer
onready var _label = $RichTextLabel
var description = "" setget set_description

func set_description(value:String) -> void:
	_label.text = ''
	
	for i in value.length():
		_label.text += value[i]
		_timer.start(0.03)
		yield(_timer, 'timeout')
	
func update_description(value:String) -> void:
	self.description = value
