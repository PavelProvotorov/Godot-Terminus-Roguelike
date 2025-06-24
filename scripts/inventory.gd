extends Control
class_name Inventory

onready var _grid = $GridContainer

var stored_items:Array = []
var max_item_count:int = 6
var min_item_count:int = 0
var selected_item:Item = null

func _ready():
	pass

func pickup_item(item:Item, owner:Node) -> void:
	if stored_items.size() < max_item_count:
		item.get_parent().remove_child(item)
		item.rect_position = Vector2.ZERO
		item.set_owner(owner)
		_grid.add_child(item)
		stored_items.append(item)

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

func select_first_item() -> void:
	
	if stored_items.size() > 0:
		selected_item = stored_items[0]
		selected_item.add_target_animation()

func clear_selection() -> void:
	if selected_item != null:
		selected_item.remove_target_animation()

func reset_state() -> void:
	clear_selection()
	selected_item = null

func use_selected_item() -> bool:
	if selected_item != null:
		if selected_item.use():
			stored_items.erase(selected_item)
			selected_item.queue_free()
			selected_item = null
			return true
	return false

func drop_item(item:Item) -> void:
	stored_items.erase(item)
