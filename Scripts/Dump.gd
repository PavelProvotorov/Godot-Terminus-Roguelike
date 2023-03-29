#func manager_mob_AI():
#	print("---------------------------------------------------------")
#	print("THE QUEUE SIZE IS: %s" %level_queue.size())
#	for i in (level_queue.size()):
#		print(i)
#		yield(get_tree().create_timer(0.6),"timeout")
#		moving_entity = Global.LEVEL_LAYER_LOGIC.get_node(level_queue[i][1])
#		print("Currently Moving: %s" %moving_entity.name)
#		if moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_NONE:
#			pass
#		elif moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_MELEE:
#			manager_mob_actions()
#			yield(self,"on_manager_mob_actions_finished")
#			pass
#		elif moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_RANGED:
#			pass
#		else:
#			pass
#	print("< MANAGER MOB AI FINISHED, CHANGE TO PLAYER >")
#	Global.game_state_manager(Global.GAME_STATE_LIST.STATE_PLAYER_TURN)
#	pass
#
#func manager_mob_actions():
#	if moving_entity.AIState == AI_STATE_LIST[0]:
#		pass
#	elif moving_entity.AIState == AI_STATE_LIST[1]:
#		pass
#	elif moving_entity.AIState == AI_STATE_LIST[2]:
#		for i in moving_entity.stat_speed:
#			moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
#			moving_entity_position = Vector2(moving_entity_position.x+1,moving_entity_position.y)
#			mob_action_move(moving_entity_position,target_entity_position)
#			yield(self,"on_mob_action_finished")
#			pass
#		pass
#	elif moving_entity.AIState == AI_STATE_LIST[3]:
#		pass
#	else:
#		pass
#	print("< MANAGER MOB ACTIONS FINISHED >")
#	emit_signal("on_manager_mob_actions_finished")
#
#func mob_action_move(cellA:Vector2,cellB:Vector2):
#	cellA = Vector2((cellA.x)*tile_size,(cellA.y)*tile_size)
#	cellB = Vector2((cellB.x)*tile_size,(cellB.y)*tile_size)
#	moving_entity.action_move_tween(cellA,cellB)
#	yield(moving_entity.get_node("Tween"),"tween_all_completed")
#	emit_signal("on_mob_action_finished")
#
#func mob_action_attack(cellA:Vector2,cellB:Vector2):
#	cellA = Vector2((cellA.x)*tile_size,(cellA.y)*tile_size)
#	cellB = Vector2((cellB.x)*tile_size,(cellB.y)*tile_size)
#	moving_entity.action_attack_tween(cellA,cellB)
#	yield(moving_entity.get_node("Tween"),"tween_all_completed")
#	emit_signal("on_mob_action_finished")

#func _mob_claim():
#	var nearbyCells = moveDirection
#	var nearbyCellsID = 0
#	for i in movingMob.statSpeed:
#		print("TURN NO: %s" %i)
#		nearbyCells.shuffle()
#		movingMobPosition = activeLogicLayer.world_to_map(movingMob.get_global_position())
#		targetMobPosition = Vector2((nearbyCells[nearbyCellsID].x),(nearbyCells[nearbyCellsID].y))
#		targetMobPosition = Vector2((movingMobPosition.x)+(targetMobPosition.x),(movingMobPosition.y)+(targetMobPosition.y))
#		_astar_clear()
#		_astar_get_cells(0)
#		_astar_remove_mob_cells()
#		if tilemapFreeCells.has(targetNodePos) == true:
#			yield(_mob_move(movingNodePos,targetNodePos),"completed")
#			print("MOVE COMPLETE IN CLAIM FUNCTION")
#		elif tilemapFreeCells.has(targetNodePos) == false:
#			for cell in (nearbyCells.size()):
#				targetNodePos = Vector2((nearbyCells[cell].x),(nearbyCells[cell].y))
#				targetNodePos = Vector2((movingNodePos.x)+(targetNodePos.x),(movingNodePos.y)+(targetNodePos.y))
#				print("GOT CELL: %s" %targetNodePos)
#				if tilemapFreeCells.has(targetNodePos) == true:
#					print("CELL IS VALID")
#					yield(_mob_move(movingNodePos,targetNodePos),"completed")
#					print("MOVE COMPLETE IN CLAIM FUNCTION")
#					break
#				elif tilemapFreeCells.has(targetNodePos) == false:
#					print("CELL NOT VALID")
#					pass
#				else:
#					pass
#		else:
#			pass
#	print("< MOB CLAIM FINISHED >")
#	emit_signal("on_mob_action_finished")
#-----------------------------#

#-----------------------------# Loading JSON language files 

#-----------------------------#

#	Global.playerNode = get_node("/root/Main/Logic/%s" %Global.playerNodeWho)
#	Global.playerNodeRayCast = get_node("/root/Main/Logic/%s/RayCast2D" %Global.playerNodeWho)
#	Global.playerNodeTween = get_node("/root/Main/Logic/%s/Tween" %Global.playerNodeWho)
#	Global.playerNode.remove_from_group("Bot")


#	OS.set_window_size(Global.settingWindowSize)
#	OS.set_window_fullscreen(Global.settingWindowFull)
#	print(activeLevelScene.z_index)
#	_load_json(Global.settingLanguage,"rus_strings")
#	gotTextFromJSON = _load_json("rooms","normal_rooms")
#	print("gotTextFromJSON is:")
#	print(gotTextFromJSON)
#	print("got key:")
#	print(gotTextFromJSON.get("room_bottom_center"))


#	Global.NODE_LEVEL = level_current
#	level_layer_logic = level_instance.get_node("Logic")
#	Global.NODE_LEVEL_LAYER_LOGIC = level_layer_logic
#	level_layer_base = level_instance.get_node("Base")
#	Global.NODE_LEVEL_LAYER_BASE = level_layer_base
#	level_layer_wall = level_instance.get_node("Wall")
#	Global.NODE_LEVEL_LAYER_WALL = level_layer_wall
#	level_layer_deco = level_instance.get_node("Deco")
#	Global.NODE_LEVEL_LAYER_DECO = level_layer_deco
	
#	Global.NODE_LEVEL = level_current
#	level_layer_logic = level_instance.get_node("Logic")
#	Global.NODE_LEVEL_LAYER_LOGIC = level_layer_logic
#	level_layer_base = level_instance.get_node("Base")
#	Global.NODE_LEVEL_LAYER_BASE = level_layer_base
#	level_layer_wall = level_instance.get_node("Wall")
#	Global.NODE_LEVEL_LAYER_WALL = level_layer_wall
#	level_layer_deco = level_instance.get_node("Deco")
#	Global.NODE_LEVEL_LAYER_DECO = level_layer_deco
	
#	level_cell_array = level_layer_logic.get_used_cells()
#	level_cell_start = Vector2(level_cell_array.front().x,level_cell_array.front().y)
#	level_cell_finish = Vector2(level_cell_array.back().x-1,level_cell_array.back().y-1)
#	level_border = Rect2(level_cell_start,level_cell_finish)
#	level_cell_array.clear()

#func tilemap_set_wall(atlas_id:int,cell_id:int):
#	randomize()
#	var cell_array = self.get_used_cells_by_id(cell_id)
#	var tile_array = util_atlas_get_tiles(atlas_id,Global.LEVEL_LAYER_WALL)
#	for cell in cell_array:
#		if tilemap_check_bottom_cell(cell.x,cell.y) == true:
#			var tile = tile_array[randi() % tile_array.size()]
#			Global.LEVEL_LAYER_WALL.set_cell(cell.x,cell.y+1,atlas_id,false,false,false,tile)
#		else:
#			pass
#	pass
#
#func tilemap_check_bottom_cell(x,y):
#	if Global.LEVEL_LAYER_LOGIC.get_cell(x, y+1) == TILES.LOGIC_WALL:
#		return false
#	elif Global.LEVEL_LAYER_LOGIC.get_cell(x, y+1) == TILES.LOGIC_VOID:
#		return false
#	else:
#		return true

#func tilemap_set_wall(atlas_id:int,cell_id:int):
#	randomize()
#	var cell_array = self.get_used_cells_by_id(cell_id)
#	var tile_array = util_atlas_get_tiles(atlas_id,Global.LEVEL_LAYER_WALL)
#	for cell in cell_array:
#		var cell_data = tilemap_check_bottom_cell(cell.x,cell.y)
#		var cell_solid
#		var cell_solid_left
#		var cell_solid_right
#		if count == 0 && solid == false:
#			var tile = tile_array[randi() % tile_array.size()]
#			Global.LEVEL_LAYER_WALL.set_cell(cell.x,cell.y+1,atlas_id,false,false,false,tile)
#		elif count == 1 && solid == false:
#			pass
#		elif count == 2 && solid == false:
#			pass
#		else:
#			pass
#	pass

#func bsp_generator_clear_doors():
#	var doors_array = []
#	var cells_array = []
#
#	doors_array = get_used_cells_by_id(TILES.LOGIC_DOOR)
#	for door in doors_array:
#		cells_array = []
#		if get_cell(door.x, door.y-1)   == TILES.LOGIC_FLOOR:  cells_array.append(Vector2(door.x, door.y-1))
#		if get_cell(door.x, door.y+1)   == TILES.LOGIC_FLOOR:  cells_array.append(Vector2(door.x, door.y+1))
#		if get_cell(door.x-1, door.y)   == TILES.LOGIC_FLOOR:  cells_array.append(Vector2(door.x-1, door.y))
#		if get_cell(door.x+1, door.y)   == TILES.LOGIC_FLOOR:  cells_array.append(Vector2(door.x+1, door.y))
#		print(cells_array)
#		for i in cells_array.size():
#			var cell = cells_array[i]
#			var room = rooms_array[i]
#			if room.has(Vector2(cell.x, cell.y)): pass
#			pass
#		pass
#	pass

#func fog_check(entity,x,y):
#	entity.NODE_RAYCAST.cast_to = Vector2(x,y)
#	entity.NODE_RAYCAST.force_raycast_update()
#	var collider = entity.NODE_RAYCAST.get_collider()
#
#	if entity.NODE_RAYCAST.is_colliding() == false:
#		print("FALSE")
#		print(collider)
#	elif entity.NODE_RAYCAST.is_colliding() == true:
#		print("TRUE")
#		print(collider.name)
#		pass
#	else:
#		pass
#	pass

#func fog_check(start:Vector2,cells:Array):
#	var cell_neighbors = [Vector2(0,-1),Vector2(0,1),Vector2(-1,0),Vector2(1,0),Vector2(-1,-1),Vector2(1,-1),Vector2(1,1),Vector2(-1,1)]
#	var cells_to_check:Array = [start]
#	var cells_to_fill:Array = [start]
#	var cells_in_range:Array = cells
#	var cells_checked:Array = []
#
#	while cells_to_check.empty() == false:
#		var cell_current = cells_to_check.pop_back()
#		cells_checked.append(cell_current)
#		for n in cell_neighbors:
#			var cell_next = cell_current + n
#			if cells_checked.has(cell_next) == true: continue
#			if cells_checked.has(cell_next) == false:
#				if cells_in_range.has(cell_next) == false: continue
#				if cells_in_range.has(cell_next) == true:
#					if self.get_cell(cell_current.x,cell_current.y) == TILESET_LOGIC.TILE_FLOOR:
#						cells_to_check.append(cell_next)
#						if self.get_cell(cell_next.x,cell_next.y) == TILESET_LOGIC.TILE_FLOOR: cells_to_fill.append(cell_next)
#						if self.get_cell(cell_next.x,cell_next.y) == TILESET_LOGIC.TILE_WALL: cells_to_fill.append(cell_next)
#						if self.get_cell(cell_next.x,cell_next.y) == TILESET_LOGIC.TILE_DOOR: cells_to_fill.append(cell_next)
						
