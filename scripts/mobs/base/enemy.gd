extends EntityAI
class_name Enemy2D

onready var spawn: bool = false

func _ready():
	add_to_group('ENEMY')
	set_random_frame()
	
func play_appear_animation() -> GDScriptFunctionState:
	return yield(_tween_animations.animation_appear(_sprite), 'completed')
	
func add_target_animation() -> void:
	_sprite_animations.add_animation("target", self)
	
func remove_target_animation() -> void:
	_sprite_animations.remove_animation("target", self)
	
func sort_by_distance(a, b) -> bool:
	var pos:Vector2 = target.position / grid_size
	return a.distance_to(pos) > b.distance_to(pos)
	
func minion_spawn_and_move(instance:KinematicBody2D, start:Vector2, finish:Vector2) -> void:
	instance.set_active(true)
	self.level.spawn_enemy(start / grid_size, instance)
	instance.previous_position = finish
	update_pathfinding(finish / grid_size, finish / grid_size)
	yield(instance.play_move_animation(Vector2.ZERO, finish), 'completed')
		
func receive_damage(damage:int, true_damage:bool = false) -> void:
	_audio.play_sound(self.position, Resources.SOUNDS.hit_0)
	.receive_damage(damage, true_damage)
