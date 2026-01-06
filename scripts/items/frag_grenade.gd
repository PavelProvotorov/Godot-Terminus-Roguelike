extends Item

func _init():
	throw_range = 3
	throw_damage = 5

func _ready():
	description = "<Frag Grenade>: A high-level combat explosive designed to inflict maximum damage in large impact area;"

func use() -> bool:
	_owner.throw_state_bind(self, '_on_item_thrown', {
		'throw_item': self
	})
	return true
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var targets:Array = []
	var impact_positions = [
		impact_pos,
		Vector2(impact_pos.x, impact_pos.y - 8),
		Vector2(impact_pos.x, impact_pos.y+8),
		Vector2(impact_pos.x-8, impact_pos.y),
		Vector2(impact_pos.x+8, impact_pos.y),
		Vector2(impact_pos.x+8, impact_pos.y+8),
		Vector2(impact_pos.x+8, impact_pos.y-8),
		Vector2(impact_pos.x-8, impact_pos.y+8),
		Vector2(impact_pos.x-8, impact_pos.y-8),
	]
	
	targets.append_array(get_reachable_targets(impact_positions, impact_pos))
	
	for cell in get_reachable_cells(impact_positions, impact_pos):
		_sprite_animations.add_animation('explosion', self.level, true, cell)
	
	_audio.play_sound(impact_pos, Resources.SOUNDS.explosion_0)
	return targets

func get_throw_damage(distance:int, offset:int) -> int:
	if offset == 0:
		return throw_damage
	return throw_damage - 2

