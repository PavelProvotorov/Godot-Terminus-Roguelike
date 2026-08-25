extends State

func _init():
	name = 'IDLE'

func _input(event):
	if Input.is_action_just_pressed("ui_skip"):
		state_active()
		_player.end_turn()
		
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
		_player.flip_animation(true)
		var action = _player.check_move_direction(Vector2.LEFT * GRID_SIZE)
		if !action: state_idle()
		
	if Input.is_action_just_pressed("ui_right"): 
		state_active()
		_player.flip_animation(false)
		var action = _player.check_move_direction(Vector2.RIGHT * GRID_SIZE)
		if !action: state_idle()
		
	if Input.is_action_just_pressed("ui_interact"):
		state_active()
		var action = _player.handle_interaction()
		if !action: state_idle()
		
	if Input.is_action_just_pressed("ui_space"):
		var ranged_weapon:Item = _player._inventory.get_ranged_weapon()
		if ranged_weapon.usable(): ranged_weapon.use()
		
	if Input.is_action_just_pressed("ui_inventory"):
		state_inventory()

func _on_state_enabled(data: Dictionary) -> void:
	get_tree().call_group("ENEMY", "remove_target_animation")
	_player.set_idle_animation()
	
func _on_state_disabled(data: Dictionary) -> void:
	pass
