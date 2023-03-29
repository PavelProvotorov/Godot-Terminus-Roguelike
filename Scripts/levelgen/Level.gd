extends Node2D

var grid_size = Global.grid_size
var map_height = Global.map_height
var map_width = Global.map_width

var level_entrance
var level_queue_mob_count:int
var level_queue_mob_turn:int
var level_queue

var moving_entity = null
var moving_entity_path
var moving_entity_position:Vector2

var target_entity = Global.NODE_PLAYER
var target_entitiy_path
var target_entity_position:Vector2

const DIRECTION_LIST:Array = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
	]

# SIGNALS
#---------------------------------------------------------------------------------------

signal mob_manager_completed
signal mob_manager_action_completed

signal mob_action_completed

# READY
#---------------------------------------------------------------------------------------
func _ready():
	Global.LEVEL = self
	Global.LEVEL_LAYER_FOG = $Fog
	Global.LEVEL_LAYER_DECO = $Deco
	Global.LEVEL_LAYER_BASE = $Base
	Global.LEVEL_LAYER_WALL = $Wall
	Global.LEVEL_LAYER_LOGIC = $Logic
	Global.LEVEL_LAYER_LOGIC.generator_room_prepare()
	self.z_index = -1
	level_add_logic()
	$Logic.astar_build()
	yield(self.get_idle_frame(),"completed")
	connect("mob_manager_completed",self,"on_mob_manager_completed")
	connect("mob_manager_action_completed",self,"on_mob_manager_action_completed")
	pass

# MOB BEHAVIOUR
#---------------------------------------------------------------------------------------

func on_mob_manager_started():
	moving_entity = null
	level_queue_mob_count = 0
	level_queue_mob_turn = 0
	
#	print(level_queue)
#	print(moving_entity)
#	print(level_queue.size())
#	print(level_queue_mob_count)
	
	mob_manager()
	pass

func on_mob_manager_completed():
	pass

func on_mob_manager_action_completed():
	mob_manager()
	pass

func mob_manager():
	if level_queue.size() != 0 and Global.GAME_STATE == Global.GAME_STATE_LIST.STATE_MOB_TURN:
		if moving_entity == null:
			level_queue_mob_turn += 1
			moving_entity = Global.LEVEL_LAYER_LOGIC.get_node(level_queue[level_queue_mob_count])
			mob_manager_action()
			pass
		elif level_queue_mob_turn == moving_entity.stat_speed:
			level_queue_mob_turn = 1
			level_queue_mob_count += 1
			if level_queue_mob_count > level_queue.size() -1:
				Global.game_state_manager(Global.GAME_STATE_LIST.STATE_PLAYER_TURN)
			else:
				moving_entity = Global.LEVEL_LAYER_LOGIC.get_node(level_queue[level_queue_mob_count])
				mob_manager_action()
				pass
			pass 
		elif level_queue_mob_turn < moving_entity.stat_speed:
			level_queue_mob_turn += 1
			moving_entity = Global.LEVEL_LAYER_LOGIC.get_node(level_queue[level_queue_mob_count])
			mob_manager_action()
			pass
		else:
			pass

	# REFACTOR LATER
	elif Global.GAME_STATE != Global.GAME_STATE_LIST.STATE_NONE:
		Global.game_state_manager(Global.GAME_STATE_LIST.STATE_PLAYER_TURN)
	else:
		Global.NODE_MAIN.level_game_over()
	pass

func mob_manager_action():
	# CHECK IF NODE EXISTS
	if not Global.LEVEL_LAYER_LOGIC.has_node(str(moving_entity)):
		pass
		
	# SPAWNED MOB
	elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_SPAWN:
		if moving_entity.NODE_TWEEN.is_active():
#			print("----------------------------")
#			print(moving_entity)
#			print(moving_entity.NODE_TWEEN.is_active())
			yield(moving_entity.NODE_TWEEN,"tween_all_completed")
