extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.SPAWNER
	]
	attack_range = 2
	damage = 1

func handle_spawning(data: Dictionary) -> void:
	if nearby_free_cells.size() != 0:
		for cell in nearby_free_cells:
			var instance = Resources.debug_maggot.instance()
			instance.add_to_group("ACTIVE")
			_level.spawn_enemy(position / grid_size, instance)
			Events.emit_signal("enemy_spawned", cell * grid_size)
			yield(instance.play_move_animation(Vector2.ZERO, cell * grid_size), 'completed')
		process_death()
	end_turn()

#func handle_ranged_attack(data:Dictionary) -> void:
#	var start = data.start
#	var finish = data.finish
#	var target_pos = target.position
#	set_sprite_direction(start, finish)
#	yield(play_ranged_animation(start, finish), 'completed')
#	Events.emit_signal("enemy_moved", self.position, target_pos)
#	target.position = self.position
#	self.position = target_pos
#	end_turn()
#
#func handle_melee_attack(data:Dictionary) -> void:
#	var start = data.start
#	var finish = data.finish
#	var target_pos = target.position
#	set_sprite_direction(start, finish)
#	yield(play_ranged_animation(start, finish), 'completed')
#	Events.emit_signal("enemy_moved", self.position, target_pos)
#	target.position = self.position
#	self.position = target_pos
#	end_turn()
