extends Enemy2D

func _ready():
	behaviours = [
		AmbushBehaviour.new(self, {
			"close_in": true,
			"pre_hook": funcref(self, "radiate")
		}),
		MeleeBehaviour.new(self, {
			"pre_hook": funcref(self, "radiate")
		}),
		MoveBehaviour.new(self, {}),
		WanderBehaviour.new(self, {}),
	]
	attack_range = 1
	health = 5
	ranged_damage = 0
	melee_damage = 1
	visibility = 5

func radiate():
	if not _utility.get_chance(30):
		return
		
	var nearby_cells = [
		self.position,
		Vector2(self.position.x, self.position.y - 8),
		Vector2(self.position.x, self.position.y+8),
		Vector2(self.position.x-8, self.position.y),
		Vector2(self.position.x+8, self.position.y),
		Vector2(self.position.x+8, self.position.y+8),
		Vector2(self.position.x+8, self.position.y-8),
		Vector2(self.position.x-8, self.position.y+8),
		Vector2(self.position.x-8, self.position.y-8),
	]
		
	var targets = get_reachable_targets(nearby_cells, self.position)
	
	for target in target:
		if is_entity_hostile(target):
			target.add_buff('stun', 1)
	
	for cell in nearby_cells:
		if not self.level.is_tile_blocking(cell / grid_size):
			_sprite_animations.add_animation('spark', self.level, true, cell)
	
#	Without a delay the stun buff animation is not visible on the player
#	Adding a small delay fixes that and allows the player to evaluate the stuation before enemies action
	var timer = get_tree().create_timer(0.5)
	yield(timer, "timeout")
