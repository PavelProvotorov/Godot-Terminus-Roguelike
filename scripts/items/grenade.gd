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
	return get_reachable_targets([impact_pos], impact_pos)
	
func get_damage(distance:int, offset:int) -> int:
	return damage

func on_use(origin_pos:Vector2, impact_pos:Vector2) -> void:
	_sprite_animations.add_animation('explosion', self.level, true, impact_pos)
	self.level.add_decorative_sprite(Resources.sprite_crack.instance(), impact_pos)
