extends Item

func _ready():
	description = "<Shield Generator>: A powerful protective device which generates a damage deflecting shield around the user;"

func use() -> bool:
	var buff_added = _owner.add_buff('shield', 5, true)
	if buff_added:
		remove_item()
		_owner.end_turn()
		return true
	return false
