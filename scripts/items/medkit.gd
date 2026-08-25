extends Item

func _ready():
	description = "<Medkit>: A portable medical kit which restores health on use and removes ailments;"
	action = ConsumeItem.new(self, {
		"on_check": funcref(self, "on_check"),
		"on_use": funcref(self, "on_use"),
		"use_turn": true,
	})
	
func on_check() -> bool:
	return _entity.restore_health(4)

func on_use() -> void:
	_entity.remove_buff('poison')
	_entity.remove_buff('bleed')
