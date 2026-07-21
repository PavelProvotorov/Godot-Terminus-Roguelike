extends Item

onready var cats = [
	Resources.debug_cat_maison,
	Resources.debug_cat_sorik,
	Resources.debug_cat_luxor
]

func _ready():
	description = "<Pet Capsule>: A device to awaken a foreign creature hybernating inside;"

func use() -> bool:
	var nearby_cells = _owner.get_nearby_cells()
	var cell = nearby_cells.pick_random()
	var instance = cats.pick_random().instance()
	self.level.spawn_enemy(cell, instance)
	instance.previous_position = cell * grid_size
	instance.update_position(cell * grid_size)
	
	_audio.play_sound(cell, Resources.SOUNDS.teleport)

	remove_item()
	_owner.end_turn()
	return false
