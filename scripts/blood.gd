extends AnimatedSprite
class_name Blood

enum COLOUR {RED, WHITE, GREY, GREEN}

const COLOURS_MAP = {
	COLOUR.RED: "RED",
	COLOUR.WHITE: "WHITE",
	COLOUR.GREEN: "GREEN",
	COLOUR.GREY: "GREY",
}

var blood_colour:String = "RED"

func set_colour(key:int) -> void:
	animation = COLOURS_MAP.get(key, "RED")

func _ready():
	randomize()
	set_frame(rand_range(0, get_sprite_frames().get_frame_count(self.animation)))
	flip_h = (randi() % 2)
	flip_v = (randi() % 2)