#					if self.get_cell(cell_current.x,cell_current.y) == TILESET_LOGIC.TILE_WALL:
#						cells_to_check.append(cell_next)
#						if self.get_cell(cell_next.x,cell_next.y) == TILESET_LOGIC.TILE_FLOOR: continue
#						if self.get_cell(cell_next.x,cell_next.y) == TILESET_LOGIC.TILE_WALL: continue
#						if self.get_cell(cell_next.x,cell_next.y) == TILESET_LOGIC.TILE_DOOR: continue
						
#					if self.get_cell(cell_current.x,cell_current.y) == TILESET_LOGIC.TILE_DOOR:
#						if self.get_cell(cell_next.x,cell_next.y) == TILESET_LOGIC.TILE_FLOOR: continue
#						if self.get_cell(cell_next.x,cell_next.y) == TILESET_LOGIC.TILE_WALL: continue
#						if self.get_cell(cell_next.x,cell_next.y) == TILESET_LOGIC.TILE_DOOR: continue
					
					#TEST ZONE
#					if self.get_cell(cell_next.x,cell_next.y) == TILESET_LOGIC.TILE_WALL:
#						var test1 = Vector2(cell_next.x+n.x, cell_next.y+n.y)
#						cells_checked.append(test1)
#						print(cell_current)
#						print(cell_next)
#						if self.get_cell(cell_next.x,cell_next.y) == TILESET_LOGIC.TILE_FLOOR: continue
#						if self.get_cell(cell_next.x,cell_next.y) == TILESET_LOGIC.TILE_WALL: continue
#						if self.get_cell(cell_next.x,cell_next.y) == TILESET_LOGIC.TILE_DOOR: continue
	
#	print("--------------------------- CELLS CHECKED")
#	print(cells_checked)
#	print("--------------------------- CELLS TO FILL")
#	print(cells_to_fill)
#	print("---------------------------")
	
#	return cells_to_fill

#func fog_check(point:Vector2,array:Array):
#	var cell = point
#	var cells_to_check = array
#	var cells_to_fill = []
#
#	var check = true
#
#	while check == true:
#		var tile = cells_to_check.pop_back()
#		if !room.has(tile):
#			room.append(tile)
#			self.set_cellv(tile, TILESET_LOGIC.TILE_EMPTY)
#
#			#CHECK ADJACENT CELLS
#			var a1 = Vector2(x, y-1)
#			var a2 = Vector2(x, y+1)
#			var a3 = Vector2(x-1, y)
#			var a4 = Vector2(x+1, y)
#			var a5 = Vector2(x+1, y+1)
#			var a6 = Vector2(x+1, y-1)
#			var a7 = Vector2(x-1, y+1)
#			var a8 = Vector2(x-1, y-1)
#
#			for dir in [north,south,east,west]:
#				if self.get_cellv(dir) == TILESET_LOGIC.TILE_FLOOR:
#					if !to_fill.has(dir) and !room.has(dir):
#						to_fill.append(dir)
#	rooms_array.append(room)
#	pass
	
#		#CHECK ADJACENT CELLS
#		if self.get_cell(x, y-1)   == TILESET_LOGIC.TILE_WALL:  count += 1
#		if self.get_cell(x, y+1)   == TILESET_LOGIC.TILE_WALL:  count += 1
#		if self.get_cell(x-1, y)   == TILESET_LOGIC.TILE_WALL:  count += 1
#		if self.get_cell(x+1, y)   == TILESET_LOGIC.TILE_WALL:  count += 1
#		if self.get_cell(x+1, y+1) == TILESET_LOGIC.TILE_WALL:  count += 1
#		if self.get_cell(x+1, y-1) == TILESET_LOGIC.TILE_WALL:  count += 1
#		if self.get_cell(x-1, y+1) == TILESET_LOGIC.TILE_WALL:  count += 1
#		if self.get_cell(x-1, y-1) == TILESET_LOGIC.TILE_WALL:  count += 1

#	cell_array = fog_check_cells(player_position,cell_array)
#	for cell in cell_array:
#		Global.LAYER_FOG.set_cell(cell.x, cell.y, TILESET_FOG.TILE_NONE)
#		pass

#func fog_check_cells(player_position:Vector2,cell_array:Array):
#	if player.NODE_RAYCAST.is_colliding():
#		var hit_collider = player.NODE_RAYCAST.get_collider()
#		tilemap = hit_collider
#		hit_pos = player.NODE_RAYCAST.get_collision_point()
#		tile_pos = tilemap.world_to_map(hit_pos)
#		print("------------------------")
#		print(tile_to_pixel_center(tile_pos.x,tile_pos.y))
#	pass

#func update_visuals():
#	fog_fill()
#	var player = Global.LEVEL_LAYER_LOGIC.get_node("Player")
#	var player_position = Global.LEVEL_LAYER_LOGIC.world_to_map(player.get_global_position())
#	var player_center = tile_to_pixel_center(player_position.x, player_position.y)
#	var space_state = get_world_2d().direct_space_state
#	for x in range(map_width):
#		for y in range(map_height):
#			player.NODE_RAYCAST.force_raycast_update()
#			if Global.LEVEL_LAYER_LOGIC.get_cell(x, y) == TILESET_LOGIC.TILE_FLOOR:
#				var x_dir = 1 if x < player_position.x else -1
#				var y_dir = 1 if y < player_position.y else -1
#				var test_point = tile_to_pixel_center(x, y) + Vector2(x_dir, y_dir) * tile_size / 2
#
#				var occlusion = space_state.intersect_ray(player_center, test_point)
#				if !occlusion || (occlusion.position - test_point).length() < 1:
#					Global.LAYER_FOG.set_cell(x, y, TILESET_FOG.TILE_NONE)

#func action_move_old(direction):
#	var cellA = NODE_MAIN.position
#	var cellB = NODE_MAIN.position + (direction * grid_size)
#	NODE_RAYCAST_COLLIDE.cast_to = (direction * grid_size)
#	NODE_RAYCAST_COLLIDE.force_raycast_update()
#
#	if NODE_RAYCAST_COLLIDE.is_colliding() == false:
#		if cellA - cellB == Vector2(-grid_size,0): animation_flip(false,false)
#		if cellA - cellB == Vector2(grid_size,0): animation_flip(true,false)
#		NODE_MAIN.action_move_tween(cellA,cellB)
#		$Sound.play()
#		yield(NODE_TWEEN,"tween_all_completed")
#		Global.LEVEL_LAYER_LOGIC.fog_update()
#		check_turn()
#
#	if NODE_RAYCAST_COLLIDE.is_colliding() == true:
#		var collider = NODE_RAYCAST_COLLIDE.get_collider()
#		print(collider)
#		if NODE_RAYCAST_COLLIDE.get_collider() == Global.LEVEL_LAYER_LOGIC:
#			var collider_cell = Vector2(cellB.x/8,cellB.y/8)
#			var collider_cell_id = Global.LEVEL_LAYER_LOGIC.get_cell(collider_cell.x,collider_cell.y)
#			if collider_cell_id == Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_WALL: pass
#			if collider_cell_id == Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_VOID: pass
#			if collider_cell_id == Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_DOOR:
#				Global.LEVEL_LAYER_LOGIC.set_cell(collider_cell.x,collider_cell.y,Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_FLOOR)
#				Global.LEVEL_LAYER_LOGIC.tilemap_texture_set_fixed(Global.LEVEL_LAYER_LOGIC.TILESET_BASE.TILE_DOOR_OPEN,collider_cell,0)
#				NODE_MAIN.action_move_tween(cellA,cellB)
#				$Sound.play()
#				yield(NODE_TWEEN,"tween_all_completed")
#				Global.LEVEL_LAYER_LOGIC.fog_update()
#				check_turn()
#		elif NODE_RAYCAST_COLLIDE.get_collider().is_in_group(Global.GROUPS.HOSTILE) == true:
#			if cellA - cellB == Vector2(-grid_size,0): animation_flip(false,false)
#			if cellA - cellB == Vector2(grid_size,0): animation_flip(true,false)
#			NODE_MAIN.z_index += 1
##			NODE_MAIN.animation_change(ANIMATIONS.MELEE_ATTACK,true,false)
#			NODE_MAIN.calculate_melee_damage(self,collider)
#			NODE_MAIN.action_attack_tween(cellA,cellB)
#			yield(NODE_TWEEN,"tween_all_completed")
##			NODE_MAIN.animation_change(ANIMATIONS.MELEE_IDLE,true,false)
#			NODE_MAIN.z_index -= 1
#			check_turn()
#		elif NODE_RAYCAST_COLLIDE.get_collider().is_in_group(Global.GROUPS.HOSTILE) == false: pass
#		else: 
#			pass
#	else:
#		return

#func util_create_tunnel(point1, point2, cave, tile_empty, tile_filled):
#	randomize()
#	var max_steps = 500
#	var steps = 0
#	var drunk_x = point2[0]
#	var drunk_y = point2[1]
#
#	while steps < max_steps and !cave.has(Vector2(drunk_x, drunk_y)):
#		steps += 1
#
#		# set initial dir weights
#		var n       = 1.0
#		var s       = 1.0
#		var e       = 1.0
#		var w       = 1.0
#		var weight  = 1
#
#		# weight the random walk against edges
#		if drunk_x < point1.x: # drunkard is left of point1
#			e += weight
#		elif drunk_x > point1.x: # drunkard is right of point1
#			w += weight
#		if drunk_y < point1.y: # drunkard is above point1
#			s += weight
#		elif drunk_y > point1.y: # drunkard is below point1
#			n += weight
#
#		# normalize probabilities so they form a range from 0 to 1
#		var total = n + s + e + w
#		n /= total
#		s /= total
#		e /= total
#		w /= total
#
#		var dx
#		var dy
#
#		# choose the direction
#		var choice = randf()
#
#		if 0 <= choice and choice < n:
#			dx = 0
#			dy = -1
#		elif n <= choice and choice < (n+s):
#			dx = 0
#			dy = 1
#		elif (n+s) <= choice and choice < (n+s+e):
#			dx = 1
#			dy = 0
#		else:
#			dx = -1
#			dy = 0
#
#		# ensure not to walk past edge of map
#		if (2 < drunk_x + dx and drunk_x + dx < map_width-2) and \
#			(2 < drunk_y + dy and drunk_y + dy < map_height-2):
#			drunk_x += dx
#			drunk_y += dy
#			if self.get_cell(drunk_x, drunk_y) == tile_filled:
#				self.set_cell(drunk_x, drunk_y, tile_empty)
#
#				# optional: make tunnel wider
#				self.set_cell(drunk_x+1, drunk_y, tile_empty)
#				self.set_cell(drunk_x+1, drunk_y+1, tile_empty)

#func tilemap_check_bottom_cell(x,y):
#	var cell_data = []
#	if get_cell(x, y)   == TILESET_LOGIC.TILE_WALL :  cell_data.append(true)
#	if get_cell(x, y)   == TILESET_LOGIC.TILE_VOID :  cell_data.append(true)
#	if get_cell(x-1, y) == TILESET_LOGIC.TILE_WALL :  cell_data.append(true)
#	if get_cell(x-1, y) == TILESET_LOGIC.TILE_VOID :  cell_data.append(true)
#	if get_cell(x+1, y) == TILESET_LOGIC.TILE_WALL :  cell_data.append(true)
#	if get_cell(x+1, y) == TILESET_LOGIC.TILE_VOID :  cell_data.append(true)
#	return cell_data

