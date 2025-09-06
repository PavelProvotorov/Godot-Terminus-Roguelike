extends Control
class_name Inventory

onready var _description = null
onready var _grid = $GridContainer
onready var _ranged_weapon_slot = $RangedWeaponSlot
onready var _level:Level = get_tree().get_first_node_in_group("LEVEL")

var selected_item:Item = null
var max_item_count:int = 6
var min_item_count:int = 0

func _ready():
	_grid.connect("child_exiting_tree", self, "_on_child_exiting_tree")
	_ranged_weapon_slot.add_child(Resources.weapon_assault_rifle.instance())

func pickup_item_and_use(item:Item, owner:Node) -> bool:
	item.set_item_owner(owner)
	if item.use():
		return true
	return false

func pickup_item(item:Item, owner:Node) -> bool:
	if get_stored_items().size() < max_item_count:
		item.get_parent().remove_child(item)
		item.rect_position = Vector2.ZERO
		item.set_item_owner(owner)
		_grid.add_child(item)
		return true
	return false

func switch_selected_item(index:int) -> void:
	
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
	selected_item.add_target_animation()
	set_description()

func select_first_item() -> void:
	
	if get_stored_items().size() > 0:
		selected_item = get_stored_items()[0]
		selected_item.add_target_animation()
		set_description()

func clear_selection() -> void:
	if selected_item != null:
		selected_item.remove_target_animation()

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
	
	if selected_item is Weapon:
		equip_ranged_weapon(selected_item)
		return false
	
	if selected_item is Item:
		if selected_item.use():
			return true
		
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

func equip_ranged_weapon(new_weapon:Weapon) -> void:
	var current_weapon = get_ranged_weapon()
	
	_ranged_weapon_slot.remove_child(current_weapon)
	_grid.remove_child(new_weapon)
	
	_ranged_weapon_slot.add_child(new_weapon)
	_grid.add_child(current_weapon)

func drop_selected_item(pos:Vector2) -> bool:
	_grid.remove_child(selected_item)
	_level.add_child(selected_item)
	selected_item.rect_position = pos
	return true

func get_ranged_weapon() -> Weapon:
	return _ranged_weapon_slot.get_child(0)

func get_stored_items() -> Array:
	return _grid.get_children()

func _on_child_exiting_tree(child:Node) -> void:
	pass
