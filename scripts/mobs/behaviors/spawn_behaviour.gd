extends BaseBehaviour
class_name SpawnBehaviour

var minion_reservoir

func _init(entity:EntityAI, config:Dictionary).(entity, config):
	self.minion_reservoir = _config.get("minion_reservoir", null)

func check() -> bool:
	if not _entity.is_active():
		return false
	
	if minion_reservoir != null and minion_reservoir <= 0:
		return false
		
	if _entity.get_nearby_cells().size() >= 1:
		print("SPAWNER")
		return true
	return false
	
func _handler() -> void:
	var minion = _config.get("minion", null)
	var minion_count = _config.get("minion_count", 0)
	var spawn_chance =  _config.get("spawn_chance", 0)
	var die = _config.get("die", false)
	var animation = _config.get("animation", null)
	var nearby_cells = _entity.get_nearby_cells()
	nearby_cells.shuffle()
	
	if animation:
		_entity._sprite_animations.add_animation(
			animation, 
			_entity.level, 
			true, 
			_entity.position
		)
	
	var total_spawned = 0 
	for cell in nearby_cells:
		var instance = minion.instance()
		
		if total_spawned < minion_count and _utility.get_chance(spawn_chance):
			total_spawned += 1
			
			if minion_reservoir != null:
				self.minion_reservoir -= 1
		else:
			break
		
		yield(_entity.minion_spawn_and_move(
			instance,
			_entity.position,
			cell * GRID_SIZE
			), 
		"completed"
		)
	
	if die:
		_entity.handle_death()

#abomination
#func handle_spawning(config:Dictionary) -> void:
#	var nearby_cells = get_nearby_cells()
#
#	if nearby_cells.size() != 0 \
#		and get_chance(25) \
#		and spawn_count < max_spawn_count \
#		:
#		spawn_count += 1
#		var cell = nearby_cells.pick_random()
#		var instance = Resources.debug_vermin.instance()
#		yield(minion_spawn_and_move(
#			instance,
#			position,
#			cell * grid_size
#			), 
#		"completed"
#		)
#	end_turn()

#colony
#func handle_spawning(config:Dictionary) -> void:
#	var nearby_cells = get_nearby_cells()
#
#	if nearby_cells.size() != 0:
#		_sprite_animations.add_animation('burst', self.level, true, self.position)
#		for cell in nearby_cells:
#			var instance = Resources.debug_maggot.instance()
#			yield(minion_spawn_and_move(
#				instance,
#				position,
#				cell * grid_size
#				), 
#			"completed"
#			)
#		handle_death()
#	end_turn()
