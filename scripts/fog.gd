extends AnimatedTexture

func _init():
	Events.connect("level_fog_updated", self, "_on_level_fog_updated")

func _on_level_fog_updated(cells:Array) -> void:
	set_current_frame(0)
