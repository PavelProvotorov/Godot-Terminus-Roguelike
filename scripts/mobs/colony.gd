extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.SPAWNER
	]
	attack_range = 2
	melee_damage = 1

func handle_spawning(data: Dictionary) -> void:
	var nearby_cells = get_nearby_cells()
	
	if nearby_cells.size() != 0:
		for cell in nearby_cells:
			var instance = Resources.debug_maggot.instance()
			yield(minion_spawn_and_move(
				instance,
				position,
				cell * grid_size
				), 
			"completed"
			)
		handle_death()
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
