extends AudioStreamPlayer2D
class_name Music

func _ready() -> void:
	Events.connect("game_started", self, "_on_game_started")
	Events.connect("change_music", self, "_on_change_music")
	connect("finished", self, "_on_finished")
	
func _process(delta) -> void:
	pass
	
func _on_finished() -> void:
	play()
	
func _on_change_music(sfx:AudioStreamOGGVorbis) -> void:
	if sfx == stream:
		return 
		
	yield(sound_fade_out(), "completed")
	stream = sfx
	sound_fade_in()
	play()
	
func _on_game_started() -> void:
	sound_fade_in()
	play()

func sound_fade_in() -> void:
	var tween:SceneTreeTween = self.create_tween()
	tween.tween_property(self, "volume_db", 0, 1.0)
	yield(tween, "finished")
	
func sound_fade_out() -> void:
	var tween:SceneTreeTween = self.create_tween()
	tween.tween_property(self, "volume_db", -80, 1.0)
	yield(tween, "finished")