#	level_entrance = Global.LEVEL_LAYER_LOGIC.get_used_cells_by_id(Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_ENTRANCE)
#	level_mob_spawn("Grunt",level_entrance[0]+Vector2.UP)
#	level_item_spawn("Ammo",level_entrance[0]+Vector2.UP)
#	level_item_spawn("Ammo",level_entrance[0])
#	level_mob_spawn("Player",level_entrance[0])
#	level_mob_spawn("Player",Vector2(14,5))
#	level_mob_spawn("Grunt",Vector2(13,9))
#	level_mob_spawn("Grunt",Vector2(6,3))
#	level_mob_spawn("Grunt",Vector2(7,5))
#	level_mob_spawn("Grunt",Vector2(10,9))

#var hit_pos
#var vis_color = Color(.867, .91, .247, 0.1)

#func bsp_generator_add_middle_rooms(amount:int):
#	randomize()
#
#	var room:Array = rooms_array[rand_range(0,rooms_array.size())]
#	var cells_to_fill:Array = []
#	var count:int
#
#	for cell in room:
#		count = 0
#		count += util_check_nearby_tile_8(cell.x, cell.y, TILESET_LOGIC.TILE_WALL)
#		count += util_check_nearby_tile_8(cell.x, cell.y, TILESET_LOGIC.TILE_DOOR)
#		if count == 0: 
#			cells_to_fill.append(cell)
#	for i in cells_to_fill: 
#		set_cellv(i, TILESET_LOGIC.TILE_WALL)
#	pass

#func astar_remove_mob_cells():
#	tilemap_scan_node = Global.LEVEL_LAYER_LOGIC
#	for i in tilemap_scan_node.get_child_count():
#		var mobCell = tilemap_scan_node.get_child(i)
#		mobCell = (world_to_map(mobCell.get_global_position()))
#		tilemap_astar_cells.remove(tilemap_astar_cells.find(Vector2(mobCell.x,mobCell.y)))

#						moving_entity.connect("on_action_move_finished",self,"manager_mob_actions")
#						yield(moving_entity.on_action_move(),"on_action_move_finished")
#						moving_entity.connect("on_action_move_finished",Global.NODE_MAIN,"manager_mob_actions")

#	Global.NODE_MAIN.connect("on_action_move_finished",self,"on_action_move")

#func bsp_generator_add_coridors(amount:int):
#	randomize()
#
#	var cells_to_check = self.get_used_cells_by_id(TILESET_LOGIC.TILE_WALL)
#	var start_walls_array = []
#	var free_walls_array = []
#	var coridors_array = []
#	var count
#
#	for cell in cells_to_check:
#		count = 0
#		count += util_check_nearby_tile_4(cell.x, cell.y, TILESET_LOGIC.TILE_WALL)
##		count += util_check_nearby_tile_4(cell.x, cell.y, TILESET_LOGIC.TILE_VOID)
#		if count == 4: 
#			free_walls_array.append(cell)
#
#	for cell in cells_to_check:
#		count = 0
#		count += util_check_nearby_tile_4(cell.x, cell.y, TILESET_LOGIC.TILE_FLOOR)
#		if count == 1:
#			start_walls_array.append(cell)
#			pass
#
#	for cell in free_walls_array:
#		self.set_cell(cell.x,cell.y,TILESET_LOGIC.TILE_EMPTY)
#		pass
#	for cell in start_walls_array:
#		self.set_cell(cell.x,cell.y,TILESET_LOGIC.TILE_EMPTY)
#		pass
#
#	for a in amount:
#		start_walls_array.shuffle()
#		var wall_a = start_walls_array[randi() % start_walls_array.size()]
#		start_walls_array.erase(wall_a)
#		var wall_b = start_walls_array[randi() % start_walls_array.size()]
#		start_walls_array.erase(wall_b)
#
#		astar_clear()
#		astar_get_cells(TILESET_LOGIC.TILE_EMPTY)
#		astar_add_points()
#		astar_connect_points()
#
#		var coridor_path = astar_get_path(wall_a,wall_b)
#		if coridor_path.size() > 2:
#			coridors_array.append(coridor_path)
#		if coridor_path.size() <= 2:
#			pass
#
#	print(coridors_array)
#	for c in coridors_array.size():
#		var coridor = coridors_array[c]
#		print(coridor)
#		for cell in coridor:
#			self.set_cell(cell.x,cell.y,TILESET_LOGIC.TILE_VOID)
#		pass
#
#	cells_to_check = self.get_used_cells_by_id(TILESET_LOGIC.TILE_EMPTY)
#	for cell in cells_to_check:
#		self.set_cell(cell.x,cell.y,TILESET_LOGIC.TILE_WALL)
#		pass

#	Global.NODE_MAIN.connect("on_action_move_finished",self,"on_action_move")

#func play_sound_death(entity,sound_name):
#	entity.NODE_SOUND_DEATH.stream = sound_name
#	entity.NODE_SOUND_DEATH.play()
#	pass

#	var object_cells = []
#	for room in rooms_array:
#		for cell in room:
#			var count = 0
#			count += util_check_nearby_tile_8(cell.x, cell.y, TILESET_LOGIC.TILE_BLOCK)
#			count += util_check_nearby_tile_8(cell.x, cell.y, TILESET_LOGIC.TILE_VOID)
#			count += util_check_nearby_tile_8(cell.x, cell.y, TILESET_LOGIC.TILE_DOOR)
#			if count < 5 && count > 1: 
#				rooms_array.erase(cell)
#				object_cells.append(cell)
#			if count != 0:
#				pass
#		pass

	#CHECK WALL FOR OBJECTS
#	cell_array = []
#	cells_to_fill = []
#	cell_array.append_array(self.get_used_cells_by_id(TILESET_LOGIC.TILE_OBJECT))
#	for cell in cell_array:
#		var cell_to_check = self.get_cellv(cell+Vector2.DOWN)
#		if cell_to_check == TILESET_LOGIC.TILE_FLOOR:
#			cells_to_fill.append(cell+Vector2.DOWN)
#			pass
#		pass
#	for cell in cells_to_fill:
#		var tile = tile_array[round(rand_range(7,9))]
#		print(tile)
#		Global.LEVEL_LAYER_WALL.set_cell(cell.x,cell.y,tile_base_id,false,false,false,tile)
#		pass
#	pass

#	var player_position_center = tile_to_pixel_center(player_position.x, player_position.y)
#func tile_to_pixel_center(x,y):
#	return Vector2((x+0.5)*grid_size,(y+0.5)*grid_size)

#func _load_json(resourceFolder:String,resourceType:String):
#	var jsonText
#	var jsonParse
#	var jsonFile = File.new()
#	var jsonFileFolder = resourceFolder
#	var jsonFileType = resourceType
#	var jsonPathTemp = "res://Resources/%s/%s.json"
#	var jsonPath = jsonPathTemp %[jsonFileFolder,jsonFileType]
#	print(jsonPath)
#
#	jsonFile.open(jsonPath, jsonFile.READ)
#	jsonText = jsonFile.get_as_text()
#	jsonParse = JSON.parse(jsonText)
#	if jsonParse.error == OK:
#		jsonText = jsonParse.result
#	elif jsonParse.error != OK:
#		push_error("Error: _load_json")
#		push_error("The error is: %s" %jsonParse.error)
#		push_error("The line is: %s" %jsonParse.error_line)
#		push_error("The string is: %s" %jsonParse.error_string)
#	else:
#		pass
#	return jsonText
#	pass

# -------------------- PLAYER

#func animation_flip(is_flip_h:bool, is_flip_v:bool):
#	NODE_ANIMATED_SPRITE.flip_h = is_flip_h
#	NODE_ANIMATED_SPRITE.flip_v = is_flip_v
#
#func animation_change(animation_type:String,is_playing:bool,is_random:bool):
#	NODE_ANIMATED_SPRITE.set_animation(animation_type)
#	NODE_ANIMATED_SPRITE.playing = is_playing
#	if is_random == true:
#		NODE_ANIMATED_SPRITE.set_frame(rand_range(0,NODE_ANIMATED_SPRITE.get_sprite_frames().get_frame_count(animation_type)))
#	if is_random == false:
#		pass
#
#func action_move_tween(start,finish):
#	NODE_TWEEN.interpolate_property(self,'position',start,finish,1.0/tween_speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
#	NODE_TWEEN.start()
#	yield(NODE_TWEEN,"tween_completed")
#	NODE_TWEEN.emit_signal("tween_all_completed")
#
#func action_attack_tween(start,finish):
#	NODE_TWEEN.interpolate_property(self,"position",start,finish,0.5/tween_speed)
#	NODE_TWEEN.start()
#	yield(NODE_TWEEN,"tween_completed")
#	NODE_TWEEN.interpolate_property(self,"position",finish,start,1.0/tween_speed)
#	NODE_TWEEN.start()
#	yield(NODE_TWEEN,"tween_completed")
#	NODE_TWEEN.emit_signal("tween_all_completed")
#
#func action_shoot_tween(start,finish):
#	if start - finish == Vector2(0,-grid_size): finish = Vector2(finish.x,finish.y-(grid_size/2))
#	if start - finish == Vector2(grid_size,0):  finish = Vector2((grid_size/2)+finish.x,finish.y)
#	if start - finish == Vector2(-grid_size,0): finish = Vector2(finish.x-(grid_size/2),finish.y)
#	if start - finish == Vector2(0,grid_size):  finish = Vector2(finish.x,finish.y+(grid_size/2))
#
#	NODE_TWEEN.interpolate_property(self,"position",start,finish,0.5/tween_speed)
#	NODE_TWEEN.start()
#	yield(NODE_TWEEN,"tween_completed")
#	NODE_TWEEN.interpolate_property(self,"position",finish,start,1.0/tween_speed)
#	NODE_TWEEN.start()
#	yield(NODE_TWEEN,"tween_completed")
#	NODE_TWEEN.emit_signal("tween_all_completed")

#func on_action_pickup():
#	item_pickup_consumable()
#	yield(self.get_idle_frame(),"completed")
#
#func on_action_use():
#	if Data.EQUIPMENT[0].empty() == false:
#		Global.NODE_PLAYER.stat_ammo_bullet += count
#		Sound.play_sound(self,Sound.sfx_pickup)
#
#		# REMOVE FROM INVENTORY
#		item_inventory_remove()
#
#func on_action_tick():
#	pass

#func check_ammo(ammo_type):
#	var ammo = get(ammo_type)
#	if ammo >= 1 && PLAYER_ACTION_SHOOT == false:
#		NODE_ANIMATED_SPRITE.set_animation(ANIMATIONS.RANGED)
#		PLAYER_ACTION_SHOOT = true
#	elif ammo == 0 && PLAYER_ACTION_SHOOT == false:
#		Sound.play_sound(self,Sound.sfx_noammo)



#func action_shoot(direction):
#	PLAYER_ACTION_INPUT = true
#
#	var done = false
#	while done == false:
#		NODE_RAYCAST_COLLIDE.cast_to = (direction*(grid_size*3))
#		NODE_RAYCAST_COLLIDE.force_raycast_update()
#
#		if NODE_RAYCAST_COLLIDE.is_colliding() == false:
#			done = true
#		if NODE_RAYCAST_COLLIDE.is_colliding() == true:
#			var collider = NODE_RAYCAST_COLLIDE.get_collider()
#
#			if collider.get_class() == "KinematicBody2D":
#				if collider.is_in_group(Global.GROUPS.HOSTILE) == true: 
#					var cellA = NODE_MAIN.position
#					var cellB = NODE_MAIN.position + (direction * grid_size)
#
#					#ANIMATION FLIP CHECK
#					if cellA - cellB == Vector2(-grid_size,0): animation_flip(false,false)
#					if cellA - cellB == Vector2(grid_size,0): animation_flip(true,false)
#					Global.LEVEL_LAYER_LOGIC.level_projectile_spawn(Global.GUI_WEAPON.get_child(1).projectile_type,NODE_POSITION_2D,direction,false)
#					action_shoot_tween(cellA,get_negative_vector(cellA,cellB))
#					NODE_MAIN.calculate_ranged_damage(self,collider,Global.GUI_WEAPON.get_child(1).stat_ranged_damage,Global.GUI_WEAPON.get_child(1).ammo_type)
#					Sound.play_sound(self,Global.GUI_WEAPON.get_child(1).sound_on_ranged)
#					yield(self.NODE_TWEEN,"tween_all_completed")
#					yield(self,"on_action_finished")
#					done = true
#			elif collider.get_class() == "StaticBody2D":
#				if collider.is_in_group(Global.GROUPS.ITEM) == true:
#					NODE_RAYCAST_COLLIDE.add_exception(collider)
#			elif collider.get_class() == "TileMap": 
#				done = true
#			else:
#				pass
#	yield(self.get_idle_frame(),"completed")
#	NODE_RAYCAST_COLLIDE.clear_exceptions()
#	PLAYER_ACTION_INPUT = false
#	NODE_ANIMATED_SPRITE.set_animation(ANIMATIONS.MELEE)
#	PLAYER_ACTION_SHOOT = false
#	check_turn()