#			yield(get_tree(),"idle_frame")
#			print(moving_entity.NODE_TWEEN.is_active())
		pass
		
	# ENGAGED MELEE CLASS STATE
	elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_ENGAGE && moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_MELEE:
		moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
		target_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(target_entity.get_global_position())
		Global.LEVEL_LAYER_LOGIC.astar_find_occupied_points(moving_entity_position,target_entity_position)
		moving_entity_path = Global.LEVEL_LAYER_LOGIC.astar_get_path(moving_entity_position,target_entity_position)
		
		#CHECK IF MOB CAN REACH TARGET
		if moving_entity_path.size() == 0:
			pass
		elif moving_entity_path.size() > 0:
			#If next cell is target position > attack
			if moving_entity_path[1] == target_entity_position:
				mob_action_attack(moving_entity_path[0],moving_entity_path[1])
				yield(self,"mob_action_completed")
				moving_entity.on_action_attack()
			#If next cell is not target position > move
			elif moving_entity_path[1] != target_entity_position:
				# Check if mob enters a fog hidden cell
				var cell_is_fog:bool = cell_is_fog(moving_entity_path[1])
				if cell_is_fog == true:
					mob_action_shift(moving_entity_path[0],moving_entity_path[1])
					yield(self,"mob_action_completed")
					moving_entity.on_action_move()
#					yield(moving_entity,"mob_action_all_completed")
				elif cell_is_fog == false:
					mob_action_move(moving_entity_path[0],moving_entity_path[1])
					yield(self,"mob_action_completed")
					moving_entity.on_action_move()

	# ENGAGED RANGED CLASS STATE
	elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_ENGAGE && moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_RANGED:
		moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
		target_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(target_entity.get_global_position())
		Global.LEVEL_LAYER_LOGIC.astar_find_occupied_points(moving_entity_position,target_entity_position)
		moving_entity_path = Global.LEVEL_LAYER_LOGIC.astar_get_path(moving_entity_position,target_entity_position)
		#CHECK IF MOB CAN REACH TARGET
		if moving_entity_path.size() == 0:
			pass
		elif moving_entity_path.size() != 0 && moving_entity_path.size() != 3:
			#If next cell is target position > attack
			if moving_entity_path[1] == target_entity_position:
#				print("ATTACKING")
				mob_action_attack(moving_entity_path[0],moving_entity_path[1])
				yield(self,"mob_action_completed")
				moving_entity.on_action_attack()
			#If next cell is not target position > move
			elif moving_entity_path[1] != target_entity_position:
				# Check if mob enters a fog hidden cell
				var cell_is_fog:bool = cell_is_fog(moving_entity_path[1])
				if cell_is_fog == true:
#					print("SHIFTING")
					mob_action_shift(moving_entity_path[0],moving_entity_path[1])
					yield(self,"mob_action_completed")
					moving_entity.on_action_move()
				elif cell_is_fog == false:
#					print("MOVING")
					mob_action_move(moving_entity_path[0],moving_entity_path[1])
					yield(self,"mob_action_completed")
					moving_entity.on_action_move()
		elif moving_entity_path.size() == 3:
			for direction in DIRECTION_LIST:
				var check_direction = (moving_entity_path[0]+(direction*2))
				if check_direction == moving_entity_path[2]:
#					print("SHOOTING")
					mob_action_shoot(moving_entity_path[0],moving_entity_path[0]+direction)
					yield(self,"mob_action_completed")
					moving_entity.on_action_shoot()
					break

# ENGAGED AMBUSH CLASS STATE
	elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_ENGAGE && moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_AMBUSH:
		moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
		target_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(target_entity.get_global_position())
		Global.LEVEL_LAYER_LOGIC.astar_find_occupied_points(moving_entity_position,target_entity_position)
		moving_entity_path = Global.LEVEL_LAYER_LOGIC.astar_get_path(moving_entity_position,target_entity_position)
		#CHECK IF MOB CAN REACH TARGET
		if moving_entity_path.size() == 0:
			pass
		elif moving_entity_path.size() != 0 && moving_entity_path.size() != 3:
			#If next cell is target position > attack
			if moving_entity_path[1] == target_entity_position:
				mob_action_attack(moving_entity_path[0],moving_entity_path[1])
				yield(self,"mob_action_completed")
				moving_entity.on_action_attack()
			#If next cell is not target position > move
			elif moving_entity_path[1] != target_entity_position:
				# Check if mob enters a fog hidden cell
				var cell_is_fog:bool = cell_is_fog(moving_entity_path[1])
				if cell_is_fog == true:
					mob_action_shift(moving_entity_path[0],moving_entity_path[1])
					yield(self,"mob_action_completed")
					moving_entity.on_action_move()
				elif cell_is_fog == false:
					mob_action_move(moving_entity_path[0],moving_entity_path[1])
					yield(self,"mob_action_completed")
					moving_entity.on_action_move()
		elif moving_entity_path.size() == 3:
			for direction in DIRECTION_LIST:
				var check_direction = (moving_entity_path[0]+(direction*2))
				if check_direction == moving_entity_path[2]:
					mob_action_move(moving_entity_path[0],moving_entity_path[1])
					yield(self,"mob_action_completed")
					moving_entity.on_action_move()
					break

