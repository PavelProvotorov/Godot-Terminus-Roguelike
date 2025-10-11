extends Control
class_name Item

onready var level setget set_level, get_level
onready var _sprite_animations = SpriteAnimations2D.new(self)
onready var _utility:Utility = Utility.new()
onready var _static_body = $StaticBody2D
var _storage:Control
var _owner:Entity2D

var item_name:String = ""
var description:String = "<Error>: Missing entry for item;"
var throw_damage:int = 0
var throw_range:int = 0
var grid_size:int = 8

func _ready():
	add_to_group('ITEM')
	
func use() -> bool:
	return false
	
func _on_item_thrown(success:bool) -> void:
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

func add_selected_animation() -> void:
	_sprite_animations.add_animation("selected")
	
func remove_selected_animation() -> void:
	_sprite_animations.remove_animation("selected")
	
func get_description() -> String:
	return description
	
func get_throw_range() -> int:
	return throw_range

func get_throw_damage(distance:int, offset:int) -> int:
	return throw_damage
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var targets:Array = []
	targets.append_array(
		match_pos_to_target([impact_pos])
	)
	return targets
	
func match_pos_to_target(positions:Array) -> Array:
	var entities:Array = get_tree().get_nodes_in_group("ENTITY")
	var targets:Array = []
	for entity in entities:
		if entity.position in positions:
			targets.append(entity)
	return targets
	
func remove_item() -> void:
	queue_free()

func set_level(level):
	return level

func get_level():
	return Global.get_level()
