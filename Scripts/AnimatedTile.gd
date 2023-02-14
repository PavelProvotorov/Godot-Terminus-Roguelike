extends AnimatedTexture

func _init():
	var frame_count = self.frames
	var frame = randi()%frame_count
	set_current_frame(frame)
	pass
