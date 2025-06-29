extends Item

func use() -> bool:
	var cells:Array = _level.get_free_cells()
	_owner.position = cells.pick_random() * 8
	_owner.update_fog()
	_owner.end_turn()
	return true
