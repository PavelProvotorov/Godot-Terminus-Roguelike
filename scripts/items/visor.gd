extends Item

func _ready():
	description = "<Visor>: High-tech visor which enhances your visibility in the dark;"
	action = ConsumeItem.new(self, {
		"on_check": funcref(self, "on_check"),
		"on_use": funcref(self, "on_use"),
		"use_turn": true,
	})
	
func on_check() -> bool:
	return _entity.add_buff('vision', 60, true)

func on_use() -> void:
	pass
