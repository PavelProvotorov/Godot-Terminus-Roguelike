extends Node
class_name Sfx2D

onready var _stream_player = $AudioStreamPlayer2D
var stream:AudioStream

func _ready():
	_stream_player.connect("finished", self, '_on_sfx_finished')
	_stream_player.stream = self.stream
	_stream_player.play()

func _on_sfx_finished():
	self.queue_free()

func set_stream(sfx:AudioStream):
	self.stream = sfx
