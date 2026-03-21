extends Enemy2D

var buff_recharge:int = 8
var buff_trigger_count:int = 8

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.FLEE,
		BEHAVIOUR_TYPE.RANGED,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
		BEHAVIOUR_TYPE.OPEN_DOOR,
		BEHAVIOUR_TYPE.WANDER,
	]
	attack_range = 2
	health = 4
	ranged_damage = 2
	melee_damage = 1
	visibility = 5
	set_wandering(true)

func _turn_started_hook():
	buff_recharge += 1
	
	if buff_recharge >= buff_trigger_count \
		and is_active() \
		and path.size() > 0 \
		and path.size() <= 4 \
		:
		add_buff('shield', 5, true)
		buff_recharge = 0
		
func get_flee_behaviour_config() -> Dictionary:
	return {
		"health_threshold": 0,
		"flee_when_close": true,
		"skip_chance": 25,
	}
