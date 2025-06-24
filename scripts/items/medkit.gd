extends Item

func use() -> bool:
	_owner.restore_health(3)
	_owner.end_turn()
	return true
