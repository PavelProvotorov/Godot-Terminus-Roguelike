extends Item

func _ready():
	set_item_instant()

func use() -> bool:
	var buff_added = _owner.add_buff('regeneration')
	if buff_added:
		_owner.end_turn()
		remove_item()
		return true
	return false
