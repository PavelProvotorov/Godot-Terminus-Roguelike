extends Item

func _init():
	description = "<Tesla Coil>: Passively shocks nearby enemies when activated;"
	action = ConsumeItem.new(self, {
		"on_check": funcref(self, "on_check"),
		"on_use": funcref(self, "on_use"),
		"use_turn": true,
	})
	
func on_check() -> bool:
	return _entity.add_buff('electrified', 20, true)

func on_use() -> void:
	pass
