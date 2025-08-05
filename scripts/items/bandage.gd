extends Item

func _ready():
	set_item_instant()

func use() -> bool:
	var buff_added = _owner.add_buff('regeneration')
	if buff_added:
		remove_item()
		return true
	return false