# WANDERING MELEE CLASS STATE
	elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_WANDER && moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_MELEE:
		moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
		target_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(target_entity.get_global_position())
		moving_entity_path = Global.LEVEL_LAYER_LOGIC.astar_get_path(moving_entity_position,target_entity_position)
		moving_entity.get_raycast_exceptions(moving_entity.NODE_RAYCAST_COLLIDE,Global.GROUPS.ITEM)
		var nearby_cells = DIRECTION_LIST
		var target_near:bool = false
		nearby_cells.shuffle()
		
		# Check if the target is nearby
		var position_a:Vector2 = moving_entity_position
		var position_b:Vector2 = Global.NODE_PLAYER.position / grid_size
		var distance = (round(position_a.distance_to(position_b)))
		if distance <= moving_entity.stat_visibility:
			moving_entity.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
			target_near = true
		
		# If target is near > attack
		if target_near == true && moving_entity_path.size() == 1:
			moving_entity.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
			mob_action_attack(moving_entity_position,target_entity_position)
			yield(self,"mob_action_completed")
			moving_entity.on_action_attack()
			
		# If target is not near > continue wandering
		elif target_near == false:
			for cell in nearby_cells:
				moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
				target_entity_position = moving_entity_position + cell
				moving_entity.NODE_RAYCAST_COLLIDE.cast_to = ((Vector2(0,0)+cell)*grid_size)
				moving_entity.NODE_RAYCAST_COLLIDE.force_raycast_update()
				if moving_entity.NODE_RAYCAST_COLLIDE.is_colliding() == false:
					# Check if mob enters a fog hidden cell
					var cell_is_fog:bool = cell_is_fog(target_entity_position)
					if cell_is_fog == true:
						mob_action_shift(moving_entity_position,target_entity_position)
						yield(self,"mob_action_completed")
						moving_entity.on_action_move()
					elif cell_is_fog == false:
						mob_action_move(moving_entity_position,target_entity_position)
						yield(self,"mob_action_completed")
						moving_entity.on_action_move()
					break
				elif moving_entity.NODE_RAYCAST_COLLIDE.is_colliding() == true:
					var collider = moving_entity.NODE_RAYCAST_COLLIDE.get_collider()
					if collider.is_in_group(Global.GROUPS.PLAYER):
						moving_entity.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
						mob_action_attack(moving_entity_position,target_entity_position)
						yield(self,"mob_action_completed")
						moving_entity.on_action_attack()
					break
			pass
		else:
			pass
			
# ENGAGED WAITING CLASS STATE
	elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_ENGAGE && moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_WAITING: 
		moving_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(moving_entity.get_global_position())
		target_entity_position = Global.LEVEL_LAYER_LOGIC.world_to_map(target_entity.get_global_position())
		Global.LEVEL_LAYER_LOGIC.astar_find_occupied_points(moving_entity_position,target_entity_position)
		moving_entity_path = Global.LEVEL_LAYER_LOGIC.astar_get_path(moving_entity_position,target_entity_position)
		
		#CHECK IF MOB CAN REACH TARGET
		if moving_entity_path.size() == 0:
			moving_entity.on_action_move()
			pass
		elif moving_entity_path.size() > 0:
			#If next cell is target position > attack
			if moving_entity_path[1] == target_entity_position:
				mob_action_attack(moving_entity_path[0],moving_entity_path[1])
				yield(self,"mob_action_completed")
				moving_entity.on_action_attack()
			else:
				moving_entity.on_action_move()
				
# ENGAGED NONE CLASS STATE
	elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_ENGAGE && moving_entity.AI_class == Global.AI_CLASS_LIST.CLASS_NONE: 
		moving_entity.on_action_move()
		pass

# IDLE STATE
	elif moving_entity.AI_state == Global.AI_STATE_LIST.STATE_IDLE: 
		pass
	
	emit_signal("mob_manager_action_completed")
	pass

func mob_action_shift(cellA:Vector2,cellB:Vector2):
	#MOB MOVEMENT | START
	cellA = Vector2((cellA.x)*grid_size,(cellA.y)*grid_size)
	cellB = Vector2((cellB.x)*grid_size,(cellB.y)*grid_size)
	if cellA - cellB == Vector2(-grid_size,0): moving_entity.animation_flip(false,false)
	if cellA - cellB == Vector2(grid_size,0): moving_entity.animation_flip(true,false)
	moving_entity.action_move_notween(cellA,cellB)
	
	#MOB MOVEMENT | END
	yield(moving_entity.get_node("Tween"),"tween_all_completed")
	emit_signal("mob_action_completed")

