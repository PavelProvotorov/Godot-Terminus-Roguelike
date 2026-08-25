extends Item

func _ready():
	description = "<Teleporter>: This high-tech device teleports the user to a random spot in close proximity;"
	action = ConsumeItem.new(self, {
		"on_check": funcref(self, "on_check"),
		"on_use": funcref(self, "on_use"),
		"use_turn": false,
	})
	
func on_check() -> bool:
	return self.level.get_entity_free_cells().size() > 0

func on_use() -> void:
	var cells:Array = self.level.get_entity_free_cells()
	var new_pos = cells.pick_random() * 8
	_sprite_animations.add_animation('teleport', self.level, true, _entity.position)
	_sprite_animations.add_animation('teleport', self.level, true, new_pos)
	_entity.update_position(new_pos)
	_audio.play_sound(new_pos, Resources.SOUNDS.teleport)
