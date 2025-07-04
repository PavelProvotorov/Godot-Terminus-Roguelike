extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.RANGED,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
	]
	health = 4
	attack_range = 2
	melee_damage = 2
	ranged_damage = 1

func handle_ranged_attack(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	var target_pos = target.position
	set_sprite_direction(start, finish)
	yield(play_ranged_animation(start, finish), 'completed')
	target.position = self.position
	self.position = target_pos
	target.receive_damage(ranged_damage)
	post_handle_movement({
		"prev_pos": start / grid_size,
		"new_pos": target_pos / grid_size,
	})
	end_turn()
