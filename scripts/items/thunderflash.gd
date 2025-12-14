extends Item

var flash_distance = 5

func _init():
	description = "<Thunderflash>: Portable distraction device which stuns targets in close proximity to the user;"

func use() -> bool:
	var targets = get_flash_targets()
	
	if targets.size() <= 0:
		return false
		
	for target in targets:
		target.add_buff('stun', 4, true)
		
		if target is Enemy2D:
			target.set_active(false)
	
	remove_item()
	_owner.end_turn()
	return true

func get_flash_targets() -> Array:
	var shadowcast = BaseShadowcaster.new(funcref(self.level, 'is_tile_blocking'))
	var reachable_cells = shadowcast.cast(_owner.position / grid_size, flash_distance)
	var entities:Array = get_tree().get_nodes_in_group("ENTITY")
	var targets:Array = []
	
	for entity in entities:
		if (entity.position / grid_size in reachable_cells) and entity != _owner:
			targets.append(entity)
	return targets