func mob_action_move(cellA:Vector2,cellB:Vector2):
	#MOB MOVEMENT | START
	cellA = Vector2((cellA.x)*grid_size,(cellA.y)*grid_size)
	cellB = Vector2((cellB.x)*grid_size,(cellB.y)*grid_size)
	if cellA - cellB == Vector2(-grid_size,0): moving_entity.animation_flip(false,false)
	if cellA - cellB == Vector2(grid_size,0): moving_entity.animation_flip(true,false)
	Sound.sound_spawn(Global.NODE_SOUNDS,moving_entity.sound_on_move,moving_entity_position)
	moving_entity.action_move_tween(cellA,cellB)
	
	#MOB MOVEMENT | END
	yield(moving_entity.get_node("Tween"),"tween_all_completed")
	emit_signal("mob_action_completed")

func mob_action_attack(cellA:Vector2,cellB:Vector2):
	#MOB ATTACK | START
	cellA = Vector2((cellA.x)*grid_size,(cellA.y)*grid_size)
	cellB = Vector2((cellB.x)*grid_size,(cellB.y)*grid_size)
	if cellA - cellB == Vector2(-grid_size,0): moving_entity.animation_flip(false,false)
	if cellA - cellB == Vector2(grid_size,0): moving_entity.animation_flip(true,false)

	moving_entity.z_index += 1
	Sound.sound_spawn(Global.NODE_SOUNDS,moving_entity.sound_on_melee,moving_entity_position)
	moving_entity.calculate_melee_damage(moving_entity,target_entity)
	moving_entity.action_attack_tween(cellA,cellB)
	
	#MOB ATTACK | END
	yield(moving_entity.get_node("Tween"),"tween_completed")
	yield(moving_entity.get_node("Tween"),"tween_all_completed")
	moving_entity.z_index -= 1
	emit_signal("mob_action_completed")

func mob_action_shoot(cellA:Vector2,cellB:Vector2):
	#MOB ATTACK | START
	cellA = Vector2((cellA.x)*grid_size,(cellA.y)*grid_size)
	cellB = Vector2((cellB.x)*grid_size,(cellB.y)*grid_size)
	if cellA - cellB == Vector2(-grid_size,0): moving_entity.animation_flip(false,false)
	if cellA - cellB == Vector2(grid_size,0): moving_entity.animation_flip(true,false)

	moving_entity.z_index += 1
	Sound.sound_spawn(Global.NODE_SOUNDS,moving_entity.sound_on_ranged,moving_entity_position)
	moving_entity.calculate_ranged_damage(moving_entity,target_entity,moving_entity.stat_ranged_dmg)
	moving_entity.action_shoot_tween(cellA,get_negative_vector(cellA,cellB))
	
	#MOB ATTACK | END
	yield(moving_entity.get_node("Tween"),"tween_completed")
	yield(moving_entity.get_node("Tween"),"tween_all_completed")
	moving_entity.z_index -= 1
	emit_signal("mob_action_completed")

# PREPARE THE QUEUE FOR ACTIVE MOBS ON THE LOGIC LAYER
func level_queue_prepare():
	level_queue = []
	# List of mob groups to check
	var groups_to_check = [
		Global.GROUPS.HOSTILE,
		Global.GROUPS.KINEMATIC,
		Global.GROUPS.QUEEN,
		Global.GROUPS.ALLY
		
	]
	# List of mob states to check
	var states_to_check = [
		Global.AI_STATE_LIST.STATE_ENGAGE,
		Global.AI_STATE_LIST.STATE_WANDER
	]
	var idx = 0
	var node_to_scan = Global.LEVEL_LAYER_LOGIC
	var node_to_scan_size:int = node_to_scan.get_child_count()
	for i in node_to_scan_size:
		var node_child = node_to_scan.get_child(idx)
		var node_child_group_list = node_child.get_groups()
		var node_child_state:bool = states_to_check.has(node_child.get("AI_state"))
		var node_child_group:bool
		for group in node_child_group_list:
			if groups_to_check.has(group): node_child_group = true
			else: node_child_group = false
		if node_child_group == true && node_child_state == true && node_child.stat_speed != 0:
			var node_child_name:String = node_to_scan.get_child(idx).name
			var node_child_data:int = node_to_scan.get_child(idx).stat_ambition
