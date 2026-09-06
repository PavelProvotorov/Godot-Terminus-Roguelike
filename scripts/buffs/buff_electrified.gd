extends Buff

func _ready():
	icon = Resources.icon_electrified
	original_name = 'electrified'

func _on_buff_tick_hook() -> void:

	var nearby_cells = []
	var radius := 2
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			if x == 0 and y == 0:
				continue
			
			var cell = target.position + Vector2(x, y) * grid_size
			nearby_cells.append(cell)
		
	var entities:Array = target.get_reachable_targets(nearby_cells, target.position)
	for entity in entities:
		if _utility.get_chance(40):
			_sprite_animations.add_animation('spark', self.level, true, entity.position)
			entity.receive_damage(1)
