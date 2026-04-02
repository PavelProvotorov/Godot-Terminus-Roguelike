extends Enemy2D

var buff_used = false

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
		BEHAVIOUR_TYPE.WANDER,
	]
	attack_range = 1
	health = 5
	melee_damage = 2

func _turn_started_hook():
	
	if buff_used == true:
		return
	
	if is_active() and path.size() > 0  and target_in_sight():
		add_buff('speed', 3)
		buff_used = true
