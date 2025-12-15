extends AnimatedSprite

func _init():
	connect("animation_finished", self, '_on_animation_finished')
	z_index = 7

func _on_animation_finished() -> void:
	queue_free()
