extends Item

func _ready():
	set_item_consumable()

func use() -> bool:
	if _owner.restore_health(3):
		_owner.end_turn()
		remove_item()
		return true
	return false
