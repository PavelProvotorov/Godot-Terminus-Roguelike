extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.RANGED,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 2
	damage = 1

func handle_ranged_attack(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	var target_pos = target.position
	set_sprite_direction(start, finish)
	yield(play_ranged_animation(start, finish), 'completed')
	Events.emit_signal("enemy_moved", self.position, target_pos)
	target.position = self.position
	self.position = target_pos
	end_turn()

func handle_melee_attack(data:Dictionary) -> void:
	var start = data.start
	var finish = data.finish
	var target_pos = target.position
	set_sprite_direction(start, finish)
	yield(play_ranged_animation(start, finish), 'completed')
	Events.emit_signal("enemy_moved", self.position, target_pos)
	target.position = self.position
	self.position = target_pos
	end_turn()
