extends State

func _init():
	name = 'RANGED'

func _input(event):
	if _state_machine.is_current_state(self.name):
		
		if Input.is_action_just_pressed("ui_up"):
			state_active()
			var action = _player.shoot_in_direction(Vector2.UP * GRID_SIZE)
			if !action: state_idle()
			
		if Input.is_action_just_pressed("ui_down"):
			state_active()
			var action = _player.shoot_in_direction(Vector2.DOWN * GRID_SIZE)
			if !action: state_idle()
			
		if Input.is_action_just_pressed("ui_left"):
			state_active()
			var action = _player.shoot_in_direction(Vector2.LEFT * GRID_SIZE)
			if !action: state_idle()
			
		if Input.is_action_just_pressed("ui_right"):
			state_active()
			var action = _player.shoot_in_direction(Vector2.RIGHT * GRID_SIZE)
			if !action: state_idle()
			
		if Input.is_action_just_pressed("ui_space"):
			state_idle()

func _on_state_changed(state:String, data:Dictionary) -> void:
	if state == self.name.to_upper():
		self.set_process_input(true)
		_player.set_ranged_animation()
		_player.check_targets_in_range(
			_player.get_shot_range()
		)
	else:
		self.set_process_input(false)
