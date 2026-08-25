extends Control
class_name Item

onready var level setget set_level, get_level
onready var _audio:Audio2D = Audio2D.new()
onready var _sprite_animations = SpriteAnimations2D.new()
onready var _utility:Utility = Utility.new()
onready var _static_body = $StaticBody2D
const MAX_ITEM_VISIBILITY:int = 5
var _entity:Entity2D

enum CATEGORY {
	INSTANT,
	CONSUMABLE,
	MELEE_WEAPON,
	RANGED_WEAPON
}

var item_name:String = ""
var description:String = "[color=#%s]<Error>:[/color] Missing entry for item;" %Color.webgray.to_html()
var visibility:int = 10
var grid_size:int = Global.GRID_SIZE
var actions:Dictionary = {}
var category:int = CATEGORY.CONSUMABLE
var action

func _ready():
	add_to_group('ITEM')
	
func use() -> void:
	action.execute()
	
func usable() -> bool:
	if action == null:
		printerr("ACTION NOT DEFINED FOR ITEM: ", self)
		return false
	return action.check()
	
func in_category(category_number:int) -> bool:
	return category == category_number
	
func pickup(entity:Entity2D) -> void:
	self._entity = entity
	
func drop() -> void:
	self._entity = null
	
func get_description() -> String:
	return description
	
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

#func use_action(acc:String) -> void:
#	var action = actions.get(acc, null)
#	action.execute()
#
#func set_actions(acc:Array) -> void:
#	for action in acc:
#		actions[action.get_key()] = action
#
#func can_action(acc:String) -> bool:
#	var action = actions.get(acc, null)
#	if action:
#		return action.check()
#	return false
#
#func has_action(acc:String) -> bool:
#	return actions.has(acc)
#
#func get_actions() -> Array:
#	return actions.keys()
