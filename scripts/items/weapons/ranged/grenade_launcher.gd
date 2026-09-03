extends Item

const shot_range:int = 4
const damage:int = 5

func _init():
	category = CATEGORY.RANGED_WEAPON
	action = ShootItem.new(self, {
		"get_damage": funcref(self, "get_damage"),
		"get_targets": funcref(self, "get_targets"),
		"on_use": funcref(self, "on_use"),
		"sfx": Resources.SOUNDS.explosion_0,
		"consumption": 4,
		"range": shot_range,
		"shots": 1,
	})
	
func on_use(origin_pos:Vector2, impact_pos:Vector2) -> void:
	var cells = _utility.get_nearby_cells_8(impact_pos)
	cells.append(impact_pos)
	
	for cell in cells:
		_sprite_animations.add_animation('explosion', self.level, true, cell)
		self.level.add_decorative_sprite(Resources.sprite_crack.instance(), cell)
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var target_positions:Array = _utility.get_nearby_cells_8(impact_pos)
	target_positions.append(impact_pos)
	return get_reachable_targets(target_positions, impact_pos)
	
func get_damage(distance:int, offset:int) -> int:
	if offset > 0:
		return damage - 2
	return damage
