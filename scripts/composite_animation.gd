extends Node2D

onready var _animation:AnimationPlayer = $CompositePlayer
onready var _head_sprite:Sprite = $Head
onready var _body_sprite:Sprite = $Body

var head_sheet:int = 0
var body_sheet:int = 0 

func _ready():
	_animation.current_animation = 'IDLE'
	_head_sprite.texture = Resources.head_spritesheet.get(Config.get_player_head())
	_body_sprite.texture = Resources.body_spritesheet.get(Config.get_player_body())
	
func play_idle_animation():
	_animation.current_animation = 'IDLE'

func play_ranged_animation():
	_animation.current_animation = 'RANGED'

func play_inventory_animation():
	_animation.current_animation = 'INVENTORY'
	
func play_throw_animation():
	_animation.current_animation = 'THROW'
	
func stop():
	_animation.stop()
	
func play():
	_animation.play()

func flip_animation(flip:bool):
	_head_sprite.flip_h = flip
	_body_sprite.flip_h = flip
