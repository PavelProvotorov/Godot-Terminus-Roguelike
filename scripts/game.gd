extends Node2D

onready var _viewport = $ViewportContainer/Viewport
onready var _transition = $ViewportContainer/Viewport/TransitionCanvas/TransitionPlayer
onready var _game_canvas = $ViewportContainer/Viewport/RootCanvas/GameCanvas
onready var _root_canvas = $ViewportContainer/Viewport/RootCanvas
onready var _audio:Audio2D = Audio2D.new()

func _ready():
	Events.connect("game_ended", self, "_on_game_ended")
	Events.connect("game_started", self, "_on_game_started")
	Events.connect("level_descended", self, "_on_level_descended")
	Events.connect("level_generation_complete", self, "_on_level_generation_complete")

func _on_game_started():
	load_next_level()
	
func _on_game_ended():
	yield(play_transition_in(), "completed")
	
	_root_canvas.queue_free()
	var old_player = Global.get_player()
	old_player.queue_free()
	
	Global.set_player(Resources.player.instance())
	Global.set_depth(0)
	
	var instance = Resources.root_cavas.instance()
	_viewport.add_child(instance)
	
	_root_canvas = instance
	_game_canvas = _root_canvas.get_node("GameCanvas")
	yield(play_transition_out(), "completed")

func _on_level_descended():
	_audio.play_global_sound(Resources.SOUNDS.descend)
	yield(play_transition_in(), "completed")
	var config = Resources.level_configuration
	var current_depth = Global.get_depth()
	var player = Global.get_player()
	var level = Global.get_level()
	Global.set_depth(current_depth + 1)
	
	player.get_parent().remove_child(player)
	_game_canvas.remove_child(level.get_parent())
	level.get_parent().queue_free()
	load_next_level()

func load_next_level():
	var config = Resources.level_configuration
	var current_depth = Global.get_depth()
	var next_scene:PackedScene = config.get(current_depth, 0).get('scene', Resources.factory_scene)
	print("LEVEL DEPTH IS: ", Global.get_depth())
	_game_canvas.add_child(next_scene.instance())
	
func _on_level_generation_complete(level:Level) -> void:
	yield(play_transition_out(), "completed")
	level.process_queue()
	
func play_fade_in():
	_transition.play("fade_in")
	return yield(_transition, "animation_finished")

func play_transition_in():
	_transition.play("transition_in")
	return yield(_transition, "animation_finished")

func play_transition_out():
	_transition.play("transition_out")
	return yield(_transition, "animation_finished")
