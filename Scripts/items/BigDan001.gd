extends Item2D

const ANIMATIONS= {
	IDLE_1 = "IDLE_1",
	IDLE_2 = "IDLE_2",
	IDLE_3 = "IDLE_3",
	IDLE_4 = "IDLE_4",
	IDLE_5 = "IDLE_5"
}

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	item_name = "BigDan-001"
	item_text = item_prepare_text()
	NODE_NAME.set_text(item_name)
	
	# PREPARE STARTING ANIMATIONS
	var current_animation = ANIMATIONS.IDLE_1
	
	if Global.LEVEL_COUNT in range(1,5):
		current_animation = ANIMATIONS.IDLE_1
	elif Global.LEVEL_COUNT in range(6,10):
		current_animation = ANIMATIONS.IDLE_2
	elif Global.LEVEL_COUNT in range(11,15):
		current_animation = ANIMATIONS.IDLE_3
	elif Global.LEVEL_COUNT in range(16,20):
		current_animation = ANIMATIONS.IDLE_4
	elif Global.LEVEL_COUNT in range(21,25):
		current_animation = ANIMATIONS.IDLE_5
	else:
		pass
		
	$AnimatedSprite.set_animation(current_animation)
	$AnimatedSprite.set_frame(rand_range(0,$AnimatedSprite.get_sprite_frames().get_frame_count(current_animation)))
	pass

# ACTIONS
#---------------------------------------------------------------------------------------
func on_action_pickup():
	item_display_text(self,item_text)
	pass
