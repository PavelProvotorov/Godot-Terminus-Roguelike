extends State

func _init():
	name = 'IDLE'

func _input(event):
	if _state_machine.is_current_state(self.name):
		
		if Input.is_action_just_pressed("ui_skip"):
			state_active()
			_player.handle_idle({})
			
		if Input.is_action_just_pressed("ui_up"):
			state_active()
			var action = _player.check_move_direction(Vector2.UP * GRID_SIZE)
			if !action: state_idle()
			
		if Input.is_action_just_pressed("ui_down"):
			state_active()
			var action = _player.check_move_direction(Vector2.DOWN * GRID_SIZE)
			if !action: state_idle()
			
		if Input.is_action_just_pressed("ui_left"): 
			state_active()
			_player._sprite.flip_h = true
			var action = _player.check_move_direction(Vector2.LEFT * GRID_SIZE)
			if !action: state_idle()
			
		if Input.is_action_just_pressed("ui_right"): 
			state_active()
			_player._sprite.flip_h = false
			var action = _player.check_move_direction(Vector2.RIGHT * GRID_SIZE)
			if !action: state_idle()
			
		if Input.is_action_just_pressed("ui_pickup"):
			state_active()
			var action = _player.handle_item_pickup()
			if !action: state_idle()
			
		if Input.is_action_just_pressed("ui_space"):
			state_ranged()
			
		if Input.is_action_just_pressed("ui_inventory"):
			state_inventory()

func _on_state_changed(state: String, data: Dictionary) -> void:
	if state == self.name.to_upper():
		self.set_process_input(true)
		get_tree().call_group("ENEMY", "remove_target_animation")
		_player.set_idle_animation()
	else:
		self.set_process_input(false)
