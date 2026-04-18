extends Buff

func _ready():
	icon = Resources.icon_strength
	original_name = 'strength'
	melee_damage_modifier = 1
	_sprite_animations.add_animation('strength', self)
	add_to_group('MELEE_DAMAGE_BUFF')
