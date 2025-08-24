extends Item

func _init():
	throw_range = 3
	throw_damage = 4

func _ready():
	description = "<Grenade>: A standard combat explosive used to deliver high damage in close range;"

func use() -> bool:
	_owner.throw_state_bind(self, '_on_item_thrown', {
		'throw_item': self
	})
	return true


