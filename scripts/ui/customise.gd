extends Control

onready var _switch_head_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/CenterContainer2/MarginContainer3/SwitchHead
onready var _switch_body_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/CenterContainer4/MarginContainer/SwitchBody
onready var _return_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/CenterContainer/MarginContainer2/Return
onready var _head_sprite = $MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/TextureRect/HeadSprite
onready var _body_sprite = $MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/TextureRect/BodySprite
onready var _audio:Audio2D = Audio2D.new()

func _ready():
	update_body_texture()
	update_head_texture()
	_switch_head_button.connect("pressed", self, "_on_switch_head_button_pressed")
	_switch_body_button.connect("pressed", self, "_on_switch_body_button_pressed")
	_return_button.connect("pressed", self, "_on_return_button_pressed")
	_switch_head_button.grab_focus()
	
func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		_audio.play_global_sound(Resources.SOUNDS.menu_move)
	
	if Input.is_action_just_pressed("ui_down"):
		_audio.play_global_sound(Resources.SOUNDS.menu_move)
		
	if Input.is_action_just_pressed("ui_up"):
		_audio.play_global_sound(Resources.SOUNDS.menu_move)
	
func _on_switch_head_button_pressed() -> void:
	var current_index = (Config.get_player_head() + 1)
	var next_index = current_index % Resources.head_spritesheet.size()
	Config.set_player_head(next_index)
	update_head_texture()

func _on_switch_body_button_pressed() -> void:
	var current_index = (Config.get_player_body() + 1)
	var next_index = current_index % Resources.body_spritesheet.size()
	Config.set_player_body(next_index)
	update_body_texture()

func _on_return_button_pressed() -> void:
	var parent = get_parent()
	parent.add_child(Resources.menu_scene.instance())
	queue_free()

func update_head_texture() -> void:
	_head_sprite.texture = Resources.head_spritesheet.get(Config.get_player_head())

func update_body_texture() -> void:
	_body_sprite.texture = Resources.body_spritesheet.get(Config.get_player_body())

