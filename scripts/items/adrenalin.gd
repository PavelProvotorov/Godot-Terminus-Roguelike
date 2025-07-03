extends Item

func _ready():
	set_item_consumable()

func use() -> bool:
	var buff_added = _owner.add_buff('speed')
	if buff_added:
		_owner.end_turn()
		remove_item()
		return true
	return false
