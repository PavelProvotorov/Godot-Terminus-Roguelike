extends Enemy2D

func _ready():
	behaviours = [
		BEHAVIOUR_TYPE.RANGED,
		BEHAVIOUR_TYPE.MELEE,
		BEHAVIOUR_TYPE.MOVE,
	]
	health = 4
	attack_range = 2
	melee_damage = 2
	ranged_damage = 1

func _post_ranged_attack_hook() -> void:
	var self_pos = self.position
	var target_pos = target.position
	
	target.position = self.position
	self.position = target_pos
	
	target.update_fog()
	update_pathfinding(self_pos / grid_size, target_pos / grid_size)

func _post_melee_attack_hook() -> void:
	var cells:Array = self.level.get_free_cells()
	target.position = cells.pick_random() * 8
	target.update_fog()
