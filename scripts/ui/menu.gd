extends Control

onready var _start_button = $MarginContainer/VBoxContainer/VBoxContainer/CenterContainer/MarginContainer2/ButtonStart
onready var _settings_button = $MarginContainer/VBoxContainer/VBoxContainer/CenterContainer2/MarginContainer3/ButtonSettings
onready var _customise_button = $MarginContainer/VBoxContainer/VBoxContainer/CenterContainer4/MarginContainer3/ButtonCustomise
onready var _about_button = $MarginContainer/VBoxContainer/VBoxContainer/CenterContainer3/MarginContainer/ButtonAbout
onready var _audio:Audio2D = Audio2D.new()

func _ready():
	_start_button.connect("pressed", self, "_on_start_button_pressed")
	_settings_button.connect("pressed", self, "_on_settings_button_pressed")
	_customise_button.connect("pressed", self, "_on_customise_button_pressed")
	_about_button.connect("pressed", self, "_on_about_button_pressed")
	_start_button.grab_focus()

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		_audio.play_global_sound(Resources.SOUNDS.menu_move)
	
	if Input.is_action_just_pressed("ui_down"):
		_audio.play_global_sound(Resources.SOUNDS.menu_move)
		
	if Input.is_action_just_pressed("ui_up"):
		_audio.play_global_sound(Resources.SOUNDS.menu_move)

func _on_start_button_pressed():
	Events.emit_signal("game_started")
	queue_free()

func _on_customise_button_pressed():
	var parent = get_parent()
	parent.add_child(Resources.customise_scene.instance())
	queue_free()

func _on_settings_button_pressed():
	pass

func _on_about_button_pressed():
	pass
