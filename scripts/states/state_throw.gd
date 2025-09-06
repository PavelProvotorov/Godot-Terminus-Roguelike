extends State

var throw_item:Item

func _init():
	name = 'THROW'

func _input(event):
	if _state_machine.is_current_state(self.name):
		
		if Input.is_action_just_pressed("ui_up"):
			state_active()
			var action = _player.throw_in_direction(
				Vector2.UP * GRID_SIZE,
				throw_item
			)
			if not action: state_idle()
			_player.throw_state_notify(action)
			
		if Input.is_action_just_pressed("ui_down"):
			state_active()
			var action = _player.throw_in_direction(
				Vector2.DOWN * GRID_SIZE,
				throw_item
			)
			if not action: state_idle()
			_player.throw_state_notify(action)
			
		if Input.is_action_just_pressed("ui_left"):
			state_active()
			var action = _player.throw_in_direction(
				Vector2.LEFT * GRID_SIZE,
				throw_item
			)
			if not action: state_idle()
			_player.throw_state_notify(action)
			
		if Input.is_action_just_pressed("ui_right"):
			state_active()
			var action = _player.throw_in_direction(
				Vector2.RIGHT * GRID_SIZE,
				throw_item
			)
			if not action: state_idle()
			_player.throw_state_notify(action)
			
		if Input.is_action_just_pressed("ui_skip"):
			_player.throw_state_notify(false)
			state_idle()

func _on_state_changed(state:String, data:Dictionary) -> void:
	if state == self.name.to_upper():
		self.set_process_input(true)
		set_variables(data)
		
		if not _player.mark_targets_in_range(throw_item.get_throw_range()):
			state_idle()
			return
		
		_player.set_throw_animation()
	else:
		self.set_process_input(false)

func set_variables(data:Dictionary) -> void:
	throw_item = data.get('throw_item', null)
