extends Buff
class_name BuffShield

func _ready():
	connect("tree_exiting", self, "_on_tree_exiting")
	icon = Resources.icon_shield
	original_name = 'shield'
	resistance_modifier = -99
	add_to_group('RESISTANCE_BUFF')
	_sprite_animations.add_animation('shield', self)
	_audio.play_sound(target.position, Resources.SOUNDS.shield_enable)

func _on_tree_exiting():
	_audio.play_sound(target.position, Resources.SOUNDS.shield_disable)
