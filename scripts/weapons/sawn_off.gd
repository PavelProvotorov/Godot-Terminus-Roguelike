extends Weapon

var rng = RandomNumberGenerator.new()

func _init():
	shot_damage = 4
	shot_range = 1
	shot_count = 1
	ammo_consumption = 1
	
func _ready():
	rng.randomize()
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var direction = origin_pos.direction_to(impact_pos)
	var forward_cell = (impact_pos + (direction * grid_size))
	var targets:Array = []
	
	targets.append_array(match_pos_to_target([
		
	]))
	
	if is_horizontal(direction):
		targets.append_array(match_pos_to_target([
			impact_pos,
			forward_cell,
			forward_cell + (Vector2.UP * grid_size),
			forward_cell + (Vector2.DOWN * grid_size),
		]))
	
	if is_vertical(direction):
		targets.append_array(match_pos_to_target([
			impact_pos,
			forward_cell,
			forward_cell + (Vector2.LEFT * grid_size),
			forward_cell + (Vector2.RIGHT * grid_size),
		]))
		
	return targets

func get_shot_damage(distance:int, offset:int) -> int:
	if offset == 0:
		return rng.randi_range(3, shot_damage)
	return rng.randi_range(1, 2)
