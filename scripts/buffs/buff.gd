extends Node2D
class_name Buff

onready var _sprite_animations:SpriteAnimations2D = SpriteAnimations2D.new()
onready var _buff_manager = get_parent()
onready var target = _buff_manager.get_parent()
onready var _audio:Audio2D = Audio2D.new()
onready var _utility:Utility = Utility.new()

signal buff_expired

onready var LIFECYCLE = {
	ON_TICK = funcref(self, "_on_buff_tick_hook"),
}

var icon = Resources.icon_none
var original_name:String = ''
var is_valid:bool = true
var melee_damage_modifier = 0
var ranged_damage_modifier = 0
var visibility_modifier = 0
var resistance_modifier = 0
var speed_modifier = 0
var duration = 0

func tick():
	duration -= 1
	
#	Currently does not work with coroutines
	var hook = _utility.call_funcref(LIFECYCLE.ON_TICK)
	
	if duration <= 0:
		emit_signal("buff_expired", self)
		queue_free()
		return
	
func set_duration(duration:int) -> void:
	self.duration = min(99, duration)
	
func is_active() -> bool:
	return self.duration > 0

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
