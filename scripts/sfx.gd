extends Node
class_name Sfx

func _ready():
	connect("finished", self, '_on_sfx_finished')

func _on_sfx_finished():
	self.queue_free()
