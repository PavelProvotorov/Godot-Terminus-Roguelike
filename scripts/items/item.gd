extends Control
class_name Item

onready var _sprite_animations = SpriteAnimations2D.new(self)
var _owner:Node

var item_name = ""
	
func use() -> bool:
	return false
	
func set_owner(owner:Node) -> void:
	_owner = owner

func add_target_animation() -> void:
	_sprite_animations.add_animation("target")
	
func remove_target_animation() -> void:
	_sprite_animations.remove_animation("target")