#func calculate_melee_damage(is_attacker,is_target):
#	is_target.stat_health -= is_attacker.stat_melee_dmg
#	if is_target.stat_health <= 0:
##		is_target.NODE_ANIMATED_SPRITE.hide()
##		Sound.call_deferred("play_sound_deferred",is_target,is_target.sound_on_death)
##		yield(is_target.NODE_SOUND,"finished")
#		Sound.play_sound_death(is_attacker,is_target.sound_on_death)
#		Global.LEVEL_LAYER_LOGIC.remove_child(is_target)
#		is_target.queue_free()
#	elif is_target.stat_health > 0:
#		Sound.play_sound(is_target,is_target.sound_on_hit)
#	yield(self.get_idle_frame(),"completed")
#
#func calculate_ranged_damage(is_attacker,is_target,ranged_damage,ammo_type:String):
#	var ammo = get(ammo_type) 
#	ammo -= 1
#	set(ammo_type,ammo)
#	Global.UI_AMMO.set_text(ammo as String)
#	is_target.stat_health -= ranged_damage
#	if is_target.stat_health <= 0:
#		is_target.NODE_ANIMATED_SPRITE.hide()
#		Sound.call_deferred("play_sound_deferred",is_target,is_target.sound_on_death)
##		Sound.play_sound_death(is_target,is_target.sound_on_death)
#		yield(is_target.NODE_SOUND,"finished")
#		Global.LEVEL_LAYER_LOGIC.remove_child(is_target)
#		is_target.queue_free()
##		yield(self.get_idle_frame(),"completed")
#	elif is_target.stat_health > 0:
#		Sound.call_deferred("play_sound_deferred",is_target,is_target.sound_on_hit)
#		yield(is_target.NODE_SOUND,"finished")
##		Sound.play_sound(is_target,is_target.sound_on_hit)
##		yield(self.get_idle_frame(),"completed")
#	yield(self.get_idle_frame(),"completed")
#	emit_signal("on_action_finished")

#func ui_update():
#	if Data.EQUIPMENT[0].empty() == false:
#		var ammo = get(Global.GUI_WEAPON.get_child(1).ammo_type)
#		Global.UI_AMMO.set_text(ammo as String)
#	Global.UI_HEALTH.set_text(self.stat_health as String)
#	Global.UI_SHIELD.set_text(self.stat_shield as String)
#	Global.UI_TURN.set_text((self.stat_speed - self.turn_count)as String)

