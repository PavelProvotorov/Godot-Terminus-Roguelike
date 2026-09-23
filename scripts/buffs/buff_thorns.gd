extends Buff
class_name BuffThorns

func _ready():
	Callback.add(Callback.TYPE.DAMAGE_RECEIVED, funcref(self, "_on_damage_received"), self)
	icon = Resources.icon_thorns
	original_name = 'thorns'

func _on_damage_received(damage:int, attacker, receiver:Entity2D) -> void:
	var node = attacker as Entity2D 
	if not node and receiver != target: 
		return
	print("THORNS REFLECTING DAMAGE TO: ", node)
	node.receive_damage(self, 1)
