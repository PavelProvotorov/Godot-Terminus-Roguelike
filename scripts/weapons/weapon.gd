extends Item
class_name Weapon

onready var _tree:SceneTree = get_tree()

var damage:int = 0
var shot_range:int = 0
var shot_count:int = 0
var ammo_consumption:int = 0

func _ready():
	add_to_group('WEAPON')

func use():
	_owner.end_turn()
	
func get_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var targets:Array = []
	targets.append_array(
		get_reachable_targets([impact_pos], impact_pos)
	)
	return targets
	
func is_horizontal(direction:Vector2) -> bool:
	return direction in [Vector2.LEFT, Vector2.RIGHT]

func is_vertical(direction:Vector2) -> bool:
	return direction in [Vector2.UP, Vector2.DOWN]
	
func get_shot_count() -> int:
	return shot_count

func get_shot_range() -> int:
	return shot_range

func get_damage(distance:int, offset:int) -> int:
	return damage
	
func get_ammo_consumption(ammo:int) -> int:
	return ammo - ammo_consumption
