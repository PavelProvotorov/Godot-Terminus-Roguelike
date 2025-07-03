extends Buff

func _ready():
	original_name = 'strength'
	melee_damage_modifier = 1
	duration = 5
	add_to_group('MELEE_DAMAGE_BUFF')
