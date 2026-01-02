extends Item

func _init():
	throw_range = 3
	throw_damage = 5

func _ready():
	description = "<Grenade>: A standard combat explosive used to deliver high damage in close range;"

func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var targets:Array = []
	var impact_positions = [
		impact_pos,
	]
	targets.append_array(get_reachable_targets(impact_positions, impact_pos))
	
	_sprite_animations.add_animation('explosion', self.level, true, impact_pos)
	
	return targets

func use() -> bool:
	_owner.throw_state_bind(self, '_on_item_thrown', {
		'throw_item': self
	})
	return true


