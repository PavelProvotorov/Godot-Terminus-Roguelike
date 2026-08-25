extends Item

const damage = 5
const throw_range = 3

func _ready():
	description = "<Grenade>: A standard combat explosive used to deliver high damage in close range;"
	action = ThrowItem.new(self, {
			"on_use": funcref(self, "on_use"),
			"get_targets": funcref(self, "get_targets"),
			"get_damage": funcref(self, "get_damage"),
			"sfx": Resources.SOUNDS.explosion_0,
			"range": throw_range,
		})
		
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var target_positions:Array = _utility.get_nearby_cells_8(impact_pos)
	target_positions.append(impact_pos)
	return get_reachable_targets(target_positions, impact_pos)
	
func get_damage(distance:int, offset:int) -> int:
	if offset > 0:
		return damage - 2
	return damage

func on_use(origin_pos:Vector2, impact_pos:Vector2) -> void:
	var impact_positions:Array = _utility.get_nearby_cells_8(impact_pos)
	impact_positions.append(impact_pos)
	
	for cell in get_reachable_cells(impact_positions, impact_pos):
		_sprite_animations.add_animation('explosion', self.level, true, cell)
