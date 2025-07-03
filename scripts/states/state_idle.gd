extends State

func _init():
	name = 'IDLE'

func _input(event):
	if _state_machine.is_current_state(self.name):
		if Input.is_action_just_pressed("ui_skip"):
			_state_machine.change_state('ACTIVE')
			_player.handle_idle({})
		if Input.is_action_just_pressed("ui_up"):
			_state_machine.change_state('ACTIVE')
			var action = _player.check_move_direction(Vector2.UP * GRID_SIZE)
			if !action: _state_machine.change_state('IDLE')
		if Input.is_action_just_pressed("ui_down"):
			_state_machine.change_state('ACTIVE')
			var action = _player.check_move_direction(Vector2.DOWN * GRID_SIZE)
			if !action: _state_machine.change_state('IDLE')
		if Input.is_action_just_pressed("ui_left"): 
			_state_machine.change_state('ACTIVE')
			_player._sprite.flip_h = true
			var action = _player.check_move_direction(Vector2.LEFT * GRID_SIZE)
			if !action: _state_machine.change_state('IDLE')
		if Input.is_action_just_pressed("ui_right"): 
			_state_machine.change_state('ACTIVE')
			_player._sprite.flip_h = false
			var action = _player.check_move_direction(Vector2.RIGHT * GRID_SIZE)
			if !action: _state_machine.change_state('IDLE')
		if Input.is_action_just_pressed("ui_pickup"):
			_state_machine.change_state('ACTIVE')
			var action = _player.handle_item_pickup()
			if !action: _state_machine.change_state('IDLE')
		if Input.is_action_just_pressed("ui_space"):
			_state_machine.change_state('RANGED')
		if Input.is_action_just_pressed("ui_inventory"):
			_state_machine.change_state('INVENTORY')

func _on_state_changed(state: String, data: Dictionary) -> void:
	if state == self.name.to_upper():
		self.set_process_input(true)
		get_tree().call_group("ENEMY", "remove_target_animation")
		_player.set_idle_animation()
	else:
		self.set_process_input(false)
