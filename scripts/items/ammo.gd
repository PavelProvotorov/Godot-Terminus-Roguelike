extends Item

func _ready():
	category = CATEGORY.INSTANT
	action = ConsumeItem.new(self, {
		"on_check": funcref(self, "on_check"),
		"on_use": funcref(self, "on_use"),
		"use_turn": true,
	})
	
func on_check() -> bool:
	return _entity.recharge_ammo(5)

func on_use() -> void:
	pass
