extends Node
class_name StateMachine

const STATE = {
	IDLE = 'IDLE',
	ACTIVE = 'ACTIVE',
	RANGED = 'RANGED',
	THROW = 'THROW',
	INVENTORY = 'INVENTORY'
}
onready var current_state = STATE.IDLE

signal state_changed(state, data)

func change_state(state: String, data:Dictionary = {}) -> void:
	if STATE.has(state):
		current_state = state
		print("CHANGED STATE TO: " + state)
		self.emit_signal('state_changed', state.to_upper(), data)
	else:
		current_state = STATE.IDLE
		self.emit_signal('state_changed', state.to_upper(), data)
		push_error("State does not exist: " + state)

func is_current_state(state: String) -> bool:
	return current_state == state.to_upper()
