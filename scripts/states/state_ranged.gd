extends State

func _init():
	name = 'RANGED'

func _input(event):
	if _state_machine.is_current_state(self.name):
		if Input.is_action_just_pressed("ui_up"):
			_state_machine.change_state('ACTIVE')
			var action = _player.shoot_in_direction(Vector2.UP * GRID_SIZE)
			if !action: _state_machine.change_state('IDLE')
		if Input.is_action_just_pressed("ui_down"):
			_state_machine.change_state('ACTIVE')
			var action = _player.shoot_in_direction(Vector2.DOWN * GRID_SIZE)
			if !action: _state_machine.change_state('IDLE')
		if Input.is_action_just_pressed("ui_left"):
			_state_machine.change_state('ACTIVE')
			var action = _player.shoot_in_direction(Vector2.LEFT * GRID_SIZE)
			if !action: _state_machine.change_state('IDLE')
		if Input.is_action_just_pressed("ui_right"):
			_state_machine.change_state('ACTIVE')
			var action = _player.shoot_in_direction(Vector2.RIGHT * GRID_SIZE)
			if !action: _state_machine.change_state('IDLE')
		if Input.is_action_just_pressed("ui_space"):
			_state_machine.change_state('IDLE')

func _on_state_changed(state:String, data:Dictionary) -> void:
	if state == self.name.to_upper():
		self.set_process_input(true)
		_player.set_ranged_animation()
		_player.check_targets_in_range(
			_player.get_attack_range()
		)
	else:
		self.set_process_input(false)
