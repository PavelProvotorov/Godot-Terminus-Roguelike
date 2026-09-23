extends Item

func _init():
	description = "<Bramble>: Once touched it rapidly wraps its spiky brambles around your skin;"
	action = ConsumeItem.new(self, {
		"on_check": funcref(self, "on_check"),
		"on_use": funcref(self, "on_use"),
		"use_turn": true,
	})
	
func on_check() -> bool:
	return _entity.add_buff('thorns', 15, true)

func on_use() -> void:
	pass
