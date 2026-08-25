extends State

var throw_range:int = 0

func _init():
	name = 'THROW'

func _input(event):
		
	if Input.is_action_just_pressed("ui_up"):
		state_active()
		_player.check_throw_direction(Vector2.UP * GRID_SIZE, throw_range)
		
	if Input.is_action_just_pressed("ui_down"):
		state_active()
		_player.check_throw_direction(Vector2.DOWN * GRID_SIZE, throw_range)
		
	if Input.is_action_just_pressed("ui_left"):
		state_active()
		_player.flip_animation(true)
		_player.check_throw_direction(Vector2.LEFT * GRID_SIZE, throw_range)
		
	if Input.is_action_just_pressed("ui_right"):
		state_active()
		_player.flip_animation(false)
		_player.check_throw_direction(Vector2.RIGHT * GRID_SIZE, throw_range)
		
	if Input.is_action_just_pressed("ui_skip"):
		state_active()
		_player.emit_signal("throw_successful", false, null)

func check(data:Dictionary) -> bool:
	return true

func _on_state_enabled(data: Dictionary) -> void:
	set_variables(data)
	_player.set_throw_animation()
	
	var targets:Array = _player.get_targets_in_range(self.throw_range)
	for target in targets:
		target.add_target_animation()

func _on_state_disabled(data:Dictionary) -> void:
	get_tree().call_group("ENEMY", "remove_target_animation") 

func set_variables(data:Dictionary) -> void:
	throw_range = data.get('range', 0)
