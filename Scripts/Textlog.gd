extends Label

func _ready():
	pass

func show_text():
	visible_characters = 0
	for i in get_total_character_count():
		if Global.NODE_UI_TEXT.visible == true:
			visible_characters += 1
			$AudioStreamPlayer.play()
			yield(get_tree().create_timer(0.025),"timeout")
		elif Global.NODE_UI_TEXT.visible == false:
			return
	pass

func get_idle_frame():
	yield(get_tree(),"idle_frame")
