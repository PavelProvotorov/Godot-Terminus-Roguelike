extends Control
class_name BuffCard

onready var _duration = $Container/Duration
onready var _tween_animations = TweenAnimation2D.new(self)
onready var _container = $Container
onready var _card =  $Container/Card
onready var _icon = $Container/Icon
var buff_name:String = ""
	
func _ready():
	var tween:SceneTreeTween = self.create_tween()
	tween.tween_property(_container, 'position', _container.position + (Vector2.RIGHT) * 3, 0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_property(_container, 'position', Vector2.ZERO, 0.2).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	yield(tween, "finished")

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
