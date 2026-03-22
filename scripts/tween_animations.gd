extends Node
class_name TweenAnimation2D

const tween_speed = 10
var parent

func _init(parent:Node) -> void:
	self.parent = parent

func animation_move_to(pos:Vector2, target:Node, property:String) -> void:
	var tween:SceneTreeTween = parent.create_tween()
	tween.tween_property(target, property, pos, 1.0/tween_speed).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	yield(tween, "finished")

func animation_ranged(start:Vector2, finish:Vector2, target:Node, property:String) -> void:
	var tween:SceneTreeTween = parent.create_tween()
	tween.tween_property(target, property, finish, 0.8/tween_speed)
	tween.tween_property(target, property, start, 1.0/tween_speed).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	yield(tween, "finished")

func animation_melee(start:Vector2, finish:Vector2, target:Node, property:String) -> void:
	var tween:SceneTreeTween = parent.create_tween()
	tween.tween_property(target, property, finish, 0.8/tween_speed)
	tween.tween_property(target, property, start, 1.0/tween_speed).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	yield(tween, "finished")

func animation_appear(target:Node) -> void:
	var tween:SceneTreeTween = parent.create_tween()
	tween.tween_property(target, "modulate:a", 1, 0.3)
	yield(tween, "finished")
