extends Buff
class_name BuffBulwark

func _ready():
	Callback.add(Callback.TYPE.DAMAGE_RECEIVED, funcref(self, "_on_damage_received"), self)
	icon = Resources.icon_bulwark
	original_name = 'bulwark'
	resistance_modifier = -2
	add_to_group('RESISTANCE_BUFF')

func _on_damage_received(damage:int, attacker, receiver:Entity2D) -> void:
	if receiver != target:
		return
	print("BULWARK DAMAGE TRIGGERED")
	target.remove_buff("bulwark")
