extends Ally

func _ready():
	behaviours = [
		FleeBehaviour.new(self, {
			"health_threshold": 3,
			"flee_when_close": false,
			"skip_chance": 0,
			"post_hook": funcref(self, "post_flee")
		}),
		MeleeBehaviour.new(self, {}),
		FollowBehaviour.new(self, {
			"follower": Global.player,
		}),
		MoveBehaviour.new(self, {}),
	]
	health = 10
	melee_damage = 2

func post_flee() -> void:
	self.add_buff('regeneration', 3, true)
