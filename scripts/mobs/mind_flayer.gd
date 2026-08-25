extends Enemy2D

func _ready():
	behaviours = [
		RangedBehaviour.new(self, {
			"post_hook": funcref(self, "post_ranged"),
		}),
		MeleeBehaviour.new(self, {
			"post_hook": funcref(self, "post_melee"),
		}),
		MoveBehaviour.new(self, {}),
	]
	health = 4
	attack_range = 2
	melee_damage = 2
	ranged_damage = 1

func post_ranged() -> void:
	var self_pos = self.position
	var target_pos = target.position
	
	_sprite_animations.add_animation('teleport', self.level, true, self_pos)
	_audio.play_sound(self_pos, Resources.SOUNDS.teleport)
	_sprite_animations.add_animation('teleport', self.level, true, target_pos)
	
	target.update_position(self_pos, false)
	self.update_position(target_pos, false)

func post_melee() -> void:
	var cells:Array = self.level.get_entity_free_cells()
	var new_pos = cells.pick_random() * 8
	
	_sprite_animations.add_animation('teleport', self.level, true, target.position)
	target.update_position(new_pos)
	_audio.play_sound(new_pos, Resources.SOUNDS.teleport)
	
	_sprite_animations.add_animation('teleport', self.level, true, new_pos)
