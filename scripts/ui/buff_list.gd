extends Control

onready var _container = $GridContainer

func _ready():
	add_to_group('BUFF_LIST')
	Events.connect("player_buffs_changed", self, "_on_player_buffs_changed")

func _on_player_buffs_changed(buffs:Array) -> void:
	var active_buff_names: Array = []
	for buff in buffs:
		active_buff_names.append(buff.get("name"))

	for child in _container.get_children():
		if not child.get_name() in active_buff_names:
			child.queue_free()

	for buff in buffs:
		var buff_name: String = buff.get("name")
		var buff_duration: int = buff.get("duration")
		var buff_icon: Object = buff.get("icon")
		
		var existing_card = _container.get_node_or_null(buff_name)
		
		if existing_card != null and not existing_card.is_queued_for_deletion():
			existing_card.set_duration(buff_duration)
		else:
			var instance: BuffCard = Resources.buff_card.instance()
			instance.name = buff_name 
			_container.add_child(instance)
			instance.set_card(
				buff_name,
				buff_duration,
				buff_icon
			)