#func manager_mob_old():
#	print("---------------------------------------------------------")
#	print("THE QUEUE SIZE IS: %s" %level_queue.size())
#	for i in (level_queue.size()):
##		print(i)
##		yield(get_tree().create_timer(0.025),"timeout")
#		moving_entity = Global.LEVEL_LAYER_LOGIC.get_node(level_queue[i][1])
##		print("Currently Moving: %s" %moving_entity.name)
##		print("Currently Moving: %s" %moving_entity)
#		manager_mob_actions_old()
#		yield(self,"on_manager_mob_actions_finished")
#
#	print("< MANAGER MOB FINISHED, CHANGE TO PLAYER >")
#	Global.game_state_manager(Global.GAME_STATE_LIST.STATE_PLAYER_TURN)
#	pass
#
#func manager_mob_actions_old():
#	Global.LEVEL_LAYER_LOGIC.astar_prepare()
#	Global.LEVEL_LAYER_LOGIC.astar_remove_mobs(moving_entity)
#	Global.LEVEL_LAYER_LOGIC.astar_build()
#
#	# ENGAGED MELEE CLASS
#	if moving_entity.AI_state == Global.AI_STATE_LIST.STATE_ENGAGE && moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_MELEE:
#		for speed in moving_entity.stat_speed:
#			moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
#			target_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(target_entity.get_global_position())
#			moving_entity_path = Global.LEVEL_LAYER_LOGIC.astar_get_path(moving_entity_position,target_entity_position)
#			if moving_entity_path.size() == 0:
#				yield(self.get_idle_frame(),"completed")
#			elif moving_entity_path.size() > 0:
#				if moving_entity_path[1] == target_entity_position:
#					mob_action_attack(moving_entity_path[0],moving_entity_path[1])
#					Sound.play_sound(moving_entity,moving_entity.sound_on_melee)
#					Sound.play_sound(target_entity,target_entity.sound_on_hit)
#					yield(self,"on_mob_action_finished")
#					moving_entity.on_action_attack()
#				elif moving_entity_path[1] != target_entity_position:
#					var cell_is_fog:bool = cell_is_fog(moving_entity_path[1])
#					if cell_is_fog == true:
#						mob_action_shift(moving_entity_path[0],moving_entity_path[1])
#						yield(self.get_idle_frame(),"completed")
#						moving_entity.on_action_move()
#						yield(moving_entity,"on_action_finished")
#						yield(self.get_idle_frame(),"completed")
#					elif cell_is_fog == false:
#						mob_action_move(moving_entity_path[0],moving_entity_path[1])
#						Sound.play_sound(moving_entity,moving_entity.sound_on_move)
#						yield(self,"on_mob_action_finished")
#						moving_entity.on_action_move()
#						yield(moving_entity,"on_action_finished")
#						yield(self.get_idle_frame(),"completed")
#
#	# ENGAGED RANGED CLASS
#	elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_ENGAGE && moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_RANGED:
#		for speed in moving_entity.stat_speed:
#			moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
#			target_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(target_entity.get_global_position())
#			moving_entity_path = Global.LEVEL_LAYER_LOGIC.astar_get_path(moving_entity_position,target_entity_position)
#			if moving_entity_path.size() == 0:
#				yield(self.get_idle_frame(),"completed")
#			elif moving_entity_path.size() != 0 && moving_entity_path.size() != 3:
#				if moving_entity_path[1] == target_entity_position:
#					mob_action_attack(moving_entity_path[0],moving_entity_path[1])
#					Sound.play_sound(moving_entity,moving_entity.sound_on_melee)
#					Sound.play_sound(target_entity,target_entity.sound_on_hit)
#					yield(self,"on_mob_action_finished")
#					moving_entity.on_action_attack()
#				elif moving_entity_path[1] != target_entity_position:
#					var cell_is_fog:bool = cell_is_fog(moving_entity_path[1])
#					if cell_is_fog == true:
#						mob_action_shift(moving_entity_path[0],moving_entity_path[1])
#						yield(self.get_idle_frame(),"completed")
#						moving_entity.on_action_move()
#						yield(moving_entity,"on_action_finished")
#						yield(self.get_idle_frame(),"completed")
#					elif cell_is_fog == false:
#						mob_action_move(moving_entity_path[0],moving_entity_path[1])
#						Sound.play_sound(moving_entity,moving_entity.sound_on_move)
#						yield(self,"on_mob_action_finished")
#						moving_entity.on_action_move()
#						yield(moving_entity,"on_action_finished")
#						yield(self.get_idle_frame(),"completed")
#			elif moving_entity_path.size() == 3:
#				for direction in DIRECTION_LIST:
#					var check_direction = (moving_entity_path[0]+(direction*2))
#					if check_direction == moving_entity_path[2]:
#						Global.LEVEL_LAYER_LOGIC.level_projectile_spawn(moving_entity.projectile,moving_entity.NODE_POSITION_2D,direction,true)
#						mob_action_shoot(moving_entity_path[0],moving_entity_path[0]+direction)
#						Sound.play_sound(moving_entity,moving_entity.sound_on_ranged)
#						Sound.play_sound(target_entity,target_entity.sound_on_hit)
#						yield(self,"on_mob_action_finished")
#						moving_entity.on_action_attack()
#				yield(self.get_idle_frame(),"completed")
#
#	# WANDER STATE
#	elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_WANDER:
#		print("QUEEN MOVING")
#		var nearby_cells = DIRECTION_LIST
#		nearby_cells.shuffle()
#		for cell in nearby_cells:
#			print(cell)
#			moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
#			target_entity_position = moving_entity_position + cell
#			moving_entity.NODE_RAYCAST_COLLIDE.cast_to = ((Vector2(0,0)+cell)*grid_size)
#			moving_entity.NODE_RAYCAST_COLLIDE.force_raycast_update()
#			if moving_entity.NODE_RAYCAST_COLLIDE.is_colliding() == false:
#				print("NOT COLLIDING")
#				mob_action_move(moving_entity_position,target_entity_position)
#				yield(self,"on_mob_action_finished")
#				break
#			if moving_entity.NODE_RAYCAST_COLLIDE.is_colliding() == true:
#				print("COLLIDING")
#				pass
#		yield(self.get_idle_frame(),"completed")
#
#	# IDLE STATE
#	elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_IDLE: 
#		yield(self.get_idle_frame(),"completed")
#
#	# COMPLETED
#	print("< MANAGER MOB ACTIONS FINISHED >")
#	emit_signal("on_manager_mob_actions_finished")
#
## Remove hostile entities from astar
#func astar_remove_hostile_cells(start_point,end_point):
#	var points_list:Array
#	var size = Global.LEVEL_LAYER_LOGIC.get_child_count()
#	var idx = 0
#	while idx < size:
#		var point = Global.LEVEL_LAYER_LOGIC.get_child(idx)
#		if point.is_in_group(Global.GROUPS.HOSTILE) && point != start_point:
#			if point != end_point:
#				point = (world_to_map(point.get_global_position()))
#				tilemap_astar_cells.remove(tilemap_astar_cells.find(Vector2(point.x,point.y)))
#			elif point == end_point:
#				pass
#			else:
#				pass
#		elif point.is_in_group(Global.GROUPS.HOSTILE) && point == start_point:
#			pass
#		else:
#			pass
#		idx += 1
#
#func astar_remove_mobs(mob_current):
#	var mob_list = get_tree().get_nodes_in_group(Global.GROUPS.KINEMATIC)
#	for size in mob_list.size():
#		var mob = mob_list[size]
#		if mob != mob_current:
#			var mob_position = (world_to_map(mob.get_global_position()))
#			tilemap_astar_cells.remove(tilemap_astar_cells.find(Vector2(mob_position.x,mob_position.y)))
#		elif mob == mob_current:
#			pass
#
#func astar_remove_extra_cells(extraPoint):
#	tilemap_astar_cells.remove(tilemap_astar_cells.find(Vector2(extraPoint.x,extraPoint.y)))
#
#func item_pickup_weapon():
#	var slot = Data.EQUIPMENT[0]
#	if slot.empty() == true:
#		slot.append(self)
#		Global.LEVEL_LAYER_LOGIC.remove_child(self) 
#		Global.GUI_WEAPON.add_child(self)
#		Global.GUI_WEAPON_ICON.texture = $Sprite.texture
#		Sound.play_sound(self,Sound.sfx_pickup)
#	elif slot.empty() == false:
#		var current_weapon = Global.GUI_WEAPON.get_child(1)
#		current_weapon.position = Global.NODE_PLAYER.position
#		slot.clear()
#		Global.GUI_WEAPON.remove_child(current_weapon)
#		Global.LEVEL_LAYER_LOGIC.add_child(current_weapon)
#		slot.append(self)
#		Global.LEVEL_LAYER_LOGIC.remove_child(self)
#		Global.GUI_WEAPON.add_child(self)
#		Global.GUI_WEAPON_ICON.texture = $Sprite.texture
#		Sound.play_sound(self,Sound.sfx_pickup)
#	pass
#
#func item_pickup_consumable():
#	for key in Data.INVENTORY:
#		var slot = Data.INVENTORY[key]
#		if slot.empty() == true:
#			slot.append(self)
#			inventory_slot = Data.INVENTORY[key]
#			inventory_slot_id = Data.INVENTORY_SLOT[key][0]
#			inventory_slot_texture = Data.INVENTORY_SLOT_ICON[key][0]
#			Global.LEVEL_LAYER_LOGIC.remove_child(self) 
#			Data.INVENTORY_SLOT[key][0].add_child(self)
#			Data.INVENTORY_SLOT_ICON[key][0].texture = $Sprite.texture
#			Sound.play_sound(self,Sound.sfx_pickup)
#			break
#	pass
#
#func item_inventory_remove():
#	inventory_slot.clear()
#	inventory_slot_texture.set_texture(null)
#	inventory_slot_id.remove_child(self)
#	self.queue_free()
#	pass
#
##	NODE_CAMERA_2D.limit_left = ((map_limits.position.x+1) * map_cellsize.x)
##	NODE_CAMERA_2D.limit_right = ((map_limits.end.x-1) * map_cellsize.x)
##	NODE_CAMERA_2D.limit_top = ((map_limits.position.y+1) * map_cellsize.y)
##	NODE_CAMERA_2D.limit_bottom = ((map_limits.end.y-1) * map_cellsize.y)
#
#func generator_room_add_shape():
#	var directions_8 = [
#		Vector2(0,0),
#		Vector2(0,-1),
#		Vector2(0,1),
#		Vector2(-1,0),
#		Vector2(1,0),
#		Vector2(1,1),
#		Vector2(1,-1),
#		Vector2(-1,1),
#		Vector2(-1,-1)
#	]
#
#	randomize()
#	var cell:Vector2
#	var room:Array
#
#	var shape_block = randi()%1+1
#
#	if shape_block > 0:
#		for count in shape_block:
#			room = self.get_used_cells_by_id(TILESET_LOGIC.TILE_FLOOR)
#			cell = (room[rand_range(0,room.size())])
#			for direction in directions_8:
#				var new_cell = cell + direction
#				self.set_cellv(new_cell,TILESET_LOGIC.TILE_BLOCK)
#				pass
#			pass
#		pass
#	pass
#
## GENERATOR BUILD COSMOS
##---------------------------------------------------------------------------------------
#func generator_cosmos_prepare():
#	randomize()
#	Global.LEVEL_LAYER_LOGIC.clear()
#	Global.LEVEL_LAYER_BASE.clear()
#	Global.LEVEL_LAYER_FOG.clear()
#	generator_cosmos_fill()
#	generator_cosmos_asteroids()
#	tilemap_texture_set_random(TILESET_BASE.TILE_FLOOR,TILESET_LOGIC.TILE_FLOOR,[0,0,0,10,12,12,12,13,14,15,16,17,18])
#	tilemap_texture_set_random_animated(TILESET_LOGIC.TILE_BLOCK,[4,5,6])
#	pass
#
#func generator_cosmos_fill():
#	# Fill Logic layer with floor tiles
#	for x in range(0, map_width):
#		for y in range(0, map_height):
#			set_cell(x, y, TILESET_LOGIC.TILE_FLOOR)
#	pass
#
#	# Add void tiles on outer border
#	for y in range(map_height):
#		set_cell(0, y, TILESET_LOGIC.TILE_VOID)
#		set_cell(map_width-1, y, TILESET_LOGIC.TILE_VOID)
#		for x in range(map_width):
#			set_cell(x,0, TILESET_LOGIC.TILE_VOID)
#			set_cell(x,map_height-1, TILESET_LOGIC.TILE_VOID)
#	pass
#
#func generator_cosmos_asteroids():
#	randomize()
#	var current_cells = self.get_used_cells_by_id(TILESET_LOGIC.TILE_FLOOR)
#	var asteriod_count = randi()%10+1
#
#	for i in asteriod_count:
#		var cell = current_cells[randi() % current_cells.size()]
#		current_cells.erase(cell)
#		self.set_cellv(cell,TILESET_LOGIC.TILE_BLOCK)
#		pass
#	pass
#
## GENERATOR BUILD HIVE
##---------------------------------------------------------------------------------------
#func generator_hive_prepare():
#	randomize()
#	Global.LEVEL_LAYER_LOGIC.clear()
#	Global.LEVEL_LAYER_BASE.clear()
#	Global.LEVEL_LAYER_FOG.clear()
#	generator_hive_fill()
#	utility_random_walker()
#	tilemap_texture_set_random(TILESET_BASE.TILE_FLOOR,TILESET_LOGIC.TILE_FLOOR,[1,3,4,5])
#	tilemap_texture_set_random(TILESET_BASE.TILE_FLOOR,TILESET_LOGIC.TILE_BLOCK,[3,4,5])
#	pass
#
#func generator_hive_fill():
#	# Fill Logic layer with block tiles
#	for x in range(0, map_width):
#		for y in range(0, map_height):
#			set_cell(x, y, TILESET_LOGIC.TILE_BLOCK)
#	pass
#
#	# Add void tiles on outer border
#	for y in range(map_height):
#		set_cell(0, y, TILESET_LOGIC.TILE_VOID)
#		set_cell(map_width-1, y, TILESET_LOGIC.TILE_VOID)
#		for x in range(map_width):
#			set_cell(x,0, TILESET_LOGIC.TILE_VOID)
#			set_cell(x,map_height-1, TILESET_LOGIC.TILE_VOID)
#	pass
#
#func utility_random_walker():
#	var directions = Global.DIRECTION_LIST
#	var cells = self.get_used_cells_by_id(TILESET_LOGIC.TILE_BLOCK)
#	var max_steps = 300
#	var current_cell = cells[randi() % cells.size()]
#	var next_cell
#
#	var walker = true
#	while walker == true:
#		for step in max_steps:
#			next_cell = current_cell + (directions[randi() % directions.size()])
#			if self.get_cellv(next_cell) != self.TILESET_LOGIC.TILE_VOID:
#				set_cellv(next_cell,TILESET_LOGIC.TILE_FLOOR)
#				set_cellv(next_cell,TILESET_LOGIC.TILE_FLOOR)
#				current_cell = next_cell
#			if self.get_cellv(next_cell) == self.TILESET_LOGIC.TILE_VOID:
#				pass
#		var result_cell = self.get_used_cells_by_id(TILESET_LOGIC.TILE_FLOOR)
#		if result_cell.size() >= 60:
#			walker = false
#
#func level_load(level_name:String):
#	var level_data = load("res://Scenes/%s.tscn" %level_name)
#	var level_instance = level_data.instance()
#	Global.NODE_MAIN.add_child(level_instance)
#
#	# Removes the Player and temporarily disables the Hive level
#	Global.LEVEL_LAYER_LOGIC.remove_child(Global.NODE_PLAYER)
#	Global.LEVEL.visible = false
#	Global.LEVEL.position = Vector2(128,0)
#
#	# Switches to another Level and adds the Player to it
#	Global.LEVEL = level_instance
#	Global.LEVEL_LAYER_FOG = level_instance.get_node("Fog")
#	Global.LEVEL_LAYER_DECO = level_instance.get_node("Deco")
#	Global.LEVEL_LAYER_BASE = level_instance.get_node("Base")
#	Global.LEVEL_LAYER_LOGIC = level_instance.get_node("Logic")
#	Global.LEVEL_LAYER_LOGIC.add_child(Global.NODE_PLAYER)
#
#	# Enable game state for Player
#	Global.LEVEL_LAYER_LOGIC.fog_update()
#	yield(get_tree().create_timer(0.5),"timeout")
#	Global.game_state_manager(Global.GAME_STATE_LIST.STATE_PLAYER_TURN)
#	pass
#
#func level_change(level_name:String):
#	Global.LEVEL = Global.LEVEL_NEXT
#	Global.LEVEL_LAYER_FOG = Global.LEVEL_NEXT.get_node("Fog")
#	Global.LEVEL_LAYER_DECO = Global.LEVEL_NEXT.get_node("Deco")
#	Global.LEVEL_LAYER_BASE = Global.LEVEL_NEXT.get_node("Base")
#	Global.LEVEL_LAYER_LOGIC = Global.LEVEL_NEXT.get_node("Logic")
#	pass

#			elif collider.get_class() == "TileMap":
#				if collider_cell_id == Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_DOOR:
#					var cell_to_check = Global.LEVEL_LAYER_LOGIC.get_cellv(collider_cell+Vector2.DOWN)
#					Global.LEVEL_LAYER_LOGIC.set_cell(collider_cell.x,collider_cell.y,Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_FLOOR)
#					if cell_to_check == Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_FLOOR:
#						Global.LEVEL_LAYER_LOGIC.tilemap_texture_set_fixed(Global.LEVEL_LAYER_BASE,Global.LEVEL_LAYER_LOGIC.TILESET_BASE.TILE_DOOR_OPEN,collider_cell,0)
#						Global.LEVEL_LAYER_LOGIC.tilemap_texture_set_fixed(Global.LEVEL_LAYER_WALL,Global.LEVEL_LAYER_LOGIC.TILESET_BASE.TILE_WALL,collider_cell+Vector2.DOWN,7)
#					if cell_to_check != Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_FLOOR:
#						Global.LEVEL_LAYER_LOGIC.tilemap_texture_set_fixed(Global.LEVEL_LAYER_BASE,Global.LEVEL_LAYER_LOGIC.TILESET_BASE.TILE_DOOR_OPEN,collider_cell,0)
#					Global.LEVEL_LAYER_LOGIC.update_dirty_quadrants()
#					yield(self.get_idle_frame(),"completed")
#					Global.LEVEL_LAYER_LOGIC.fog_update()
#					check_turn()
#					done = true
#				elif collider_cell_id == Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_OBJECT:
#					var object_array = get_tree().get_nodes_in_group(Global.GROUPS.OBJECT)
#					for object in object_array:
#						if object.position == cellB:
#							print(object)
#							pass
#					PLAYER_ACTION_TEXT = true
#					action_textlog()
#					done = true

#func action_collision_check(direction):
#	PLAYER_ACTION_INPUT = true
#	var done = false
#	while done == false:
#		NODE_RAYCAST_COLLIDE.cast_to = (direction*grid_size)
#		NODE_RAYCAST_COLLIDE.force_raycast_update()
#
#		if NODE_RAYCAST_COLLIDE.is_colliding() == false: 
#			action_move(direction)
#			done = true
#		if NODE_RAYCAST_COLLIDE.is_colliding() == true:
#			var cellA = NODE_MAIN.position
#			var cellB = NODE_MAIN.position + (direction * grid_size)
#			var collider = NODE_RAYCAST_COLLIDE.get_collider()
#			var collider_cell = Vector2(cellB.x/8,cellB.y/8)
#			var collider_cell_id = Global.LEVEL_LAYER_LOGIC.get_cell(collider_cell.x,collider_cell.y)
#
#			if collider.get_class() == null:
#				done = true
#			elif collider.get_class() == "KinematicBody2D":
#				if collider.is_in_group(Global.GROUPS.HOSTILE) == true: 
#					action_attack(direction,collider)
#					done = true
#				if collider.is_in_group(Global.GROUPS.ALLY) == true:
#					done = true
#				if collider.is_in_group(Global.GROUPS.QUEEN) == true:
#					Global.GAME_STATE = Global.GAME_STATE_LIST.STATE_NONE
#					PLAYER_ACTION_TEXT = true
#					action_textlog()
#					Global.GAME_STATE = Global.GAME_STATE_LIST.STATE_PLAYER_TURN
#					done = true
#			elif collider.get_class() == "StaticBody2D":
#				if collider.is_in_group(Global.GROUPS.ITEM) == true:
#					NODE_RAYCAST_COLLIDE.add_exception(collider)
#					yield(self.get_idle_frame(),"completed")
#				else:
#					done = true
#	NODE_RAYCAST_COLLIDE.clear_exceptions()
#	PLAYER_ACTION_INPUT = false

