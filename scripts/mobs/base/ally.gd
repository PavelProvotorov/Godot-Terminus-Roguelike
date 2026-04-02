extends EntityAI

func _init():
	add_to_group('ALLY')
	health = 10

func _ready():
	set_active(true)
	hostile_groups = ["ENEMY"]
	set_random_frame()
	behaviours = [
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.FOLLOW,
		BEHAVIOUR_TYPE.MOVE,
		BEHAVIOUR_TYPE.IDLE
	]

func follow_behaviour_config() -> Dictionary:
	return {
		"follower": Global.player
	}
