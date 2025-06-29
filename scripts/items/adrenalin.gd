extends Item

func use() -> bool:
	var buff_added = _owner.add_buff('speed')
	if buff_added:
		_owner.end_turn()
		return true
	return false
