extends Control
class_name Inventory

onready var _description = null
onready var _grid = $GridContainer

var stored_items:Array = []
var max_item_count:int = 6
var min_item_count:int = 0
var selected_item:Item = null

func _ready():
	_grid.connect("child_exiting_tree", self, "_on_child_exiting_tree")

func pickup_item_and_use(item:Item, owner:Node) -> bool:
	item.set_item_owner(owner)
	if item.use():
		return true
	return false

func pickup_item(item:Item, owner:Node) -> bool:
	if stored_items.size() < max_item_count:
		item.get_parent().remove_child(item)
		item.rect_position = Vector2.ZERO
		item.set_item_owner(owner)
		_grid.add_child(item)
		stored_items.append(item)
		return true
	return false

func switch_selected_item(index:int) -> void:
	
	clear_selection()
	
	var size = stored_items.size()
	
	if size == 0:
		return

	var selected_index = stored_items.find(selected_item)

	if selected_index == -1:
		selected_index = 0

	var final_index = (selected_index + index) % size

	if final_index < 0:
		final_index += size

	selected_item = stored_items[final_index]
	selected_item.add_target_animation()
	set_description()

func select_first_item() -> void:
	
	if stored_items.size() > 0:
		selected_item = stored_items[0]
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
	if selected_item != null:
		if selected_item.use():
			return true
	return false

func is_inventory_empty() -> bool:
	return stored_items.size() <= 0

func drop_item(item:Item) -> void:
	stored_items.erase(item)
	
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
	
func _on_child_exiting_tree(child:Node) -> void:
	stored_items.erase(child)
