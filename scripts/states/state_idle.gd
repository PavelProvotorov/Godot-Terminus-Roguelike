extends State

func _init():
	name = 'IDLE'

func _input(event):
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
		
	if Input.is_action_just_pressed("ui_interact"):
		state_active()
		var action = _player.handle_interaction()
		if !action: state_idle()
		
	if Input.is_action_just_pressed("ui_space"):
		state_ranged()
		
	if Input.is_action_just_pressed("ui_inventory"):
		state_inventory()

func _on_state_enabled(data: Dictionary) -> void:
	get_tree().call_group("ENEMY", "remove_target_animation")
	_player.set_idle_animation()
