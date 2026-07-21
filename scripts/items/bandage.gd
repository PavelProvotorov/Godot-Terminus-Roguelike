extends Consumable

func use() -> bool:
	
	if _owner.is_max_health():
		return false
		
	var buff_added = _owner.add_buff('regeneration', 2, true)
	if buff_added:
		remove_item()
		_owner.end_turn()
		return true
	return false
