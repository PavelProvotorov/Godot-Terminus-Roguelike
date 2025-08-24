extends State

onready var _inventory:Inventory = get_tree().get_first_node_in_group("INVENTORY")

func _init():
	name = 'INVENTORY'

func _input(event):
	if _state_machine.is_current_state(self.name):
		
		if Input.is_action_just_pressed("ui_left"): 
			_inventory.switch_selected_item(-1)
			
		if Input.is_action_just_pressed("ui_right"): 
			_inventory.switch_selected_item(1)
			
		if Input.is_action_just_pressed("ui_pickup"):
			state_active()
			var action = _inventory.use_selected_item()
			_inventory.reset_state()
			if !action: state_idle()
			
		if Input.is_action_just_pressed("ui_skip"):
			
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

func _on_state_changed(state:String, data:Dictionary) -> void:
	if state == self.name.to_upper():
		
		if _inventory.is_inventory_empty():
			state_idle()
			return
		
		self.set_process_input(true)
		_inventory.reset_state()
		_inventory.select_first_item()
		_player.set_idle_animation()
	else:
		self.set_process_input(false)
