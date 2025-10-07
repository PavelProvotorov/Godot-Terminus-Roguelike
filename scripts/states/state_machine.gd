extends Node
class_name StateMachine

const STATE = {
	IDLE = 'IDLE',
	ACTIVE = 'ACTIVE',
	RANGED = 'RANGED',
	THROW = 'THROW',
	INVENTORY = 'INVENTORY'
}
onready var current_state = STATE.ACTIVE

signal state_changed(state, data)

func change_state(state: String, data:Dictionary = {}) -> void:
	if STATE.has(state):
		current_state = state
		
		if state == STATE.ACTIVE:
			print("CHANGED STATE TO: " + state)
			return
		
		for child in get_children():
			
			if not child is State:
				push_error("Non-state child in state machine: " + child)
				break
			
			if child.get_name() == state.to_upper():
				print("CHANGED STATE TO: " + state)
				child.enable_state(data)
				break 
	else:
		push_error("State does not exist in state machine configuration: " + state)
		change_state(STATE.IDLE, data)

func is_current_state(state: String) -> bool:
	return current_state == state.to_upper()