#			var node_child_fetch = [node_child_data,node_child_name]
			var node_child_fetch = node_child_name
			level_queue.push_back(node_child_fetch)
		else:
			pass
		idx += 1
		i += 1
#	level_queue.sort_custom(self,"level_queue_sort")
	Global.LEVEL_QUEUE = level_queue
#	print("QUEUE AFTER SCAN:")
#	print(level_queue)
	pass

func level_queue_sort(a,b):
	if a[0] > b[0]:
		return true
	return false

func get_idle_frame():
	yield(get_tree(),"idle_frame")

# UTILITY
#---------------------------------------------------------------------------------------
# Adds LOGIC tiles, according to the tiles on the BASE layer
func level_add_logic():
	var cell_to_check
	
	# Check for BLOCK tiles
	cell_to_check = $Base.get_used_cells_by_id($Logic.TILESET_BASE.TILE_BLOCK)
	for cell in cell_to_check:
		$Logic.set_cellv(Vector2(cell.x,cell.y),$Logic.TILESET_LOGIC.TILE_BLOCK)
		pass
	pass
	
	# Check for FLOOR tiles
	cell_to_check = $Base.get_used_cells_by_id($Logic.TILESET_BASE.TILE_FLOOR)
	for cell in cell_to_check:
		$Logic.set_cellv(Vector2(cell.x,cell.y),$Logic.TILESET_LOGIC.TILE_FLOOR)
		pass
	pass

	# Check for ANIMATED tiles
	for id in ($Logic.TILESET_ANIMATED.values()):
		cell_to_check = $Base.get_used_cells_by_id(id)
		for cell in cell_to_check:
			$Logic.set_cellv(Vector2(cell.x,cell.y),$Logic.TILESET_LOGIC.TILE_BLOCK)
			pass
		pass
	pass

func level_item_spawn(item_name,item_position:Vector2):
	var item_data = load("res://Items/%s.tscn" %item_name)
	var item_instance = item_data.instance()
	Global.LEVEL_LAYER_LOGIC.add_child(item_instance)
	item_instance.set_global_position(Vector2((item_position.x)*grid_size,(item_position.y)*grid_size))
	yield(self.get_idle_frame(),"completed")

func level_mob_spawn(mob_name,mob_position:Vector2):
	var mob_data = load("res://Mobs/%s.tscn" %mob_name)
	var mob_instance = mob_data.instance()
	Global.LEVEL_LAYER_LOGIC.add_child(mob_instance)
	mob_instance.set_global_position(Vector2((mob_position.x)*grid_size,(mob_position.y)*grid_size))
	return mob_instance

func level_mob_spawn_invisible(mob_name,mob_position:Vector2):
	var mob_data = load("res://Mobs/%s.tscn" %mob_name)
	var mob_instance = mob_data.instance()
	mob_instance.visible = false
	Global.LEVEL_LAYER_LOGIC.add_child(mob_instance)
	mob_instance.set_global_position(Vector2((mob_position.x)*grid_size,(mob_position.y)*grid_size))
	return mob_instance

func level_mob_spawn_tween(mob_name,mob_position_a:Vector2,mob_position_b:Vector2):
	var mob_data = load("res://Mobs/%s.tscn" %mob_name)
	var mob_instance = mob_data.instance()
	Global.LEVEL_LAYER_LOGIC.add_child(mob_instance)
	mob_instance.set_global_position(Vector2((mob_position_a.x)*grid_size,(mob_position_a.y)*grid_size))
	mob_position_a = Vector2(mob_position_a.x*grid_size,mob_position_a.y*grid_size)
	mob_position_b = Vector2(mob_position_b.x*grid_size,mob_position_b.y*grid_size)
	mob_instance.action_move_tween(mob_position_a,mob_position_b)
	return mob_instance

func get_negative_vector(origin_vector, destination_vector):
	var negative_vector = (destination_vector - origin_vector).tangent().tangent() + origin_vector
	return Vector2(negative_vector.x,negative_vector.y)

func cell_is_fog(cell:Vector2):
	var cell_to_check = Vector2((cell.x)*grid_size,(cell.y)*grid_size)
	cell_to_check = Global.LEVEL_LAYER_FOG.get_cellv(cell)
	if cell_to_check == Global.LEVEL_LAYER_LOGIC.TILESET_FOG.TILE_FULL:
		return true
	if cell_to_check == Global.LEVEL_LAYER_LOGIC.TILESET_FOG.TILE_NONE:
		return false

func util_chance(percentage):
	randomize()
	if percentage == 0:
		return false
	elif randi() % 100 <= percentage:  
		return true
	else:                     
		return false
