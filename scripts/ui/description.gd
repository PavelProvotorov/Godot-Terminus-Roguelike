extends Container

onready var _timer = $Timer
onready var _label = $RichTextLabel
var description = "" setget set_description

func _ready():
	_label.percent_visible = 0

func set_description(value:String) -> void:
	
	_label.bbcode_text = value
	
	var char_count = _label.text.length()
	var char_percentage:float = stepify(1.0 / char_count, 0.0001)
	
	for i in char_count:
		_label.percent_visible += char_percentage
		_timer.start(0.03)
		yield(_timer, 'timeout')
	
	_label.percent_visible = 1
	
	
func update_description(value:String) -> void:
	self.description = value
