extends AudioStreamPlayer2D

#onready var NODE_SOUND_PLAY = $SoundPlay
var sound_parent

func _ready():
	pass

func _on_Sound_finished():
	sound_parent.remove_child(self)
	pass
