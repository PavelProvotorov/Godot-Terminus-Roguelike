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
		if Input.is_action_just_pressed("ui_inventory"):
			_inventory.reset_state()
			_state_machine.change_state('IDLE')

func _on_state_changed(state: String) -> void:
	if state == self.name.to_upper():
		self.set_process_input(true)
		_inventory.reset_state()
		_inventory.select_first_item()
		_player.set_idle_animation()
	else:
		self.set_process_input(false)
