extends Node
class_name SpriteAnimations2D

var animation_target = preload("res://resources/animations/AnimationTarget.tscn")
var animation_shield = preload("res://resources/animations/AnimationShield.tscn")
var ANIMATIONS: Dictionary = {}
var storage: Dictionary = {}
var parent

func _init(parent) -> void:
	self.parent = parent
	
	ANIMATIONS = {
		'target': animation_target,
		'shield': animation_shield
	}

func add_animation(name: String) -> void:
	if ANIMATIONS.has(name):
		if not storage.has(name):
			var resource = ANIMATIONS.get(name)
			var instance = resource.instance()
			storage[name] = instance
			parent.add_child(instance)
	else:
		push_error("Animation not found, failed to add: " + name)

func remove_animation(name: String) -> void:
	if ANIMATIONS.has(name):
		if storage.has(name):
			var child = storage.get(name)
			storage.erase(name)
			child.queue_free()
	else:
		push_error("Animation not found, failed to remove: " + name)
