extends Item

func _init():
	description = "<Adrenalin>: An emergency stimulant which boosts reaction and speed upon injection;"

func use() -> bool:
	var buff_added = _owner.add_buff('speed', true)
	if buff_added:
		_owner.end_turn()
		remove_item()
		return true
	return false
