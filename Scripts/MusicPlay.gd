extends AudioStreamPlayer

onready var NODE_TWEEN = $Tween
onready var transition_duration = 2.00
onready var transition_type = 1
onready var sound_parent

func _ready():
	Global.CURRENT_MUSIC = self
	yield(get_tree(),"idle_frame")
	music_fade_in()
	pass

func music_fade_in():
	NODE_TWEEN.interpolate_property(self, "volume_db", -80, -12, transition_duration, transition_type, Tween.EASE_OUT, 0)
	NODE_TWEEN.start()
	yield(NODE_TWEEN,"tween_all_completed")
	on_music_fade_in_completed()
	pass

func music_fade_out():
	NODE_TWEEN.interpolate_property(self, "volume_db", -12, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	NODE_TWEEN.start()
	yield(NODE_TWEEN,"tween_all_completed")
	on_music_fade_out_completed()
	pass

func on_music_fade_out_completed():
	self.stop()
	sound_parent.remove_child(self)
	pass

func on_music_fade_in_completed():
	pass

func _on_Sound_finished():
	sound_parent.remove_child(self)
	pass
