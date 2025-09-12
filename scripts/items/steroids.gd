extends Item

func _init():
	description = "<Steroids>: A powerful enhancer which temporarily increases strength upon injection;"

func use() -> bool:
	var buff_added = _owner.add_buff('strength', true)
	if buff_added:
		_owner.end_turn()
		remove_item()
		return true
	return false
