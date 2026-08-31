extends Control
class_name Inventory

onready var level setget set_level, get_level
onready var _audio:Audio2D = Audio2D.new()
onready var _description = null
onready var _grid = $GridContainer
onready var _ranged_weapon_slot = $RangedWeaponSlot
onready var _melee_weapon_slot = $MeleeWeaponSlot
onready var _sprite_animations = SpriteAnimations2D.new()

var selected_item:Item = null
var max_item_count:int = 6
var min_item_count:int = 0

func _ready():
	_grid.connect("child_exiting_tree", self, "_on_child_exiting_tree")
	var ranged_weapon_instance:Item = Resources.weapon_assault_rifle.instance()
	var melee_weapon_instance:Item = Resources.weapon_reaper.instance()
	ranged_weapon_instance._entity = Global.get_player()
	melee_weapon_instance._entity = Global.get_player()
	_ranged_weapon_slot.add_child(ranged_weapon_instance)
	_melee_weapon_slot.add_child(melee_weapon_instance)

func pickup_item(item:Item, owner:Node) -> bool:
	
	if item.in_category(Item.CATEGORY.INSTANT):
		item.pickup(owner)
		
		if item.usable():
			_audio.play_global_sound(Resources.SOUNDS.pickup_0)
			item.use()
			return true
		_audio.play_global_sound(Resources.SOUNDS.fail)
		return false
		
	if get_stored_items().size() < max_item_count:
		_audio.play_global_sound(Resources.SOUNDS.pickup_0)
		item.get_parent().remove_child(item)
		item.rect_position = Vector2.ZERO
		_grid.add_child(item)
		item.pickup(owner)
		owner.end_turn()
		return true
		
	_audio.play_global_sound(Resources.SOUNDS.fail)
	return false

func switch_selected_item(index:int) -> void:
	_audio.play_global_sound(Resources.SOUNDS.switch)
	clear_selection()
	
	var size = get_stored_items().size()
	
	if size == 0:
		return

	var selected_index = get_stored_items().find(selected_item)

	if selected_index == -1:
		selected_index = 0

	var final_index = (selected_index + index) % size

	if final_index < 0:
		final_index += size

	selected_item = get_stored_items()[final_index]
	_sprite_animations.add_animation("selected", selected_item)
	set_description()

func clear_selection() -> void:
	if selected_item != null:
		_sprite_animations.remove_animation("selected", selected_item)

func clear_description() -> void:
	if _description != null:
		_description.queue_free()
		_description = null

func reset_state() -> void:
	clear_selection()
	clear_description()
	selected_item = null

func use_selected_item() -> bool:
	
	if selected_item == null:
		return false
		
	if selected_item is Item:
		
		if selected_item.in_category(Item.CATEGORY.RANGED_WEAPON):
			equip_ranged_weapon(selected_item)
			Global.get_player().end_turn()
			return true
			
		if selected_item.in_category(Item.CATEGORY.MELEE_WEAPON):
			equip_melee_weapon(selected_item)
			Global.get_player().end_turn()
			return true
		
		if selected_item.in_category(Item.CATEGORY.CONSUMABLE) and selected_item.usable():
			selected_item.use()
			return true

	_audio.play_global_sound(Resources.SOUNDS.fail)
	return false

func is_inventory_empty() -> bool:
	return get_stored_items().size() <= 0
	
func set_description() -> void:
	
	if _description:
		_description.queue_free()
		_description = null
	
	var instance = Resources.scene_description.instance()
	
	_description = instance
	add_child(instance)

	_description.update_description(
		selected_item.get_description()
	)

func equip_ranged_weapon(new_weapon:Item) -> void:
	var current_weapon = get_ranged_weapon()
	
	_ranged_weapon_slot.remove_child(current_weapon)
	_grid.remove_child(new_weapon)
	
	_ranged_weapon_slot.add_child(new_weapon)
	_grid.add_child(current_weapon)
	
func equip_melee_weapon(new_weapon:Item) -> void:
	var current_weapon = get_melee_weapon()
	
	_melee_weapon_slot.remove_child(current_weapon)
	_grid.remove_child(new_weapon)
	
	_melee_weapon_slot.add_child(new_weapon)
	_grid.add_child(current_weapon)

func drop_selected_item(origin_pos:Vector2) -> bool:
	var level_cells:Array = self.level.get_item_free_cells()
	var nearby_cells:Array = []
	
	for cell in level_cells:
		var dx = abs(cell.x - origin_pos.x)
		var dy = abs(cell.y - origin_pos.y)

		if dx <= 1 and dy <= 1:
			nearby_cells.append(cell)
			
	if nearby_cells.size() == 0:
		_audio.play_global_sound(Resources.SOUNDS.fail)
		return false
		
	var drop_to_cell:Vector2 = origin_pos * 8
	if not nearby_cells.has(origin_pos):
		drop_to_cell = nearby_cells.pick_random() * 8
		
	_audio.play_global_sound(Resources.SOUNDS.drop)
	_grid.remove_child(selected_item)
	self.level.add_child(selected_item)
	selected_item.drop()
	selected_item.rect_position = drop_to_cell
	return true

func get_ranged_weapon() -> Item:
	return _ranged_weapon_slot.get_child(0)
	
func get_melee_weapon() -> Item:
	return _melee_weapon_slot.get_child(0)

func get_stored_items() -> Array:
	return _grid.get_children()

func _on_child_exiting_tree(child:Node) -> void:
	pass

func set_level(level):
	return level

func get_level():
	return Global.get_level()
