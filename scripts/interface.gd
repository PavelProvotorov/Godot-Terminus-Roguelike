extends Control

onready var _ammo_label = $AmmoLabel
onready var _health_label = $HealthLabel

func _ready():
	add_to_group('INTERFACE')
	Events.connect("player_health_changed", self, "_on_health_changed")
	Events.connect("player_ammo_changed", self, "_on_ammo_changed")

func _on_health_changed(health:int) -> void:
	_health_label.text = str(health)
	
func _on_ammo_changed(ammo:int) -> void:
	_ammo_label.text = str(ammo)
