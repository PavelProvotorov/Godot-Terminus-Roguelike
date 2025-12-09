extends Node2D
class_name BuffManager

onready var _text_animations = TextAnimations2D.new()

onready var BUFF_LIST:Dictionary = {
	'shield': load("res://scenes/buffs/BuffShield.tscn"),
	'speed': load("res://scenes/buffs/BuffSpeed.tscn"),
	'strength': load("res://scenes/buffs/BuffStrength.tscn"),
	'blindness': load("res://scenes/buffs/BuffBlindness.tscn"),
	'poison': load("res://scenes/buffs/BuffPoison.tscn"),
	'bleed': load("res://scenes/buffs/BuffBleed.tscn"),
	'regeneration': load("res://scenes/buffs/BuffRegeneration.tscn"),
	'stun': load("res://scenes/buffs/BuffStun.tscn")
}

var callback:FuncRef
	
func init(callback:FuncRef):
	self.callback = callback

func add_buff(buff:String, duration:int, self_applied:bool) -> bool:
	
	if is_applied(buff):
#		_text_animations.display_text("<X>", get_parent().position)
		return false
	
	if is_shielded() and not self_applied:
		return false
	
	var resource = BUFF_LIST.get(buff)
	
	if resource:
		var instance:Buff = resource.instance()
		instance.set_duration(duration)
		add_child(instance)
		on_buff_changed_callback()
		return true
	else:
		printerr("Buff not available: ", buff)
	return false
	
func get_buffs() -> Array:
	var buffs:Array = []
	
	for child in get_children():
		var buff:Buff = child
		
		buffs.append({
			"name": buff.original_name,
			"duration": buff.duration,
			"icon": buff.icon,
		})
	return buffs

func tick_buffs():
	for buff in get_children():
		if buff is Buff:
			buff.tick()
		else:
			printerr("Invalid child node in buff manager: ", buff)
	on_buff_changed_callback()

func on_buff_changed_callback() -> void:
	if callback is FuncRef and callback.is_valid():
		callback.call_funcv([get_buffs()])

func get_resisted_damage(damage:int) -> int:
	var resisted_damage = damage
	for buff in get_children():
		if buff is Buff and buff.is_in_group("RESISTANCE_BUFF"):
			resisted_damage += buff.get_resistance_modifier()
	return resisted_damage

func get_modified_melee_damage(damage:int) -> int:
	var modified_damage = damage
	for buff in get_children():
		if buff is Buff and buff.is_in_group("MELEE_DAMAGE_BUFF"):
			modified_damage += buff.get_melee_damage_modifier()
	return modified_damage

func get_modified_ranged_damage(damage:int) -> int:
	var modified_damage = damage
	for buff in get_children():
		if buff is Buff and buff.is_in_group("RANGED_DAMAGE_BUFF"):
			modified_damage += buff.get_ranged_damage_modifier()
	return modified_damage

func get_modified_speed(speed:int) -> int:
	var modified_speed = speed
	for buff in get_children():
		if buff is Buff and buff.is_in_group("SPEED_BUFF"):
			modified_speed += buff.get_speed_modifier()
	return modified_speed

func get_modified_visibility(visibility:int) -> int:
	var modified_visibility = visibility
	for buff in get_children():
		if buff is Buff and buff.is_in_group("VISIBILITY_BUFF"):
			modified_visibility += buff.get_visibility_modifier()
	return modified_visibility
	
func is_applied(buff_name:String) -> bool:
	for buff in get_children():
		if buff is Buff:
			if buff.original_name == buff_name:
				return true
	return false
	
func is_shielded() -> bool:
	for buff in get_children():
		if buff is BuffShield:
			return true
	return false
