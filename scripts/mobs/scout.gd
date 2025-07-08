extends Enemy2D

var buff_recharge:int = 8
var buff_trigger_count:int = 8

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.WANDER,
		BEHAVIOUR_TYPE.RANGED,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 2
	health = 3
	ranged_damage = 2
	melee_damage = 1
	setup()

func _turn_started_hook():
	buff_recharge += 1
	
	if buff_recharge >= buff_trigger_count \
		and is_active() \
		and path.size() > 0 \
		and path.size() <= 4 \
		:
		add_buff('shield')
		buff_recharge = 0
