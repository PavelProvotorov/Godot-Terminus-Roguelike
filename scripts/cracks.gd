extends AnimatedSprite

func _ready():
	randomize()
	set_frame(rand_range(0, get_sprite_frames().get_frame_count("CRACKS")))
	flip_h = (randi() % 2)
	flip_v = (randi() % 2)
