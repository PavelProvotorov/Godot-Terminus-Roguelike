extends Item

func _init():
	description = "<Visor>: High-tech visor which enhances your visibility in the dark;"

func use() -> bool:
	var buff_added = _owner.add_buff('vision', 60, true)
	if buff_added:
		_owner.end_turn()
		remove_item()
		return true
	return false
