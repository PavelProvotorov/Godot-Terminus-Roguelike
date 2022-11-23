extends Label

func _ready():
	pass

func show_text():
	visible_characters = 0
	for i in text.length():
		visible_characters += 1
		yield(get_tree().create_timer(0.025),"timeout")
	pass
