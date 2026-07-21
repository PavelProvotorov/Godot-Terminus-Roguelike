extends EntityAI
class_name Ally

func _init():
	add_to_group('ALLY')
	health = 10

func _ready():
	set_active(true)
	hostile_groups = ["ENEMY"]
	set_random_frame()
	behaviours = [
		MeleeBehaviour.new(self, {}),
		FollowBehaviour.new(self, {
			"follower": Global.player
		}),
		MoveBehaviour.new(self, {}),
	]
