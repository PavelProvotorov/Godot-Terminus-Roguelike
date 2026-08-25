extends State

func _init():
	name = 'RANGED'

func _input(event):

	if Input.is_action_just_pressed("ui_up"):
		state_active()
		_player.emit_signal("shoot_successful", true, Vector2.UP * GRID_SIZE)
		
	if Input.is_action_just_pressed("ui_down"):
		state_active()
		_player.emit_signal("shoot_successful", true, Vector2.DOWN * GRID_SIZE)
		
	if Input.is_action_just_pressed("ui_left"):
		state_active()
		_player.flip_animation(true)
		_player.emit_signal("shoot_successful", true, Vector2.LEFT * GRID_SIZE)
		
	if Input.is_action_just_pressed("ui_right"):
		state_active()
		_player.flip_animation(false)
		_player.emit_signal("shoot_successful", true, Vector2.RIGHT * GRID_SIZE)
		
	if Input.is_action_just_pressed("ui_space"):
		state_idle()
		_player.emit_signal("shoot_successful", false, Vector2.ZERO)

func check(data:Dictionary) -> bool:
	if _player.is_ammo_depleted():
		_player.emit_signal("shoot_successful", false, Vector2.ZERO)
		state_idle()
		return false

	var targets:Array = _player.get_targets_in_range(data.get('range', 0))
	if not targets.size() > 0:
		_player.emit_signal("shoot_successful", false, Vector2.ZERO)
		state_idle()
		return false

	return true

func _on_state_enabled(data: Dictionary) -> void:
	_player.set_ranged_animation()
	
	var targets:Array = _player.get_targets_in_range(data.get('range', 0))
	for target in targets:
		target.add_target_animation()

func _on_state_disabled(data:Dictionary) -> void:
	get_tree().call_group("ENEMY", "remove_target_animation") 
