extends Position2D

onready var NODE_LABEL = $Label
onready var NODE_TWEEN = $Tween

var text = 0
var color_type:Color = Color.lightcoral
var velocity:Vector2 = Vector2(0,5)

func _ready():
	randomize()
	NODE_LABEL.set_text(str(text))
	NODE_LABEL.set("custom_colors/font_color",color_type)
	float_tween()
	pass

func _process(delta):
	position -= velocity * delta
	pass

func float_tween():
	NODE_TWEEN.interpolate_property(self,"scale",scale,Vector2(0.7,0.7),0.2,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	NODE_TWEEN.start()
	yield(NODE_TWEEN,"tween_completed")
	NODE_TWEEN.interpolate_property(self,"scale",Vector2(0.7,0.7),Vector2(0.3,0.3),0.4,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	NODE_TWEEN.start()
	yield(NODE_TWEEN,"tween_completed")
	NODE_TWEEN.emit_signal("tween_all_completed")
	pass

func _on_Tween_tween_all_completed():
	self.queue_free()
