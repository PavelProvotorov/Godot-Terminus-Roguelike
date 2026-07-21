extends Enemy2D

func _ready():
	behaviours = [
		RangedBehaviour.new(self, {
			"post_hook": funcref(self, "post_ranged"),
		}),
		MeleeBehaviour.new(self, {
			"post_hook": funcref(self, "post_melee"),
		}),
		MoveBehaviour.new(self, {
			"post_hook": funcref(self, "post_move"),
		}),
		WanderBehaviour.new(self, {}),
	]
	attack_range = 2
	ranged_damage = 2
	melee_damage = 1
	health = 4
	speed = 1

func post_ranged() -> void:
	if not get_chance(75):
		return
	
	if target.add_buff('blindness', 3):
		spawn_creep() 

func post_melee() -> void:
	if not get_chance(75):
		return
	spawn_creep()
	
func post_move() -> void:
	if not get_chance(25):
		return
	spawn_creep()

func spawn_creep() -> void:
	var hidden_cells = get_hidden_free_cells()
	
	if hidden_cells.size() != 0:
		var instance = Resources.debug_creep.instance()
		var spawn_cell = hidden_cells.pick_random()
		self.level.spawn_enemy(spawn_cell, instance)
		instance.set_active(true)