#	var node_to_scan = Global.LEVEL_LAYER_LOGIC
#	var node_to_scan_size:int = node_to_scan.get_child_count()
#	for i in node_to_scan_size:
#		var node_child = node_to_scan.get_child(i)
#		if node_child.is_in_group(Global.GROUPS.ITEM) == true:
#			NODE_RAYCAST_COLLIDE.add_exception(node_child)

#		if child_position != moving_body_position and child_position != target_body_position and child.is_in_group(Global.GROUPS.ITEM):

	# WANDER STATE
#		elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_WANDER:
#			var nearby_cells = DIRECTION_LIST
#			nearby_cells.shuffle()
#			for cell in nearby_cells:
#				moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
#				target_entity_position = moving_entity_position + cell
#				moving_entity.NODE_RAYCAST_COLLIDE.cast_to = ((Vector2(0,0)+cell)*grid_size)
#				moving_entity.NODE_RAYCAST_COLLIDE.force_raycast_update()
#				if moving_entity.NODE_RAYCAST_COLLIDE.is_colliding() == false:
#					# Check if mob enters a fog hidden cell
#					var cell_is_fog:bool = cell_is_fog(target_entity_position)
#					if cell_is_fog == true:
#						mob_action_shift(moving_entity_position,target_entity_position)
#						yield(self,"on_mob_action_finished")
#					elif cell_is_fog == false:
#						mob_action_move(moving_entity_position,target_entity_position)
#						yield(self,"on_mob_action_finished")
#					break
#				elif moving_entity.NODE_RAYCAST_COLLIDE.is_colliding() == true:
#					pass
#			yield(self.get_idle_frame(),"completed")

#func get_raycast_exceptions(raycast,group):
#	var node_to_scan = Global.LEVEL_LAYER_LOGIC
#	var node_to_scan_size:int = node_to_scan.get_child_count()
#	for i in node_to_scan_size:
#		var node_child = node_to_scan.get_child(i)
#		if node_child.is_in_group(group) == true:
#			raycast.add_exception(node_child)
#	pass

#func action_use(slot_id,slot_ui):
#	PLAYER_ACTION_INPUT = true
#
#	var slot = Data.INVENTORY[slot_id]
#	if slot.empty() == false:
#		var item = slot[0]
#		item.on_action_use()
#		yield(self.get_idle_frame(),"completed")
#		check_turn()
#	PLAYER_ACTION_INPUT = false
#	pass

#	for item in item_count:
#		randomize()
#		var cell = free_cells[randi() % free_cells.size()]
#		var item_type = item_list[randi() % item_list.size()]
#		var item_chance = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("ITEMS")[item_type]
#		var spawn_chance = util_chance(item_chance)
#		if spawn_chance == true:
#			Global.LEVEL.level_item_spawn(item_type,cell)
#			free_cells.erase(cell)
#	pass

#func float_tween():
#	NODE_TWEEN.interpolate_property(self,"scale",scale,Vector2(0.7,0.7),0.2,Tween.TRANS_LINEAR,Tween.EASE_OUT)
#	NODE_TWEEN.start()
#	yield(NODE_TWEEN,"tween_completed")
#	NODE_TWEEN.interpolate_property(self,"scale",Vector2(0.7,0.7),Vector2(0.1,0.1),0.4,Tween.TRANS_LINEAR,Tween.EASE_OUT)
#	NODE_TWEEN.start()
#	yield(NODE_TWEEN,"tween_completed")
#	NODE_TWEEN.emit_signal("tween_all_completed")
#	pass

#func _unhandled_input(key):
#	var next_button
#	for input in INPUT_LIST.values():
#		if key.is_action_pressed(input) and Global.GAME_STATE == Global.GAME_STATE_LIST.STATE_MENU:
#			# UP KEY PRESSED
#			if input == INPUT_LIST.UI_UP:
#				if current_button.focus_previous != null:
#					next_button = current_button.focus_previous.get_name(current_button.focus_previous.get_name_count()-1)
#					self.get_node(next_button).grab_focus()
#
#			# DOWN KEY PRESSED
#			if input == INPUT_LIST.UI_DOWN:
#				print("inputdown")
#				if current_button.focus_next != null:
#					next_button = current_button.focus_next.get_name(current_button.focus_next.get_name_count()-1)
#					self.get_node(next_button).grab_focus()
#					print(self.get_node(next_button))


#func _on_Button_focused(button):
#	# Update the current button when a new button is focused
#	current_button = button

#	var player = Global.LEVEL_LAYER_LOGIC.get_node("Player")
#	var player_position = Global.LEVEL_LAYER_LOGIC.world_to_map(player.get_global_position())

#	for cell in cell_array:
#		player.raycast_cast_to(player.NODE_RAYCAST_MOB,player_position,cell)
#		player.NODE_RAYCAST_MOB.force_raycast_update()
#		if player.NODE_RAYCAST_MOB.is_colliding() == true:
#			var raycast_collider = player.NODE_RAYCAST_MOB.get_collider()
#			var raycast_collider_point = player.NODE_RAYCAST_MOB.get_collision_point()
#			var raycast_collider_position = self.world_to_map(raycast_collider_point)
#			if raycast_collider == Global.LEVEL_LAYER_LOGIC:
#				pass
##			elif raycast_collider.is_in_group(Global.GROUPS.ITEM):
##				player.NODE_RAYCAST_MOB.add_exception(raycast_collider)
#			elif raycast_collider.is_in_group(Global.GROUPS.HOSTILE) && raycast_collider.AI_state != Global.AI_STATE_LIST.STATE_WANDER:
#				raycast_collider.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
#				player.NODE_RAYCAST_MOB.add_exception(raycast_collider)
##			elif raycast_collider.is_in_group(Global.GROUPS.HOSTILE):
##				raycast_collider.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
##				player.NODE_RAYCAST_MOB.add_exception(raycast_collider)
#		if player.NODE_RAYCAST_MOB.is_colliding() == false:
#			pass

#			elif raycast_collider.is_in_group(Global.GROUPS.KINEMATIC):
#				player.NODE_RAYCAST_FOG.add_exception(raycast_collider)
#				Global.LEVEL_LAYER_FOG.set_cell(cell.x, cell.y, TILESET_FOG.TILE_NONE)
#			elif raycast_collider.is_in_group(Global.GROUPS.ITEM):
#				player.NODE_RAYCAST_FOG.add_exception(raycast_collider)
#				Global.LEVEL_LAYER_FOG.set_cell(cell.x, cell.y, TILESET_FOG.TILE_NONE)

#				var raycast_collider_title = Global.LEVEL_LAYER_LOGIC.get_cellv(raycast_collider_position)
#				if raycast_collider_title == Global.LEVEL_LAYER_LOGIC.TILESET_LOGIC.TILE_BLOCK: pass

#	min_width = randi() % 3 +1
#	stop_width = min_width * 2 + 1

#	tilemap_texture_set_random(Global.LEVEL_LAYER_BASE,TILESET_BASE.TILE_BLOCK,TILESET_LOGIC.TILE_EMPTY,[8,9,10])

#func generator_room_add_objects():
#	var count:int
##	var cells_count:int = randi()%3+3
#	var cells_count:int = 1
#	var cells_list = []
#	var cells_to_fill = []
#	for cell in get_used_cells_by_id(TILESET_LOGIC.TILE_FLOOR):
#		count = util_check_nearby_tile_4(cell.x, cell.y, TILESET_LOGIC.TILE_BLOCK)
#		if count == 3:
#			cells_list.append(cell)
#		count = util_check_nearby_tile_8(cell.x, cell.y, TILESET_LOGIC.TILE_FLOOR)
#		if count == 8 or count == 7:
#			cells_list.append(cell)
#		count = util_check_nearby_tile_8(cell.x, cell.y, TILESET_LOGIC.TILE_BLOCK)
#		if count == 3 or count == 5:
#			cells_to_fill.append(cell)
#		count = util_check_diagonal_tile_4(cell.x, cell.y, TILESET_LOGIC.TILE_BLOCK)
#		if count == 4:
#			cells_to_fill.append(cell)

#	for cell in get_used_cells_by_id(TILESET_LOGIC.TILE_BLOCK):
#		count = util_check_nearby_tile_4(cell.x, cell.y, TILESET_LOGIC.TILE_FLOOR)
#		if count >= 1 and map_border.has(cell) == false:
#			cells_to_fill.append(cell)
	
#	for i in cells_count:
#		if cells_list.size() >= i:
#			var cell = cells_list[rand_range(0,cells_list.size())]
#			if cells_list.has(Vector2(cell.x, cell.y-1)): cells_list.erase(Vector2(cell.x, cell.y-1))
#			if cells_list.has(Vector2(cell.x, cell.y+1)): cells_list.erase(Vector2(cell.x, cell.y+1))
#			if cells_list.has(Vector2(cell.x-1, cell.y)): cells_list.erase(Vector2(cell.x-1, cell.y))
#			if cells_list.has(Vector2(cell.x+1, cell.y)): cells_list.erase(Vector2(cell.x+1, cell.y))
#			if cells_list.has(Vector2(cell.x+1, cell.y+1)):  cells_list.erase(Vector2(cell.x+1, cell.y+1))
#			if cells_list.has(Vector2(cell.x+1, cell.y-1)):  cells_list.erase(Vector2(cell.x+1, cell.y-1))
#			if cells_list.has(Vector2(cell.x-1, cell.y+1)):  cells_list.erase(Vector2(cell.x-1, cell.y+1))
#			if cells_list.has(Vector2(cell.x-1, cell.y-1)):  cells_list.erase(Vector2(cell.x-1, cell.y-1))
#			cells_to_fill.append(cell)
#		else:
#			break
#
#
#	for cell in cells_to_fill:
#		set_cellv(cell,TILESET_LOGIC.TILE_EMPTY)
#	pass

