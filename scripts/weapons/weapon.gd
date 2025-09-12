extends Item
class_name Weapon

onready var _tree:SceneTree = get_tree()

var shot_damage:int = 0
var shot_range:int = 0
var shot_count:int = 0
var ammo_consumption:int = 1

func _ready():
	add_to_group('WEAPON')

func use():
	_owner.end_turn()
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var targets:Array = []
	
	targets.append_array(
		match_pos_to_target([impact_pos])
	)
	return targets
	
func match_pos_to_target(positions:Array) -> Array:
	var entities:Array = _tree.get_nodes_in_group("ENTITY")
	var targets:Array = []
	for entity in entities:
		if entity.position in positions:
			targets.append(entity)
	return targets
	
func is_horizontal(direction:Vector2) -> bool:
	return direction in [Vector2.LEFT, Vector2.RIGHT]

func is_vertical(direction:Vector2) -> bool:
	return direction in [Vector2.UP, Vector2.DOWN]
	
func get_shot_count() -> int:
	return shot_count

func get_shot_range() -> int:
	return shot_range

func get_shot_damage(distance:int, offset:int) -> int:
	return shot_damage
	
func get_ammo_consumption(ammo:int) -> int:
	return ammo - ammo_consumption
