extends Item

func _ready():
	category = CATEGORY.INSTANT
	action = ConsumeItem.new(self, {
		"on_check": funcref(self, "on_check"),
		"on_use": funcref(self, "on_use"),
		"use_turn": true,
	})
	
func on_check() -> bool:
	if _entity.is_max_health():
		return false
	return _entity.add_buff('regeneration', 2, true)

func on_use() -> void:
	pass