#onready var LEVEL_DATA_OLD = {
#	1: {
#		"SETTINGS": {
#			"Visibility": 7
#		},
#		"LEVELS": {
#			"Level_1": 100
#		},
#		"MOBS": {
#			"Grunt": 100,
#			"Parasite": 25,
#			"Colony": 5
#		},
#		"ITEMS": {
#			"COMMON": {
#				"Ammo": 100,
#				"Medkit": 50
#			},
#			"CONSUMABLES": {
#				"Adrenalin": 10,
#				"Steroids": 10,
#				"Grenade": 10,
#				"Teleport": 10
#			},
#			"WEAPONS": {
#				"TacticalShotgun": 5,
#				"AssaultRifle": 5,
#				"SubmachineGun": 5,
#				"HuntingRifle": 5,
#				"SniperRifle": 5,
#				"SawnOff": 5,
#				"Shotgun": 5
#			},
#			"OTHER": {
#				"BigDan001": 100
#			}
#		},
#	},
#	2: {
#		"SETTINGS": {
#			"Visibility": 7
#		},
#		"LEVELS": {
#			"Level_1": 100
#		},
#		"MOBS": {
#			"Grunt": 100,
#			"Parasite": 50,
#			"Bloater": 25,
#			"Colony": 10
#		},
#		"ITEMS": {
#			"COMMON": {
#				"Ammo": 100,
#				"Medkit": 50
#			},
#			"CONSUMABLES": {
#				"Adrenalin": 10,
#				"Steroids": 10,
#				"Grenade": 10,
#				"Teleport": 10
#			},
#			"WEAPONS": {
#				"TacticalShotgun": 5,
#				"AssaultRifle": 5,
#				"SubmachineGun": 5,
#				"HuntingRifle": 5,
#				"SniperRifle": 5,
#				"SawnOff": 5,
#				"Shotgun": 5
#			},
#			"OTHER": {
#				"BigDan001": 100
#			}
#		},
#	},
#	3: {
#		"SETTINGS": {
#			"Visibility": 7
#		},
#		"LEVELS": {
#			"Level_1": 100
#		},
#		"MOBS": {
#			"Grunt": 100,
#			"Parasite": 100,
#			"Bloater": 50,
#			"Colony": 15
#		},
#		"ITEMS": {
#			"COMMON": {
#				"Ammo": 100,
#				"Medkit": 50
#			},
#			"CONSUMABLES": {
#				"Adrenalin": 10,
#				"Steroids": 10,
#				"Grenade": 10,
#				"Teleport": 10
#			},
#			"WEAPONS": {
#				"TacticalShotgun": 5,
#				"AssaultRifle": 5,
#				"SubmachineGun": 5,
#				"HuntingRifle": 5,
#				"SniperRifle": 5,
#				"SawnOff": 5,
#				"Shotgun": 5
#			},
#			"OTHER": {
#				"BigDan001": 100
#			}
#		},
#	},
#	4: {
#		"SETTINGS": {
#			"Visibility": 7
#		},
#		"LEVELS": {
#			"Level_1": 100
#		},
#		"MOBS": {
#			"Grunt": 100,
#			"Parasite": 100,
#			"Bloater": 75,
#			"Colony": 25
#		},
#		"ITEMS": {
#			"COMMON": {
#				"Ammo": 100,
#				"Medkit": 50
#			},
#			"CONSUMABLES": {
#				"Adrenalin": 10,
#				"Steroids": 10,
#				"Grenade": 10,
#				"Teleport": 10
#			},
#			"WEAPONS": {
#				"TacticalShotgun": 5,
#				"AssaultRifle": 5,
#				"SubmachineGun": 5,
#				"HuntingRifle": 5,
#				"SniperRifle": 5,
#				"SawnOff": 5,
#				"Shotgun": 5
#			},
#			"OTHER": {
#				"BigDan001": 100
#			}
#		},
#	},
#	5: {
#		"SETTINGS": {
#			"Visibility": 5
#		},
#		"LEVELS": {
#			"Level_2": 100
#		},
#		"MOBS": {
#			"GruntInfected": 100,
#			"Goo": 50,
#			"Horror": 25
#		},
#		"ITEMS": {
#			"COMMON": {
#				"Ammo": 100,
#				"Medkit": 50
#			},
#			"CONSUMABLES": {
#				"Adrenalin": 10,
#				"Steroids": 10,
#				"Grenade": 10,
#				"Teleport": 10
#			},
#			"WEAPONS": {
#				"TacticalShotgun": 5,
#				"AssaultRifle": 5,
#				"SubmachineGun": 5,
#				"HuntingRifle": 5,
#				"SniperRifle": 5,
#				"SawnOff": 5,
#				"Shotgun": 5
#			},
#			"OTHER": {
#				"BigDan001": 100
#			}
#		},
#	},
#	6: {
#		"SETTINGS": {
#			"Visibility": 5
#		},
#		"LEVELS": {
#			"Level_2": 100
#		},
#		"MOBS": {
#			"GruntInfected": 100,
#			"Goo": 75,
#			"Horror": 25,
#			"Sludge": 50 
#		},
#		"ITEMS": {
#			"COMMON": {
#				"Ammo": 100,
#				"Medkit": 50
#			},
#			"CONSUMABLES": {
#				"Adrenalin": 10,
#				"Steroids": 10,
#				"Grenade": 10,
#				"Teleport": 10
#			},
#			"WEAPONS": {
#				"TacticalShotgun": 5,
#				"AssaultRifle": 5,
#				"SubmachineGun": 5,
#				"HuntingRifle": 5,
#				"SniperRifle": 5,
#				"SawnOff": 5,
#				"Shotgun": 5
#			},
#			"OTHER": {
#				"BigDan001": 100
#			}
#		},
#	},
#	7: {
#		"SETTINGS": {
#			"Visibility": 5
#		},
#		"LEVELS": {
#			"Level_2": 100
#		},
#		"MOBS": {
#			"GruntInfected": 100,
#			"Goo": 100,
#			"Horror": 50,
#			"Sludge": 75 
#		},
#		"ITEMS": {
#			"COMMON": {
#				"Ammo": 100,
#				"Medkit": 50
#			},
#			"CONSUMABLES": {
#				"Adrenalin": 10,
#				"Steroids": 10,
#				"Grenade": 10,
#				"Teleport": 10
#			},
#			"WEAPONS": {
#				"TacticalShotgun": 5,
#				"AssaultRifle": 5,
#				"SubmachineGun": 5,
#				"HuntingRifle": 5,
#				"SniperRifle": 5,
#				"SawnOff": 5,
#				"Shotgun": 5
#			},
#			"OTHER": {
#				"BigDan001": 100
#			}
#		},
#	},
#	8: {
#		"SETTINGS": {
#			"Visibility": 5
#		},
#		"LEVELS": {
#			"Level_2": 100
#		},
#		"MOBS": {
#			"GruntInfected": 100,
#			"Goo": 100,
#			"Horror": 75,
#			"Sludge": 100 
#		},
#		"ITEMS": {
#			"COMMON": {
#				"Ammo": 100,
#				"Medkit": 50
#			},
#			"CONSUMABLES": {
#				"Adrenalin": 10,
#				"Steroids": 10,
#				"Grenade": 10,
#				"Teleport": 10
#			},
#			"WEAPONS": {
#				"TacticalShotgun": 5,
#				"AssaultRifle": 5,
#				"SubmachineGun": 5,
#				"HuntingRifle": 5,
#				"SniperRifle": 5,
#				"SawnOff": 5,
#				"Shotgun": 5
#			},
#			"OTHER": {
#				"BigDan001": 100
#			}
#		},
#	},
#	9: {
#		"SETTINGS": {
#			"Visibility": 4
#		},
#		"LEVELS": {
#			"Level_3": 100
#		},
#		"MOBS": {
#			"Wart": 100,
#			"Hydra": 50,
#			"Behemoth": 25,
#			"Infestinator": 5,
#		},
#		"ITEMS": {
#			"COMMON": {
#				"Ammo": 100,
#				"Medkit": 50
#			},
#			"CONSUMABLES": {
#				"Adrenalin": 10,
#				"Steroids": 10,
#				"Grenade": 10,
#				"Teleport": 10
#			},
#			"WEAPONS": {
#				"TacticalShotgun": 5,
#				"AssaultRifle": 5,
#				"SubmachineGun": 5,
#				"HuntingRifle": 5,
#				"SniperRifle": 5,
#				"SawnOff": 5,
#				"Shotgun": 5
#			},
#			"OTHER": {
#				"BigDan001": 100
#			}
#		},
#	},
#	10: {
#		"SETTINGS": {
#			"Visibility": 4
#		},
#		"LEVELS": {
#			"Level_3": 100
#		},
#		"MOBS": {
#			"Wart": 100,
#			"Hydra": 75,
#			"Behemoth": 50,
#			"Infestinator": 25
#		},
#		"ITEMS": {
#			"COMMON": {
#				"Ammo": 100,
#				"Medkit": 50
#			},
#			"CONSUMABLES": {
#				"Adrenalin": 10,
#				"Steroids": 10,
#				"Grenade": 10,
#				"Teleport": 10
#			},
#			"WEAPONS": {
#				"TacticalShotgun": 5,
#				"AssaultRifle": 5,
#				"SubmachineGun": 5,
#				"HuntingRifle": 5,
#				"SniperRifle": 5,
#				"SawnOff": 5,
#				"Shotgun": 5
#			},
#			"OTHER": {
#				"BigDan001": 100
#			}
#		},
#	},
#	11: {
#		"SETTINGS": {
#			"Visibility": 4
#		},
#		"LEVELS": {
#			"Level_3": 100
#		},
#		"MOBS": {
#			"Wart": 100,
#			"Hydra": 100,
#			"Behemoth": 75,
#			"Infestinator": 50
#		},
#		"ITEMS": {
#			"COMMON": {
#				"Ammo": 100,
#				"Medkit": 50
#			},
#			"CONSUMABLES": {
#				"Adrenalin": 10,
#				"Steroids": 10,
#				"Grenade": 10,
#				"Teleport": 10
#			},
#			"WEAPONS": {
#				"TacticalShotgun": 5,
#				"AssaultRifle": 5,
#				"SubmachineGun": 5,
#				"HuntingRifle": 5,
#				"SniperRifle": 5,
#				"SawnOff": 5,
#				"Shotgun": 5
#			},
#			"OTHER": {
#				"BigDan001": 100
#			}
#		},
#	},
#	12: {
#		"SETTINGS": {
#			"Visibility": 4
#		},
#		"LEVELS": {
#			"Level_3": 100
#		},
#		"MOBS": {
#			"Wart": 100,
#			"Hydra": 100,
#			"Behemoth": 100,
#			"Infestinator": 100
#		},
#		"ITEMS": {
#			"COMMON": {
#				"Ammo": 100,
#				"Medkit": 50
#			},
#			"CONSUMABLES": {
#				"Adrenalin": 10,
#				"Steroids": 10,
#				"Grenade": 10,
#				"Teleport": 10
#			},
#			"WEAPONS": {
#				"TacticalShotgun": 5,
#				"AssaultRifle": 5,
#				"SubmachineGun": 5,
#				"HuntingRifle": 5,
#				"SniperRifle": 5,
#				"SawnOff": 5,
#				"Shotgun": 5
#			},
#			"OTHER": {
#				"BigDan001": 100
#			}
#		},
#	},
#}

#	for i in text.length():

#	var direction_list = Global.DIRECTION_LIST_8
#	var mob_list = get_tree().get_nodes_in_group(Global.GROUPS.HOSTILE)
#	for direction in direction_list:
#		var check_direction = item_throw_position + direction
#		for mob in mob_list:
#			if mob.position/grid_size == check_direction:
#				mob.calculate_other_damage(stat_frag_dmg,mob)
#			if mob != null && mob.NODE_BUFFS.find_node("Slowness") == null:
#				mob.buff_add("Slowness",mob)

#	print("MindFlayer position is: " + str(position_a/grid_size))
#	print("MindFlayer Tween active: " + str(self.NODE_TWEEN.is_active()))
#	print("Player position is: " + str(position_b/grid_size))
#	print("Player Tween active: " + str(Global.NODE_PLAYER.NODE_TWEEN.is_active()))
#	print("---------------------------")
	
	# VECTOR DECIMALS FIX
#	position_a = Vector2(int(position_a.x),int(position_a.y)) * grid_size
#	position_b = Vector2(int(position_b.x),int(position_b.y)) * grid_size
#
#	var occupied_cells_list = Global.LEVEL_LAYER_LOGIC.util_get_occupied_cells()
#	var cell_type = Global.LEVEL_LAYER_LOGIC.get_cellv(position_a/grid_size)

#				while mob_instance.NODE_TWEEN.is_active():
#					yield(get_tree(),"idle_frame")
#					pass
#				break

