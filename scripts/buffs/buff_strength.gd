extends Buff

func _ready():
	icon = Resources.icon_strength
	original_name = 'strength'
	melee_damage_modifier = 1
	add_to_group('MELEE_DAMAGE_BUFF')
