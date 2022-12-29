extends CanvasLayer

onready var NODE_ANIMATION_PLAYER = $AnimationPlayer

func _ready():
	transition_out(1)
	pass

func transition_in(playback_speed):
	NODE_ANIMATION_PLAYER.set_speed_scale(playback_speed)
	NODE_ANIMATION_PLAYER.play("animation_transition_in")
	NODE_ANIMATION_PLAYER.emit_signal("animation_finished")
	pass

func transition_out(playback_speed):
	NODE_ANIMATION_PLAYER.set_speed_scale(playback_speed)
	NODE_ANIMATION_PLAYER.play("animation_transition_out")
	NODE_ANIMATION_PLAYER.emit_signal("animation_finished")
	pass
