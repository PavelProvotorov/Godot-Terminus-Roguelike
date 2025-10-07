extends Node
class_name State

onready var _state_machine = get_parent()
onready var _player = get_tree().get_first_node_in_group("PLAYER")
onready var ON_STATE_ENABLED = funcref(self, "_on_state_enabled")
const GRID_SIZE = 8

func _ready():
	self.set_process_input(false)

func get_name() -> String:
	return self.name.to_upper()

func enable_state(data: Dictionary) -> void:
	if ON_STATE_ENABLED.is_valid(): 
		ON_STATE_ENABLED.call_func(data)
	
	if _state_machine.is_current_state(self.name):
		self.set_process_input(true)

func _on_state_enabled(data: Dictionary) -> void:
	pass

func state_idle() -> void:
	self.set_process_input(false)
	_state_machine.change_state('IDLE')
	
func state_active() -> void:
	self.set_process_input(false)
	_state_machine.change_state('ACTIVE')
	
func state_ranged() -> void:
	self.set_process_input(false)
	_state_machine.change_state('RANGED')
	
func state_inventory() -> void:
	self.set_process_input(false)
	_state_machine.change_state('INVENTORY')