#	print("---------------------------------------------------------")
#	print("---------------------------------------------------------")
#	print("---------------------------------------------------------")
#	print("---------------------------------------------------------")
#	print("---------------------------------------------------------")
#	print("---------------------------------------------------------")


#func manager_mob():
##	print("---------------------------------------------------------")
##	print("THE QUEUE SIZE IS: %s" %level_queue.size())
#	if level_queue.size() != 0 and Global.GAME_STATE == Global.GAME_STATE_LIST.STATE_MOB_TURN:
#		for mob in (level_queue.size()):
#			moving_entity = Global.LEVEL_LAYER_LOGIC.get_node(level_queue[mob][1])
#			manager_mob_actions()
#			yield(self,"on_manager_mob_actions_finished")
##	print("< MANAGER MOB FINISHED, CHANGE TO PLAYER >")
#	if Global.GAME_STATE != Global.GAME_STATE_LIST.STATE_NONE:
#		Global.game_state_manager(Global.GAME_STATE_LIST.STATE_PLAYER_TURN)
#	else:
#		Global.NODE_MAIN.level_game_over()
#
#func manager_mob_actions():
#
#	for speed in moving_entity.stat_speed:
#	# ENGAGED MELEE CLASS STATE
#		if moving_entity.AI_state == Global.AI_STATE_LIST.STATE_ENGAGE && moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_MELEE:
#			moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
#			target_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(target_entity.get_global_position())
#			Global.LEVEL_LAYER_LOGIC.astar_find_occupied_points(moving_entity_position,target_entity_position)
#			moving_entity_path = Global.LEVEL_LAYER_LOGIC.astar_get_path(moving_entity_position,target_entity_position)
#
#			#CHECK IF MOB CAN REACH TARGET
#			if moving_entity_path.size() == 0:
#				yield(self.get_idle_frame(),"completed")
#			elif moving_entity_path.size() > 0:
#				#If next cell is target position > attack
#				if moving_entity_path[1] == target_entity_position:
#					mob_action_attack(moving_entity_path[0],moving_entity_path[1])
#					yield(self,"mob_action_completed")
#					moving_entity.on_action_attack()
#					yield(moving_entity,"on_action_finished")
#				#If next cell is not target position > move
#				elif moving_entity_path[1] != target_entity_position:
#					# Check if mob enters a fog hidden cell
#					var cell_is_fog:bool = cell_is_fog(moving_entity_path[1])
#					if cell_is_fog == true:
#						mob_action_shift(moving_entity_path[0],moving_entity_path[1])
#						yield(self,"on_mob_action_finished")
#						moving_entity.on_action_move()
#						yield(moving_entity,"on_action_finished")
#					elif cell_is_fog == false:
#						mob_action_move(moving_entity_path[0],moving_entity_path[1])
#						yield(self,"on_mob_action_finished")
#						moving_entity.on_action_move()
#						yield(moving_entity,"on_action_finished")
#
#	# ENGAGED RANGED CLASS STATE
#		elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_ENGAGE && moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_RANGED:
#			moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
#			target_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(target_entity.get_global_position())
#			Global.LEVEL_LAYER_LOGIC.astar_find_occupied_points(moving_entity_position,target_entity_position)
#			moving_entity_path = Global.LEVEL_LAYER_LOGIC.astar_get_path(moving_entity_position,target_entity_position)
#			#CHECK IF MOB CAN REACH TARGET
#			if moving_entity_path.size() == 0:
#				yield(self.get_idle_frame(),"completed")
#			elif moving_entity_path.size() != 0 && moving_entity_path.size() != 3:
#				#If next cell is target position > attack
#				if moving_entity_path[1] == target_entity_position:
#					mob_action_attack(moving_entity_path[0],moving_entity_path[1])
#					yield(self,"on_mob_action_finished")
#					moving_entity.on_action_attack()
#					yield(moving_entity,"on_action_finished")
#				#If next cell is not target position > move
#				elif moving_entity_path[1] != target_entity_position:
#					# Check if mob enters a fog hidden cell
#					var cell_is_fog:bool = cell_is_fog(moving_entity_path[1])
#					if cell_is_fog == true:
#						mob_action_shift(moving_entity_path[0],moving_entity_path[1])
#						yield(self,"on_mob_action_finished")
#						moving_entity.on_action_move()
#						yield(moving_entity,"on_action_finished")
#					elif cell_is_fog == false:
#						mob_action_move(moving_entity_path[0],moving_entity_path[1])
#						yield(self,"on_mob_action_finished")
#						moving_entity.on_action_move()
#						yield(moving_entity,"on_action_finished")
#			elif moving_entity_path.size() == 3:
#				for direction in DIRECTION_LIST:
#					var check_direction = (moving_entity_path[0]+(direction*2))
#					if check_direction == moving_entity_path[2]:
#						mob_action_shoot(moving_entity_path[0],moving_entity_path[0]+direction)
#						yield(self,"on_mob_action_finished")
#						moving_entity.on_action_shoot()
#						yield(moving_entity,"on_action_finished")
#						yield(get_tree(),"idle_frame")
#					yield(self.get_idle_frame(),"completed")
#
#	# ENGAGED AMBUSH CLASS STATE
#		elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_ENGAGE && moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_AMBUSH:
#			moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
#			target_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(target_entity.get_global_position())
#			Global.LEVEL_LAYER_LOGIC.astar_find_occupied_points(moving_entity_position,target_entity_position)
#			moving_entity_path = Global.LEVEL_LAYER_LOGIC.astar_get_path(moving_entity_position,target_entity_position)
#			#CHECK IF MOB CAN REACH TARGET
#			if moving_entity_path.size() == 0:
#				yield(self.get_idle_frame(),"completed")
#			elif moving_entity_path.size() != 0 && moving_entity_path.size() != 3:
#				#If next cell is target position > attack
#				if moving_entity_path[1] == target_entity_position:
#					mob_action_attack(moving_entity_path[0],moving_entity_path[1])
#					yield(self,"on_mob_action_finished")
#					moving_entity.on_action_attack()
#					yield(moving_entity,"on_action_finished")
#				#If next cell is not target position > move
#				elif moving_entity_path[1] != target_entity_position:
#					# Check if mob enters a fog hidden cell
#					var cell_is_fog:bool = cell_is_fog(moving_entity_path[1])
#					if cell_is_fog == true:
#						mob_action_shift(moving_entity_path[0],moving_entity_path[1])
#						yield(self,"on_mob_action_finished")
#						moving_entity.on_action_move()
#						yield(moving_entity,"on_action_finished")
#					elif cell_is_fog == false:
#						mob_action_move(moving_entity_path[0],moving_entity_path[1])
#						yield(self,"on_mob_action_finished")
#						moving_entity.on_action_move()
#						yield(moving_entity,"on_action_finished")
#			elif moving_entity_path.size() == 3:
#				for direction in DIRECTION_LIST:
#					var check_direction = (moving_entity_path[0]+(direction*2))
#					if check_direction == moving_entity_path[2]:
#						mob_action_move(moving_entity_path[0],moving_entity_path[1])
#						yield(self,"on_mob_action_finished")
#					yield(self.get_idle_frame(),"completed")
#
#	# WANDERING MELEE CLASS STATE
#		elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_WANDER && moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_MELEE:
#			moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
#			target_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(target_entity.get_global_position())
#			moving_entity_path = Global.LEVEL_LAYER_LOGIC.astar_get_path(moving_entity_position,target_entity_position)
#			moving_entity.get_raycast_exceptions(moving_entity.NODE_RAYCAST_COLLIDE,Global.GROUPS.ITEM)
#			var nearby_cells = DIRECTION_LIST
#			var target_near:bool = false
#			nearby_cells.shuffle()
#
##			# Check if the target is nearby
##			for cell in nearby_cells:
##				var cell_to_check = (moving_entity_position + (cell * moving_entity.stat_visibility))
##				if cell_to_check == target_entity_position: 
##					moving_entity.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
##					target_near = true
#
#			# Check if the target is nearby
#			var position_a:Vector2 = moving_entity_position
#			var position_b:Vector2 = Global.NODE_PLAYER.position / grid_size
#			var distance = (round(position_a.distance_to(position_b)))
#			if distance <= moving_entity.stat_visibility:
#				moving_entity.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
#				target_near = true
#
#			# If target is near > attack
#			if target_near == true && moving_entity_path.size() == 1:
#				moving_entity.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
#				mob_action_attack(moving_entity_position,target_entity_position)
#				yield(self,"on_mob_action_finished")
#				moving_entity.on_action_attack()
#				yield(moving_entity,"on_action_finished")
##				yield(self,"on_mob_action_finished")
#
#			# If target is not near > continue wandering
#			elif target_near == false:
#				for cell in nearby_cells:
#					moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
#					target_entity_position = moving_entity_position + cell
#					moving_entity.NODE_RAYCAST_COLLIDE.cast_to = ((Vector2(0,0)+cell)*grid_size)
#					moving_entity.NODE_RAYCAST_COLLIDE.force_raycast_update()
#					if moving_entity.NODE_RAYCAST_COLLIDE.is_colliding() == false:
#						# Check if mob enters a fog hidden cell
#						var cell_is_fog:bool = cell_is_fog(target_entity_position)
#						if cell_is_fog == true:
#							mob_action_shift(moving_entity_position,target_entity_position)
#							yield(self,"on_mob_action_finished")
#						elif cell_is_fog == false:
#							mob_action_move(moving_entity_position,target_entity_position)
#							yield(self,"on_mob_action_finished")
#						break
#					elif moving_entity.NODE_RAYCAST_COLLIDE.is_colliding() == true:
#						var collider = moving_entity.NODE_RAYCAST_COLLIDE.get_collider()
#						if collider.is_in_group(Global.GROUPS.PLAYER):
#							moving_entity.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
#							mob_action_attack(moving_entity_position,target_entity_position)
#							yield(self,"on_mob_action_finished")
#						break
#				yield(self.get_idle_frame(),"completed")
#			else:
#				yield(self.get_idle_frame(),"completed")
#
#	# ENGAGED WAITING CLASS STATE
#		elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_ENGAGE && moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_WAITING: 
#			moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
#			target_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(target_entity.get_global_position())
#			Global.LEVEL_LAYER_LOGIC.astar_find_occupied_points(moving_entity_position,target_entity_position)
#			moving_entity_path = Global.LEVEL_LAYER_LOGIC.astar_get_path(moving_entity_position,target_entity_position)
#
#			#CHECK IF MOB CAN REACH TARGET
#			if moving_entity_path.size() == 0:
#				moving_entity.on_action_move()
#				yield(moving_entity,"on_action_finished")
#				yield(self.get_idle_frame(),"completed")
#			elif moving_entity_path.size() > 0:
#				#If next cell is target position > attack
#				if moving_entity_path[1] == target_entity_position:
#					mob_action_attack(moving_entity_path[0],moving_entity_path[1])
#					yield(self,"on_mob_action_finished")
#					moving_entity.on_action_attack()
#					yield(moving_entity,"on_action_finished")
#				else:
#					moving_entity.on_action_move()
#					yield(moving_entity,"on_action_finished")
#					yield(self.get_idle_frame(),"completed")
#
#	# ENGAGED NONE CLASS STATE
#		elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_ENGAGE && moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_NONE: 
#			moving_entity.on_action_move()
#			yield(moving_entity,"on_action_finished")
#			yield(self.get_idle_frame(),"completed")
#
#	# IDLE STATE
#		elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_IDLE: 
#			yield(self.get_idle_frame(),"completed")
#
#	# COMPLETED
##	print("< MANAGER MOB ACTIONS FINISHED >")
#	emit_signal("on_manager_mob_action_finished")
#	pass
