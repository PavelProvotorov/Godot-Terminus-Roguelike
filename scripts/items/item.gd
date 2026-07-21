extends Control
class_name Item

onready var level setget set_level, get_level
onready var _audio:Audio2D = Audio2D.new()
onready var _sprite_animations = SpriteAnimations2D.new()
onready var _utility:Utility = Utility.new()
onready var _static_body = $StaticBody2D
const MAX_ITEM_VISIBILITY:int = 5
var _storage:Control
var _owner:Entity2D

var item_name:String = ""
var description:String = "[color=#%s]<Error>:[/color] Missing entry for item;" %Color.webgray.to_html()
var throw_damage:int = 0
var throw_range:int = 0
var visibility:int = 10
var grid_size:int = 8

func _ready():
	add_to_group('ITEM')
	
func use() -> bool:
	return false
	
func _on_item_thrown(success:bool) -> void:
	if success:
		remove_item()
	else:
		_audio.play_sound(_owner.position, Resources.SOUNDS.fail)
	
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
	_sprite_animations.add_animation("selected", self)
	
func remove_selected_animation() -> void:
	_sprite_animations.remove_animation("selected", self)
	
func get_description() -> String:
	return description
	
func get_throw_range() -> int:
	return throw_range

func get_throw_damage(distance:int, offset:int) -> int:
	return throw_damage
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var targets:Array = []
	targets.append_array(
		get_reachable_targets([impact_pos], impact_pos)
	)
	return targets
	
func get_reachable_targets(positions:Array, center:Vector2) -> Array:
	var shadowcast = BaseShadowcaster.new(funcref(self.level, 'is_tile_blocking'))
	var reachable_cells = shadowcast.cast(center / grid_size, MAX_ITEM_VISIBILITY)
	var entities:Array = get_tree().get_nodes_in_group("ENTITY")
	var targets:Array = []
	
	for entity in entities:
		if (entity.position in positions) and (entity.position / grid_size in reachable_cells):
			targets.append(entity)
	return targets
	
func get_reachable_cells(positions, center:Vector2) -> Array:
	var shadowcast = BaseShadowcaster.new(funcref(self.level, 'is_tile_blocking'))
	var visible_cells = shadowcast.cast(center / grid_size, MAX_ITEM_VISIBILITY)
	var reachable_cells = []
	
	for pos in positions:
		if (pos / grid_size in visible_cells):
			reachable_cells.append(pos)
			
	return reachable_cells
	
func get_visible_cells(center:Vector2, distance:int) -> Array:
	var shadowcast = BaseShadowcaster.new(funcref(self.level, 'is_tile_blocking'))
	var visible_cells:Array = shadowcast.cast(center / grid_size, distance)
	return visible_cells
	
func remove_item() -> void:
	var parent = self.get_parent()
	if parent:
		parent.remove_child(self)
	queue_free()

func set_level(level):
	return level

func get_level():
	return Global.get_level()
