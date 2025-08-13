extends Item

func _ready():
	description = "<Shield Generator>: A powerful protective device which generates a damage deflecting shield around the user;"
	set_item_consumable()

func use() -> bool:
	var buff_added = _owner.add_buff('shield')
	if buff_added:
		_owner.end_turn()
		remove_item()
		return true
	return false
