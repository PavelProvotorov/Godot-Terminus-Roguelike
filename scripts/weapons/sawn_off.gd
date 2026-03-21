extends RangedWeapon

var rng = RandomNumberGenerator.new()

func _init():
	damage = 4
	shot_range = 1
	shot_count = 1
	ammo_consumption = 1
	shot_sound = Resources.SOUNDS.shot_shotgun
	
func _ready():
	rng.randomize()
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var direction = origin_pos.direction_to(impact_pos)
	var forward_cell = (impact_pos + (direction * grid_size))
	var targets:Array = []
	
	var left = Vector2(-direction.y, direction.x)
	var right = Vector2(direction.y, -direction.x)

	var positions = [
		impact_pos,
		forward_cell,
		forward_cell + left * grid_size,
		forward_cell + right * grid_size,
	]
	
	targets.append_array(get_reachable_targets(positions, impact_pos))
		
	return targets

func get_damage(distance:int, offset:int) -> int:
	if offset == 0:
		return rng.randi_range(3, damage)
	return rng.randi_range(1, 2)
