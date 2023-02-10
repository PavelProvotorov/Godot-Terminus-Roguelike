extends AudioStreamPlayer2D

var sound_parent

func _ready():
	pass

func _on_Sound_finished():
	sound_parent.remove_child(self)
	pass
