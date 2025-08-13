extends Item

func _ready():
	set_item_instant()

func use() -> bool:
	if _owner.recharge_ammo(5):
		_owner.end_turn()
		remove_item()
		return true
	return false
