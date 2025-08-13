extends Node
class_name State

onready var _state_machine = get_parent()
onready var _player = get_tree().get_first_node_in_group("PLAYER")
const GRID_SIZE = 8

func _ready():
	_state_machine.connect("state_changed", self, "_on_state_changed")

func _on_state_changed(state: String, data: Dictionary) -> void:
	if state == self.name.to_upper():
		self.set_process_input(true)
	else:
		self.set_process_input(false)

func state_idle() -> void:
	_state_machine.change_state('IDLE')
	
func state_active() -> void:
	_state_machine.change_state('ACTIVE')
	
func state_ranged() -> void:
	_state_machine.change_state('RANGED')
	
func state_inventory() -> void:
	_state_machine.change_state('INVENTORY')
