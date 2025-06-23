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

signal state_changed(state)

func change_state(state: String) -> void:
	if STATE.has(state):
		current_state = state
		self.emit_signal('state_changed', state.to_upper())
		print("CHANGED STATE TO: " + state)
	else:
		current_state = STATE.IDLE
		self.emit_signal('state_changed', state.to_upper())
		push_error("State does not exist: " + state)

func is_current_state(state: String) -> bool:
	return current_state == state.to_upper()
