extends Consumable

func use() -> bool:
	
	if _owner.is_max_health():
		return false
		
	var buff_added = _owner.add_buff('regeneration', true)
	if buff_added:
		_owner.end_turn()
		remove_item()
		return true
	return false
