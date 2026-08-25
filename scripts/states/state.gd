extends Node
class_name State

onready var _state_machine = get_parent()
onready var _player:Player = get_tree().get_first_node_in_group("PLAYER")
onready var ON_STATE_ENABLED = funcref(self, "_on_state_enabled")
onready var ON_STATE_DISABLED = funcref(self, "_on_state_disabled")
const GRID_SIZE = 8

func _ready():
	self.set_process_input(false)
	add_to_group("STATE")

func get_name() -> String:
	return self.name.to_upper()

func enable_state(data: Dictionary) -> void:
	_on_state_enabled(data)
	
	if _state_machine.is_current_state(self):
		self.set_process_input(true)

func disable_state(data: Dictionary) -> void:
	self.set_process_input(false)
	_on_state_disabled(data)
	
func check(data: Dictionary) -> bool:
	return true

func _on_state_enabled(data: Dictionary) -> void:
	pass

func _on_state_disabled(data: Dictionary) -> void:
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
