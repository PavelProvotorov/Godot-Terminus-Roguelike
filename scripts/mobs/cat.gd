extends Ally

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.FLEE,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.FOLLOW,
		BEHAVIOUR_TYPE.MOVE,
		BEHAVIOUR_TYPE.IDLE
	]
	health = 10
	melee_damage = 2

func _post_flee_hook() -> void:
	self.add_buff('regeneration', 3, true)

func get_flee_behaviour_config() -> Dictionary:
	return {
		"health_threshold": 3,
		"flee_when_close": false,
		"skip_chance": 0,
	}
