extends Node2D
class_name BuffManager

onready var _level = get_tree().get_first_node_in_group("LEVEL")
onready var _text_animations:TextAnimations2D = TextAnimations2D.new(_level)

onready var BUFF_LIST:Dictionary = {
	'shield': load("res://buffs/BuffShield.tscn"),
	'speed': load("res://buffs/BuffSpeed.tscn"),
	'strength': load("res://buffs/BuffStrength.tscn")
}

func add_buff(buff:String) -> bool:
	
	if is_applied(buff):
		_text_animations.display_text("<X>", get_parent().position)
		return false
	
	var resource = BUFF_LIST.get(buff)
	
	if resource:
		var instance = resource.instance()
		add_child(instance)
		return true
	else:
		printerr("Buff not available: ", buff)
	return false

func tick_buffs():
	for buff in get_children():
		if buff is Buff:
			buff.tick()
		else:
			printerr("Invalid child node in buff manager: ", buff)
			
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
	
func is_applied(buff_name:String) -> bool:
	for buff in get_children():
		if buff is Buff:
			if buff.original_name == buff_name:
				return true
	return false
