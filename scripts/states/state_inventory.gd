extends State

onready var _inventory:Inventory = get_tree().get_first_node_in_group("INVENTORY")

func _init():
	name = 'INVENTORY'

func _input(event):
		
	if Input.is_action_just_pressed("ui_left"): 
		_inventory.switch_selected_item(-1)
		
	if Input.is_action_just_pressed("ui_right"): 
		_inventory.switch_selected_item(1)
		
	if Input.is_action_just_pressed("ui_interact"):
		state_active()
		var action = _inventory.use_selected_item()
		_inventory.reset_state()
		if !action: state_idle()
		
	if Input.is_action_just_pressed("ui_skip"):
		state_active()
		
		if _player.is_position_occupied():
			_inventory.reset_state()
			state_idle()
			return
		
		var action = _inventory.drop_selected_item(_player.position)
		_inventory.reset_state()
		
		if action:
			_player.end_turn()
			return
		state_idle()
		
	if Input.is_action_just_pressed("ui_inventory"):
		_inventory.reset_state()
		state_idle()
			
func _on_state_enabled(data: Dictionary) -> void:
	if _inventory.is_inventory_empty():
		state_idle()
		return
	
	_inventory.reset_state()
	_inventory.switch_selected_item(0)
	_player.set_inventory_animation()
