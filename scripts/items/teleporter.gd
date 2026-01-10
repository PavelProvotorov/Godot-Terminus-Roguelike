extends Item

func _ready():
	description = "<Teleporter>: This high-tech device teleports the user to a random spot in close proximity;"

func use() -> bool:
	var cells:Array = self.level.get_free_cells()
	var new_pos = cells.pick_random() * 8
	_sprite_animations.add_animation('teleport', self.level, true, _owner.position)
	_sprite_animations.add_animation('teleport', self.level, true, new_pos)
	_owner.position = new_pos
	_audio.play_sound(new_pos, Resources.SOUNDS.teleport)
	
	if _owner is Player: _owner.update_fog()

	remove_item()
	return false
