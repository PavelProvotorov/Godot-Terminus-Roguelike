extends Buff
class_name BuffBulwark

var last_position:Vector2

func _ready():
	Callback.add(Callback.TYPE.DAMAGE_RECEIVED, funcref(self, "_on_damage_received"), self)
	icon = Resources.icon_bulwark
	original_name = 'bulwark'
	resistance_modifier = -2
	add_to_group('RESISTANCE_BUFF')
	_audio.play_sound(target.position, Resources.SOUNDS.use)
	last_position = target.position

func _on_damage_received(damage:int, attacker, receiver:Entity2D) -> void:
	if receiver != target:
		return
	target.remove_buff("bulwark")

func _on_buff_tick_hook() -> void:
	if last_position == target.position:
		self.duration += 1
