extends Item

func _ready():
	description = "<Medkit>: A portable medical kit which restores health on use;"

func use() -> bool:
	if _owner.restore_health(4):
		_owner.end_turn()
		remove_item()
		return true
	return false
