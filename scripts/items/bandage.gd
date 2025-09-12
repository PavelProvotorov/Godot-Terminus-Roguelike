extends Consumable

func use() -> bool:
	var buff_added = _owner.add_buff('regeneration', true)
	if buff_added:
		_owner.end_turn()
		remove_item()
		return true
	return false
