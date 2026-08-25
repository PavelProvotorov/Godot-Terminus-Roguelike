extends Item

func _init():
	description = "<Adrenalin>: An emergency stimulant which boosts reaction and speed upon injection;"
	action = ConsumeItem.new(self, {
		"on_check": funcref(self, "on_check"),
		"on_use": funcref(self, "on_use"),
		"use_turn": false,
	})
	
func on_check() -> bool:
	return _entity.add_buff('speed', 3, true)

func on_use() -> void:
	pass
