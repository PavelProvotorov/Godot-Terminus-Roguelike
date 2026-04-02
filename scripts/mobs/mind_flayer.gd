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

func _post_ranged_attack_hook() -> void:
	var self_pos = self.position
	var target_pos = target.position
	
	_sprite_animations.add_animation('teleport', self.level, true, self_pos)
	_audio.play_sound(self_pos, Resources.SOUNDS.teleport)
	_sprite_animations.add_animation('teleport', self.level, true, target_pos)
	
	target.update_position(self_pos, false)
	self.update_position(target_pos, false)

func _post_melee_attack_hook() -> void:
	var cells:Array = self.level.get_free_cells()
	var new_pos = cells.pick_random() * 8
	
	_sprite_animations.add_animation('teleport', self.level, true, target.position)
	target.update_position(new_pos)
	_audio.play_sound(new_pos, Resources.SOUNDS.teleport)
	
	_sprite_animations.add_animation('teleport', self.level, true, new_pos)
