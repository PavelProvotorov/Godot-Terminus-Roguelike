extends Item

func _ready():
	set_item_consumable()

func use() -> bool:
	_owner.throw_state_bind(self, '_on_item_used', {
		'throw_damage': 8,
		'throw_range': 3
	})
	return true


