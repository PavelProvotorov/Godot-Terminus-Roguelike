extends Control

onready var _start_button = $MarginContainer/VBoxContainer/VBoxContainer/CenterContainer/MarginContainer2/ButtonStart
onready var _settings_button = $MarginContainer/VBoxContainer/VBoxContainer/CenterContainer2/MarginContainer3/ButtonSettings
onready var _about_button = $MarginContainer/VBoxContainer/VBoxContainer/CenterContainer3/MarginContainer/ButtonAbout

func _ready():
	_start_button.connect("button_down", self, "_on_start_button_pressed")
	_settings_button.connect("button_down", self, "_on_settings_button_pressed")
	_about_button.connect("button_down", self, "_on_about_button_pressed")
	_start_button.grab_focus()

func _on_start_button_pressed():
	Events.emit_signal("game_started")
	queue_free()

func _on_settings_button_pressed():
	pass

func _on_about_button_pressed():
	pass
