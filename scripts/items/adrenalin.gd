extends Item

func _init():
	description = "<Adrenalin>: An emergency stimulant which boosts reaction and speed upon injection;"

func use() -> bool:
	var buff_added = _owner.add_buff('speed', 3, true)
	if buff_added:
		remove_item()
		_owner.end_turn()
		return true
	return false
