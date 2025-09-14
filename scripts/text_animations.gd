extends Node
class_name TextAnimations2D

onready var level setget set_level, get_level

const tween_speed:int = 2
const recharge_color:Color = Color.orange
const damage_color:Color = Color.lightcoral
const critical_color:Color = Color.crimson
const heal_color:Color = Color.greenyellow
const text_color:Color = Color.whitesmoke
const float_vector:Vector2 = Vector2(0, -10)
const grid_size = 8
	
func display_text(value:String, pos:Vector2) -> void:
	var instance = Resources.text_label.instance()
	var label = instance.get_node('Label')
	label.set("custom_colors/font_color", text_color)
	label.set_position(pos + get_random_position())
	label.text = str(value)
	self.level.add_child(instance)
	yield(animation_float_up(float_vector, instance, label), 'completed')
	instance.queue_free()
	
func display_damage_number(value:int, pos:Vector2, critical:bool = false):
	var instance = Resources.text_label.instance()
	var label = instance.get_node('Label')
	if critical: 
		label.set("custom_colors/font_color", critical_color)
	else:
		label.set("custom_colors/font_color", damage_color)
	label.set_position(pos + get_random_position())
	label.text = str(value)
	self.level.add_child(instance)
	yield(animation_float_up(float_vector, instance, label), 'completed')
	instance.queue_free()
	
func display_heal_number(value:int, pos:Vector2) -> void:
	var instance = Resources.text_label.instance()
	var label = instance.get_node('Label')
	label.set("custom_colors/font_color", heal_color)
	label.set_position(pos + get_random_position())
	label.text = str(value)
	self.level.add_child(instance)
	yield(animation_float_up(float_vector, instance, label), 'completed')
	instance.queue_free()
	
func display_recharge_number(value:int, pos:Vector2) -> void:
	var instance = Resources.text_label.instance()
	var label = instance.get_node('Label')
	label.set("custom_colors/font_color", recharge_color)
	label.set_position(pos + get_random_position())
	label.text = str(value)
	self.level.add_child(instance)
	yield(animation_float_up(float_vector, instance, label), 'completed')
	instance.queue_free()

func animation_float_up(pos:Vector2, target:Node, label) -> void:
	var tween:SceneTreeTween = target.create_tween()
	tween.tween_property(target, "position", pos, 1.0/tween_speed).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(label, "rect_scale", Vector2(0.7, 0.7), 0.2).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_property(label, "rect_scale", Vector2(0.3, 0.3), 0.2).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	yield(tween, 'finished')
	
func get_random_position() -> Vector2:
	return Vector2(
		rand_range(-1, 1),
		rand_range(-2, -4)
	)

func set_level(level):
	return level

func get_level():
	return Global.get_level()
