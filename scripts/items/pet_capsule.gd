extends Item

onready var cats = [
	Resources.debug_cat_maison,
	Resources.debug_cat_sorik,
	Resources.debug_cat_luxor
]

func _ready():
	description = "<Pet Capsule>: A device to awaken a foreign creature hybernating inside;"
	action = ConsumeItem.new(self, {
		"on_check": funcref(self, "on_check"),
		"on_use": funcref(self, "on_use"),
		"use_turn": true,
	})
	
func on_check() -> bool:
	return _entity.get_nearby_cells().size() > 0

func on_use() -> void:
	var nearby_cells = _entity.get_nearby_cells()
	var cell = nearby_cells.pick_random()
	var instance = cats.pick_random().instance()
	
	self.level.spawn_enemy(cell, instance)
	instance.previous_position = cell * grid_size
	instance.update_position(cell * grid_size)
	
	_audio.play_sound(cell * grid_size, Resources.SOUNDS.teleport)
