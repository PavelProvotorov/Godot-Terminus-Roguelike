extends Node
class_name SpriteAnimations2D

var ANIMATIONS: Dictionary = {
	'target': preload("res://resources/animations/AnimationTarget.tscn"),
	'shield': preload("res://resources/animations/AnimationShield.tscn"),
	'selected': preload("res://resources/animations/AnimationSelected.tscn"),
	'stun': preload("res://resources/animations/AnimationStun.tscn"),
	'explosion': preload("res://resources/animations/AnimationExplosion.tscn"),
	'teleport': preload("res://resources/animations/AnimationTeleport.tscn"),
	'spark': preload("res://resources/animations/AnimationSpark.tscn"),
}
var storage: Dictionary = {}

func _init() -> void:
	pass

func add_animation(name: String, node:Node, store:bool = false, pos:Vector2 = Vector2.ZERO) -> void:
	if ANIMATIONS.has(name):
		
		var resource = ANIMATIONS.get(name)
		var instance = resource.instance()
		instance.position = pos
		
		if not store and not storage.has(name):
			storage[name] = instance
		
		node.add_child(instance)
	else:
		push_error("Animation not found, failed to add: " + name)

func remove_animation(name: String, node:Node) -> void:
	if ANIMATIONS.has(name):
		if storage.has(name):
			var child = storage.get(name)
			storage.erase(name)
			child.queue_free()
	else:
		push_error("Animation not found, failed to remove: " + name)
