extends AudioStreamPlayer2D

func _ready():
	pass

func _on_Sound_finished():
	Global.LEVEL_LAYER_FOG.remove_child(self)
	pass
