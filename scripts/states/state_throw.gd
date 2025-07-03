extends State

var throw_range:int
var throw_damage:int

func _init():
	name = 'THROW'

func _input(event):
	if _state_machine.is_current_state(self.name):
		if Input.is_action_just_pressed("ui_up"):
			_state_machine.change_state('ACTIVE')
			var action = _player.throw_in_direction(
				Vector2.UP * GRID_SIZE,
				throw_range,
				throw_damage
			)
			if not action: _state_machine.change_state('IDLE')
			_player.throw_state_notify(action)
			
		if Input.is_action_just_pressed("ui_down"):
			_state_machine.change_state('ACTIVE')
			var action = _player.throw_in_direction(
				Vector2.DOWN * GRID_SIZE,
				throw_range,
				throw_damage
			)
			if not action: _state_machine.change_state('IDLE')
			_player.throw_state_notify(action)
			
		if Input.is_action_just_pressed("ui_left"):
			_state_machine.change_state('ACTIVE')
			var action = _player.throw_in_direction(
				Vector2.LEFT * GRID_SIZE,
				throw_range,
				throw_damage
			)
			if not action: _state_machine.change_state('IDLE')
			_player.throw_state_notify(action)
			
		if Input.is_action_just_pressed("ui_right"):
			_state_machine.change_state('ACTIVE')
			var action = _player.throw_in_direction(
				Vector2.RIGHT * GRID_SIZE,
				throw_range,
				throw_damage
			)
			if not action: _state_machine.change_state('IDLE')
			_player.throw_state_notify(action)
			
		if Input.is_action_just_pressed("ui_skip"):
			_player.throw_state_notify(false)
			_state_machine.change_state('IDLE')
			
		if Input.is_action_just_pressed("ui_space"):
			_state_machine.change_state('ACTIVE')
			_player.throw_state_notify(true)

func _on_state_changed(state:String, data:Dictionary) -> void:
	if state == self.name.to_upper():
		self.set_process_input(true)
		set_variables(data)
		_player.set_throw_animation()
		_player.check_targets_in_range(
			throw_range
		)
	else:
		self.set_process_input(false)

func set_variables(data:Dictionary) -> void:
	throw_damage = data.get('throw_damage', 0)
	throw_range = data.get('throw_range', 0)
