extends Node
class_name State

onready var _state_machine = get_parent()
onready var _player = get_tree().get_first_node_in_group("PLAYER")
const GRID_SIZE = 8

func _ready():
	_state_machine.connect("state_changed", self, "_on_state_changed")

func _on_state_changed(state: String) -> void:
	if state == self.name.to_upper():
		self.set_process_input(true)
	else:
		self.set_process_input(false)
