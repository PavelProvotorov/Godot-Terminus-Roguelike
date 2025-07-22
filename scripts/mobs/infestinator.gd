extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.RANGED,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
	]
	attack_range = 2
	ranged_damage = 2
	melee_damage = 1
	health = 4
	speed = 1

func _post_ranged_attack_hook() -> void:
	if not get_chance(25):
		return
		
	target.add_buff('blindness')
	target.update_fog()
	spawn_creep() 

func _post_melee_attack_hook() -> void:
	if not get_chance(25):
		return
	spawn_creep()

func spawn_creep() -> void:
	var hidden_cells = get_hidden_free_cells()
	
	if hidden_cells.size() != 0:
		var instance = Resources.debug_creep.instance()
		var spawn_cell = hidden_cells.pick_random()
		_level.spawn_enemy(spawn_cell, instance)
		instance.set_active()
