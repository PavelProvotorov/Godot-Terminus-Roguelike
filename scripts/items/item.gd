extends Control
class_name Item

onready var _sprite_animations = SpriteAnimations2D.new(self)

var item_name = ""

func ready():
	pass

func add_target_animation() -> void:
	_sprite_animations.add_animation("target")
	
func remove_target_animation() -> void:
	_sprite_animations.remove_animation("target")
