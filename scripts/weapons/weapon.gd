extends Control
class_name Weapon

onready var _static_body = $StaticBody2D
var _tree:SceneTree

var damage:int = 0
var offset_damage:int = 0
var shot_range:int = 0
var shot_count:int = 0
var ammo_consumption:int = 1
var grid_size:int = 8

func _ready():
	add_to_group('WEAPON')
	
func get_shot_targets(origin_pos:Vector2, impact_pos:Vector2) -> Array:
	var targets:Array = []
	targets.append_array(
		match_pos_to_target([impact_pos])
	)
	return targets
	
func match_pos_to_target(positions:Array) -> Array:
	var enemies:Array = _tree.get_nodes_in_group("ENEMY")
	var targets:Array = []
	for enemy in enemies:
		if enemy.position in positions:
			targets.append(enemy)
	return targets
	
func is_horizontal(direction:Vector2) -> bool:
	return direction in [Vector2.LEFT, Vector2.RIGHT]

func is_vertical(direction:Vector2) -> bool:
	return direction in [Vector2.UP, Vector2.DOWN]
	
func get_shot_count() -> int:
	return shot_count

func get_shot_range() -> int:
	return shot_range
	
func get_offset_damage(distance:int) -> int:
	return offset_damage

func get_damage(distance:int) -> int:
	return damage
