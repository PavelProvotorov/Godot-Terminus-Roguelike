extends Control
class_name Weapon

onready var _static_body = $StaticBody2D

var damage:int = 0
var shot_range:int = 0
var shot_count:int = 0
var ammo_consumption:int = 1

func _ready():
	add_to_group('WEAPON')
	
func get_shot_count() -> int:
	return shot_count

func get_shot_range() -> int:
	return shot_range

func get_damage() -> int:
	return damage
