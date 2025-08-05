extends Item

func _ready():
	description = "<Steroids>: A powerful enhancer which temporarily increases strength upon injection;"
	set_item_consumable()

func use() -> bool:
	var buff_added = _owner.add_buff('strength')
	if buff_added:
		_owner.end_turn()
		remove_item()
		return true
	return false
