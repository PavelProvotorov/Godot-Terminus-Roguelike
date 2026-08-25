extends Item

func _ready():
	description = "<Steroids>: A powerful enhancer which temporarily increases strength upon injection;"
	action = ConsumeItem.new(self, {
		"on_check": funcref(self, "on_check"),
		"on_use": funcref(self, "on_use"),
		"use_turn": true,
	})

	
func on_check() -> bool:
	return _entity.add_buff('strength', 7, true)

func on_use() -> void:
	pass
