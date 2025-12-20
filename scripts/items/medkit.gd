extends Item

func _ready():
	description = "<Medkit>: A portable medical kit which restores health on use and removes ailments;"

func use() -> bool:
	if _owner.restore_health(4):
		_owner.remove_buff('poison')
		_owner.remove_buff('bleed')
		remove_item()
		_owner.end_turn()
		return true
	return false
