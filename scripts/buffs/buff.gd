extends Node2D
class_name Buff

onready var _sprite_animations:SpriteAnimations2D = SpriteAnimations2D.new(self)

var original_name:String = ''
var melee_damage_modifier = 0
var ranged_damage_modifier = 0
var visibility_modifier = 0
var resistance_modifier = 0
var speed_modifier = 0
var duration = 1

func tick():
	duration -= 1
	
	if duration <= 0:
		queue_free()

func get_speed_modifier() -> int:
	return speed_modifier

func get_melee_damage_modifier() -> int:
	return melee_damage_modifier
	
func get_ranged_damage_modifier() -> int:
	return ranged_damage_modifier
	
func get_resistance_modifier() -> int:
	return resistance_modifier

func get_visibility_modifier() -> int:
	return visibility_modifier
