extends AnimatedSprite

func _init():
	connect("animation_finished", self, '_on_animation_finished')
	z_index = 6
	
func _ready():
	randomize()
#	self.set_frame(rand_range(0, self.get_sprite_frames().get_frame_count("IDLE")))
	self.flip_h = (randi() % 2)
	self.flip_v = (randi() % 2)

func _on_animation_finished() -> void:
	queue_free()
