extends Control

onready var _container = $GridContainer

func _ready():
	add_to_group('BUFF_LIST')
	Events.connect("player_buffs_changed", self, "_on_player_buffs_changed")

func _on_player_buffs_changed(buffs:Array) -> void:

	for buff in buffs:
		var buff_name:String = buff.get("name")
		var buff_duration:int = buff.get("duration")
		var buff_icon:Object = buff.get("icon")
		var buff_found:bool = false
		
		for child in _container.get_children():
			
			if child.get_name() == buff_name:
				child.set_duration(buff_duration)
				buff_found = true
				break
		
		if not buff_found:
			var instance:BuffCard = Resources.buff_card.instance()
			_container.add_child(instance)
			instance.set_card(
				buff_name,
				buff_duration,
				buff_icon
			)
