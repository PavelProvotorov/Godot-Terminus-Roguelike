extends Node2D

onready var _animation:AnimationPlayer = $CompositePlayer
onready var _head_sprite:Sprite = $Head
onready var _body_sprite:Sprite = $Body

const head_spritesheet: Dictionary = {
	0: preload("res://assets/composites/head/player_head_0.png"),
	1: preload("res://assets/composites/head/player_head_1.png")
}

const body_spritesheet: Dictionary = {
	0: preload("res://assets/composites/body/player_body_0.png"),
	1: preload("res://assets/composites/body/player_body_1.png")
}

var head_sheet:int = 0
var body_sheet:int = 0 

func _ready():
	_animation.current_animation = 'IDLE'
	_head_sprite.texture = head_spritesheet.get(1)
	_body_sprite.texture = body_spritesheet.get(1)
	
func play_idle_animation():
	_animation.current_animation = 'IDLE'

func play_ranged_animation():
	_animation.current_animation = 'RANGED'

func play_inventory_animation():
	_animation.current_animation = 'INVENTORY'
	
func play_throw_animation():
	_animation.current_animation = 'THROW'

func flip_animation(flip:bool):
	_head_sprite.flip_h = flip
	_body_sprite.flip_h = flip
