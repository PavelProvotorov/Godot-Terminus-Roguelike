extends Control
class_name Item

onready var _sprite_animations = SpriteAnimations2D.new(self)
onready var _level = get_tree().get_first_node_in_group("LEVEL")
onready var _static_body = $StaticBody2D
var _storage:Control
var _owner:Entity2D

var item_name = ""
var description = "<Error>: Missing entry for item"

func _ready():
	add_to_group('ITEM')
	_static_body.add_to_group('ITEM')
	
func use() -> bool:
	return false
	
func _on_item_used(success:bool) -> void:
	if success:
		remove_item()
	
func set_item_owner(owner:Entity2D) -> void:
	if owner is Entity2D:
		_owner = owner
	else:
		printerr("Provided item owner is not an entity: ", owner)
		
func set_item_consumable() -> void:
	add_to_group('CONSUMABLE')
	_static_body.add_to_group('CONSUMABLE')

func set_item_instant() -> void:
	add_to_group('INSTANT')
	_static_body.add_to_group('INSTANT')

func add_target_animation() -> void:
	_sprite_animations.add_animation("target")
	
func remove_target_animation() -> void:
	_sprite_animations.remove_animation("target")
	
func get_description() -> String:
	return description
	
func remove_item() -> void:
	queue_free()
