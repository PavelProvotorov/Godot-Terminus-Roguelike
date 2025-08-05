extends Item

func _ready():
	description = "<Teleporter>: This high-tech device teleports the user to a random spot in close proximity;"
	set_item_consumable()

func use() -> bool:
	var cells:Array = _level.get_free_cells()
	_owner.position = cells.pick_random() * 8
	_owner.update_fog()
	_owner.end_turn()
	remove_item()
	return true
