extends Control

func _ready():
	add_to_group('INTERFACE')
	Events.connect("player_health_changed", self, "_on_health_changed")
	Events.connect("player_ammo_changed", self, "_on_ammo_changed")

func _on_health_changed(health) -> void:
	pass
	
func _on_ammo_changed(ammo) -> void:
	pass
