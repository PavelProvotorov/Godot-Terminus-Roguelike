extends Item

func _ready():
	set_item_instant()

func use() -> bool:
	_owner.recharge_ammo(5)
	remove_item()
	return true
