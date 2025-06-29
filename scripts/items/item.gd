extends Control
class_name Item

onready var _sprite_animations = SpriteAnimations2D.new(self)
onready var _level = get_tree().get_first_node_in_group("LEVEL")
var _owner:Entity2D

var item_name = ""
	
func use() -> bool:
	return false
	
func set_item_owner(owner:Entity2D) -> void:
	if owner is Entity2D:
		_owner = owner
	else:
		printerr("Provided item owner is not an entity: ", owner)

func add_target_animation() -> void:
	_sprite_animations.add_animation("target")
	
func remove_target_animation() -> void:
	_sprite_animations.remove_animation("target")
