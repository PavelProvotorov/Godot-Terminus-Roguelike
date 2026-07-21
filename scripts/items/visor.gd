extends Item

func _init():
	description = "<Visor>: High-tech visor which enhances your visibility in the dark;"

func use() -> bool:
	var buff_added = _owner.add_buff('vision', 60, true)
	if buff_added:
		remove_item()
		_owner.end_turn()
		return true
	return false
