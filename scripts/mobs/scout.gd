extends Enemy2D

var buff_recharge:int = 8
var buff_trigger_count:int = 8

func _ready():
	behaviours = [
		FleeBehaviour.new(self, {
			"health_threshold": 0,
			"flee_when_close": true,
			"skip_chance": 25,
		}),
		RangedBehaviour.new(self, {}),
		MeleeBehaviour.new(self, {}),
		MoveBehaviour.new(self, {}),
		OpenDoorBehaviour.new(self, {}),
		WanderBehaviour.new(self, {}),
	]
	blood = Blood.COLOUR.GREY
	attack_range = 2
	health = 4
	ranged_damage = 2
	melee_damage = 1
	visibility = 5

func _turn_started_hook():
	buff_recharge += 1
	
	if buff_recharge >= buff_trigger_count \
		and is_active() \
		and path.size() > 0 \
		and path.size() <= 4 \
		:
		add_buff('shield', 5, true)
		buff_recharge = 0
