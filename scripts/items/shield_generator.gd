extends Item

func _ready():
	description = "<Shield Generator>: A powerful protective device which generates a damage deflecting shield around the user;"
	action = ConsumeItem.new(self, {
		"on_check": funcref(self, "on_check"),
		"on_use": funcref(self, "on_use"),
		"use_turn": true,
	})

	
func on_check() -> bool:
	return _entity.add_buff('shield', 5, true)

func on_use() -> void:
	pass
