extends Consumable

func use() -> bool:
	if _owner.recharge_ammo(5):
		remove_item()
		_owner.end_turn()
		return true
	return false
