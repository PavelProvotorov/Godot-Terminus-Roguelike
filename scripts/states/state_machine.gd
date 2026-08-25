extends Node
class_name StateMachine

onready var STATE = {
	"IDLE": $Idle,
	"ACTIVE": $Active,
	"RANGED": $Ranged,
	"THROW": $Throw,
	"INVENTORY": $Inventory
}

onready var current_state:State = STATE.ACTIVE

func change_state(state_name: String, data:Dictionary = {}) -> void:
	var upper_state_name = state_name.to_upper()
	
	if STATE.has(upper_state_name):
		
		current_state.disable_state(data)
		
		print("CHANGED STATE TO: " + upper_state_name)
		current_state = STATE.get(upper_state_name)
		
		var check = current_state.check(data)
		if check == true:
			current_state.enable_state(data)
		else:
			change_state("IDLE", data)
		
	else:
		push_error("State does not exist in state machine configuration: " + upper_state_name)
		change_state("IDLE", data)

func is_current_state(state: State) -> bool:
	return current_state == state
