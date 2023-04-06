extends TileMap

var tilemap_astar = AStar2D.new()
var tilemap_cells_radius:PoolVector2Array
var tilemap_astar_disabled_points:Array
var tilemap_astar_points:Array
var tilemap_astar_cells:Array
var tilemap_scan_node

var grid_size = Global.grid_size
var map_width = Global.map_width
var map_height = Global.map_height
var min_width
var stop_width
var rooms_array
var map_void
var map_border

var generator_on:bool = true

const floor_tile_list:Array = [0,0,0,1,2,3,4,5]
const block_tile_list:Array = [0,1,2,3,4,5]
const deco_tile_list:Array = [0,0,0,0,0,0,0,0,0,1,2,3]
const entrance_tile_list:Array = [15]
const exit_tile_list:Array = [14]

const DIRECTION_LIST:Array = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
	]

const DIRECTIONS = {
	UP = Vector2.UP,
	DOWN = Vector2.DOWN,
	LEFT = Vector2.LEFT,
	RIGHT = Vector2.RIGHT
}

enum TILESET_FOG {
	TILE_FULL = 0,
	TILE_HALF = 1,
	TILE_NONE = 2
}

enum TILESET_BASE {
	TILE_FLOOR       = 0,
	TILE_BLOCK       = 1,
#	TILE_DOOR        = 2,
	TILE_DECO        = 3,
#	TILE_DOOR_CLOSED = 2,
#	TILE_DOOR_OPEN   = 3,
#	TILE_EXIT        = 4,
#	TILE_ENTRANCE    = 5,
#	TILE_VENT_CLOSED = 6,
#	TILE_VENT_OPEN   = 7,
	TILE_WALL        = 2
}

enum TILESET_LOGIC {
	TILE_FLOOR       = 0,
	TILE_BLOCK       = 1,
	TILE_DOOR        = 2,
	TILE_DECO        = 3,
#	TILE_DOOR        = 2,
#	TILE_VENT        = 4,
	TILE_EXIT        = 4,
	TILE_ENTRANCE    = 5,
#	TILE_OBJECT      = 7,
	TILE_EMPTY       = 14,
	TILE_VOID        = 15
	}

enum TILESET_ANIMATED {
	ANIMTILE_ASTEROID_0 = 4,
	ANIMTILE_ASTEROID_1 = 5,
	ANIMTILE_ASTEROID_2 = 6
}

# SIGNALS
#---------------------------------------------------------------------------------------
signal fog_update_completed

# READY
#---------------------------------------------------------------------------------------
func _ready():
	randomize()
	pass

# GENERATOR ROOM
#---------------------------------------------------------------------------------------
func generator_room_prepare():
	# Get border cells
	map_border = []
	map_border = get_used_cells_by_id(TILESET_LOGIC.TILE_EMPTY)
	map_void = [] 
	map_void = get_used_cells_by_id(TILESET_LOGIC.TILE_VOID)
	min_width = randi() % 7
	stop_width = min_width + 1
	
	# Generate room (while loop to avoid no tile rooms)
	while generator_on == true:
		generator_room_subdivide(4, 1, map_width - 4, map_height - 2)
		generator_room_clear_dead_doors()
		generator_room_get_rooms()
		generator_room_fill_oneway_rooms(round(rand_range(0,1))as int)
		generator_room_add_arks(round(rand_range(0,3))as int)
		generator_room_clear_final()
		generator_room_add_passage()
	
	# Add content
	generator_room_add_mobs()
	generator_room_add_items()
	
	# Set textures
	tilemap_texture_set_random(Global.LEVEL_LAYER_BASE,TILESET_BASE.TILE_FLOOR,TILESET_LOGIC.TILE_FLOOR,floor_tile_list)
	tilemap_texture_set_random(Global.LEVEL_LAYER_BASE,TILESET_BASE.TILE_BLOCK,TILESET_LOGIC.TILE_BLOCK,block_tile_list)
	tilemap_texture_set_random(Global.LEVEL_LAYER_DECO,TILESET_BASE.TILE_DECO,TILESET_LOGIC.TILE_FLOOR,deco_tile_list)
	tilemap_texture_set_random(Global.LEVEL_LAYER_BASE,TILESET_BASE.TILE_FLOOR,TILESET_LOGIC.TILE_EXIT,exit_tile_list)
	tilemap_texture_set_random(Global.LEVEL_LAYER_BASE,TILESET_BASE.TILE_FLOOR,TILESET_LOGIC.TILE_ENTRANCE,entrance_tile_list)
	tilemap_texture_set_walls(TILESET_BASE.TILE_WALL,[0,1,2,3,4,5])
	pass

func generator_room_subdivide(x1, y1, x2, y2):
	randomize()
	var w = x2 - x1 + 1
	var h = y2 - y1 + 1
	if w >= h and w >= stop_width:
		generator_room_subdivide_width(x1, y1, x2, y2)
	elif h >= stop_width:
		generator_room_subdivide_height(x1, y1, x2, y2)

func generator_room_subdivide_width(x1, y1, x2, y2):
	randomize()
	var x = rand_range(x1 + min_width, x2 - min_width)

	for y in range(y1, y2 + 1):
		set_cell(x, y, TILESET_LOGIC.TILE_BLOCK)

	generator_room_subdivide(x1, y1, x - 1, y2)
	generator_room_subdivide(x + 1, y1, x2, y2)

#	DOORS BY Y
	var doory = rand_range(y1 + 1, y2 - 1)
	set_cell(x, doory, TILESET_LOGIC.TILE_DOOR)
	
#	# Account for walls placed deeper into recursion.
	set_cell(x-1, doory, TILESET_LOGIC.TILE_DOOR)
	set_cell(x+1, doory, TILESET_LOGIC.TILE_DOOR)

func generator_room_subdivide_height(x1, y1, x2, y2):
	randomize()
	var y = rand_range(y1 + min_width, y2 - min_width)

	for x in range(x1, x2 + 1):
		set_cell(x, y, TILESET_LOGIC.TILE_BLOCK)

	generator_room_subdivide(x1, y1, x2, y - 1)
	generator_room_subdivide(x1, y + 1, x2, y2)

#	DOORS BY X
	var doorx = rand_range(x1 + 1, x2 - 1)
	set_cell(doorx, y, TILESET_LOGIC.TILE_DOOR)
	# Account for walls placed deeper into recursion.
	set_cell(doorx, y-1, TILESET_LOGIC.TILE_DOOR)
	set_cell(doorx, y+1, TILESET_LOGIC.TILE_DOOR)

func generator_room_clear_dead_doors():
	var done = false
	while !done:
		done = true
		for cell in get_used_cells_by_id(TILESET_LOGIC.TILE_DOOR):
			if get_cellv(cell) != TILESET_LOGIC.TILE_DOOR: continue
			var count = util_check_nearby_tile_4(cell.x, cell.y, TILESET_LOGIC.TILE_BLOCK)
			if count < 2:
				set_cellv(cell,TILESET_LOGIC.TILE_FLOOR)
				done = false
	pass

func generator_room_clear_dead_walls():
	var done = false
	while !done:
		done = true
		for cell in get_used_cells_by_id(TILESET_LOGIC.TILE_BLOCK):
			if get_cellv(cell) != TILESET_LOGIC.TILE_BLOCK: continue
			var count 
			count = util_check_nearby_tile_4(cell.x, cell.y, TILESET_LOGIC.TILE_FLOOR)
			if count >= 3:
				set_cellv(cell, TILESET_LOGIC.TILE_FLOOR)
				done = false
	pass

func generator_room_clear_final():
	# CLEARS DEADENDS AFTER FILL
	var done = false
	while !done:
		done = true
		for cell in get_used_cells_by_id(TILESET_LOGIC.TILE_DOOR):
			if get_cellv(cell) != TILESET_LOGIC.TILE_DOOR: continue
			var wall_count = util_check_nearby_tile_4(cell.x, cell.y, TILESET_LOGIC.TILE_BLOCK)
			if wall_count >= 3:
				set_cellv(cell, TILESET_LOGIC.TILE_BLOCK)
				done = false
	pass
	
	# CLEARS ALL DOOR TILES, SINCE NOT USED ATM
	for cell in get_used_cells_by_id(TILESET_LOGIC.TILE_DOOR):
		set_cellv(cell,TILESET_LOGIC.TILE_FLOOR)
	
	# ADD WALL ON INNER BORDER
	for cell in map_border:
		set_cellv(cell, TILESET_LOGIC.TILE_BLOCK)
	
	# ADD VOID OUTSIDE BORDER
	for cell in map_void:
		set_cellv(cell, TILESET_LOGIC.TILE_VOID)
	
	# CLEAR ALL BROKEN BITS
	generator_room_get_rooms()
	generator_room_sort_room_vectors(rooms_array)
	for room in rooms_array:
		if room.size() <= 5:
			for cell in room:
				set_cellv(cell,TILESET_LOGIC.TILE_BLOCK)

func generator_room_add_arks(amount:int):
	randomize()

	var doors_array = self.get_used_cells_by_id(TILESET_LOGIC.TILE_DOOR)
	var count:int
	
	if amount > 0 and doors_array.size() != 0:
		for i in amount:
			doors_array.shuffle()
			var door = (doors_array[rand_range(0,doors_array.size())])
#			doors_array.erase(door)
			var cells_to_fill:Array = []
			var cells_to_check:Array = [
				(door),
				(door + Vector2.UP*2),
				(door + Vector2.DOWN*2),
				(door + Vector2.LEFT*2),
				(door + Vector2.RIGHT*2)
			]

			for cell in cells_to_check:
				count = 0
				count += util_check_nearby_tile_4(cell.x, cell.y, TILESET_LOGIC.TILE_BLOCK)
				count += util_check_nearby_tile_4(cell.x, cell.y, TILESET_LOGIC.TILE_VOID)
				count += util_check_nearby_tile_4(cell.x, cell.y, TILESET_LOGIC.TILE_DOOR)
				if count == 2: 
					cells_to_fill.append(cell)
			
				if cells_to_fill.size() >= 2:
					for fill in cells_to_fill: 
						set_cellv(fill, TILESET_LOGIC.TILE_FLOOR)
				else:
					pass

func generator_room_fill_oneway_rooms(amount:int):
	var rooms_oneway_array = []
	var room = []
	var door_count
	
	for i in rooms_array.size():
		door_count = 0
		room = rooms_array[i]
		for cell in room:
			var door = util_check_nearby_tile_4(cell.x, cell.y, TILESET_LOGIC.TILE_DOOR)
			door_count = door_count + door
		if door_count == 1:
			rooms_oneway_array.append(room)
			
	if amount >= 1 and rooms_oneway_array.size() != 0:
		for r in amount:
			room = rooms_oneway_array[r]
			for cell in room:
				set_cell(cell.x, cell.y, TILESET_LOGIC.TILE_BLOCK)
				pass
			pass
		pass
	pass

func generator_room_get_rooms():
	rooms_array = []
	var empty_cells_array = []
	for x in range (0, map_width):
		for y in range (0, map_height):
			if self.get_cell(x, y) == TILESET_LOGIC.TILE_FLOOR:
				generator_room_flood_fill(x,y)
	generator_room_sort_room_vectors(rooms_array)
	empty_cells_array = self.get_used_cells_by_id(TILESET_LOGIC.TILE_EMPTY)
	for empty in empty_cells_array:
		set_cell(empty.x, empty.y, TILESET_LOGIC.TILE_FLOOR)
	pass

func generator_room_add_passage():
	randomize()
	var cell:Vector2
	var room = self.get_used_cells_by_id(TILESET_LOGIC.TILE_FLOOR)
	
	if room != []: 
		generator_on = false
		#ADD ENTRANCE
		room.shuffle()
		cell = (room[rand_range(0,room.size())])
		self.set_cell(cell.x as int,cell.y as int,TILESET_LOGIC.TILE_ENTRANCE)
		room.erase(cell)
		Global.LEVEL_ENTRANCE = cell
				
		#ADD EXIT
		room.shuffle()
		cell = (room[rand_range(0,room.size())])
		self.set_cell(cell.x as int,cell.y as int,TILESET_LOGIC.TILE_EXIT)
		room.erase(cell)
		Global.LEVEL_EXIT = cell
	else:
		return

func generator_room_flood_fill(cell_x,cell_y):
	var room = []
	var to_fill = [Vector2(cell_x, cell_y)]
	while to_fill:
		var tile = to_fill.pop_back()
		if !room.has(tile):
			room.append(tile)
			self.set_cellv(tile, TILESET_LOGIC.TILE_EMPTY)
			#check adjacent cells
			var north = Vector2(tile.x, tile.y-1)
			var south = Vector2(tile.x, tile.y+1)
			var east  = Vector2(tile.x+1, tile.y)
			var west  = Vector2(tile.x-1, tile.y)
			#check adjacent cells
			for dir in [north,south,east,west]:
				if self.get_cellv(dir) == TILESET_LOGIC.TILE_FLOOR:
					if !to_fill.has(dir) and !room.has(dir):
						to_fill.append(dir)
	rooms_array.append(room)
	pass

func generator_room_sort_room_vectors(rooms:Array):
	for room in rooms:
		room.sort()
	return rooms_array

func generator_room_add_mobs():
	var mob_list = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("MOBS").keys()
	var free_cells = self.get_used_cells_by_id(TILESET_LOGIC.TILE_FLOOR)
	var min_mob_count = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("SETTINGS")["MinMobCount"]
	var max_mob_count = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("SETTINGS")["MaxMobCount"]
#	var mob_count  = (round(rand_range(min_mob_count,max_mob_count)))
	var mob_count  = 1
	var mobs_spawned:int = 0
	
	#Exclude cells, to prevent spawn of mobs around entrance
	for direction in Global.DIRECTION_LIST_8:
		var cell = (Global.LEVEL_ENTRANCE) + (direction)
		free_cells.erase(cell)
	
	while mobs_spawned != mob_count:
		randomize()
		var cell = free_cells[randi() % free_cells.size()]
		var mob_type = mob_list[randi() % mob_list.size()]
		var mob_chance = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("MOBS")[mob_type]
		var spawn_chance = util_chance(mob_chance)
		if spawn_chance == true:
			Global.LEVEL.level_mob_spawn(mob_type,cell)
			free_cells.erase(cell)
			mobs_spawned += 1
		if spawn_chance == false:
			pass
	pass

func generator_room_add_items():
	var item_list = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("ITEMS").keys()
	var free_cells = self.get_used_cells_by_id(TILESET_LOGIC.TILE_FLOOR)
	var common_item_count:int = randi() % 3 + 1
	var consumables_item_count:int = randi() % 2
	var weapons_item_count:int = randi() % 2
	var other_item_count:int = randi() % 2
	var items_spawned:int = 0
	
	# Spawn COMMON items
	items_spawned = 0
	item_list = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("ITEMS")["COMMON"].keys()
	while items_spawned != common_item_count:
		randomize()
		var cell = free_cells[randi() % free_cells.size()]
		var item_type = item_list[randi() % item_list.size()]
		var item_chance = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("ITEMS")["COMMON"][item_type]
		var spawn_chance = util_chance(item_chance)
		if spawn_chance == true:
			Global.LEVEL.level_item_spawn(item_type,cell)
			free_cells.erase(cell)
			items_spawned += 1
		if spawn_chance == false:
			pass
	pass
	
	# Spawn CONSUMABLE items
	items_spawned = 0
	item_list = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("ITEMS")["CONSUMABLES"].keys()
	while items_spawned != consumables_item_count:
		randomize()
		var cell = free_cells[randi() % free_cells.size()]
		var item_type = item_list[randi() % item_list.size()]
		var item_chance = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("ITEMS")["CONSUMABLES"][item_type]
		var spawn_chance = util_chance(item_chance)
		if spawn_chance == true:
			Global.LEVEL.level_item_spawn(item_type,cell)
			free_cells.erase(cell)
			items_spawned += 1
		if spawn_chance == false:
			pass
	pass
	
	# Spawn WEAPON items
	items_spawned = 0
	item_list = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("ITEMS")["WEAPONS"].keys()
	while items_spawned != weapons_item_count:
		randomize()
		var cell = free_cells[randi() % free_cells.size()]
		var item_type = item_list[randi() % item_list.size()]
		var item_chance = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("ITEMS")["WEAPONS"][item_type]
		var spawn_chance = util_chance(item_chance)
		if spawn_chance == true:
			Global.LEVEL.level_item_spawn(item_type,cell)
			free_cells.erase(cell)
			items_spawned += 1
		if spawn_chance == false:
			pass
	pass
	
	# Spawn OTHER items
	items_spawned = 0
	item_list = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("ITEMS")["OTHER"].keys()
	while items_spawned != other_item_count:
		randomize()
		var cell = free_cells[randi() % free_cells.size()]
		var item_type = item_list[randi() % item_list.size()]
		var item_chance = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("ITEMS")["OTHER"][item_type]
		var spawn_chance = util_chance(item_chance)
		if spawn_chance == true:
			Global.LEVEL.level_item_spawn(item_type,cell)
			free_cells.erase(cell)
			items_spawned += 1
		if spawn_chance == false:
			pass
	pass

# TEXTURE FUNCTIONS
#---------------------------------------------------------------------------------------
func tilemap_texture_set_walls(tile_base_id:int,tile_list:Array):
	randomize()
	var cell_array:Array
	var cells_to_fill:Array = []
	var tile_array = utility_atlas_get_tiles(tile_base_id,Global.LEVEL_LAYER_BASE)
	cell_array.append_array(self.get_used_cells_by_id(TILESET_LOGIC.TILE_BLOCK))
	
	#CHECK WALL FOR BLOCKS
	for cell in cell_array:
		var cell_to_check = self.get_cellv(cell+Vector2.DOWN)
		if cell_to_check == TILESET_LOGIC.TILE_FLOOR:
			cells_to_fill.append(cell+Vector2.DOWN)
			pass
		pass
	for cell in cells_to_fill:
		var tile = tile_array[randi() % tile_list.size()]
		Global.LEVEL_LAYER_WALL.set_cell(cell.x,cell.y,tile_base_id,false,false,false,tile)
		pass
	pass
	
func tilemap_texture_set_random_animated(tile_base_id:int,tile_list:Array):
	randomize()
	var cell_array = self.get_used_cells_by_id(tile_base_id)
	for cell in cell_array:
		var tile = tile_list[randi() % tile_list.size()]
		Global.LEVEL_LAYER_BASE.set_cell(cell.x,cell.y,tile,false,false,false)
		pass
	pass

func tilemap_texture_set_random(layer_type,tile_base_id:int,tile_logic_id:int,tile_list:Array):
	randomize()
	var cell_array = self.get_used_cells_by_id(tile_logic_id)
	var tile_array = utility_atlas_get_tiles(tile_base_id,Global.LEVEL_LAYER_BASE)
	var tile_array_final = []
	for index in tile_list:
		tile_array_final.append(tile_array[index])
		pass
	pass
	for cell in cell_array:
		var tile = tile_array_final[randi() % tile_array_final.size()]
		layer_type.set_cell(cell.x,cell.y,tile_base_id,false,false,false,tile)
	pass

func utility_atlas_get_tiles(id,layer):
	var tileset = layer.tile_set
	var atlas = tileset.tile_get_region(id)
	var atlas_size_x = atlas.size.x / tileset.autotile_get_size(id).x
	var atlas_size_y = atlas.size.y / tileset.autotile_get_size(id).y
	var atlas_tile_array = []
	for y in range(atlas_size_y):
		for x in range(atlas_size_x):
			var priority = tileset.autotile_get_subtile_priority(id,Vector2(x,y))
			for p in priority:
				atlas_tile_array.append(Vector2(x,y))
	return atlas_tile_array

# ASTAR PATHFINDING
#---------------------------------------------------------------------------------------
func astar_build():
	#Clear astart related variables
	astar_clear()
	#Get all cells to be used in astar pathfiding
	astar_get_cells(TILESET_LOGIC.TILE_FLOOR)
	#Create and connect points with one another
	astar_add_points()
	astar_connect_points()
	#Store list of points for further reference
	tilemap_astar_points = tilemap_astar.get_points()
	tilemap_astar_cells = []
	for i in tilemap_astar_points:
		tilemap_astar.get_point_position(i)
		tilemap_astar_cells.append(tilemap_astar.get_point_position(i))
		pass

func astar_clear():
	tilemap_astar.clear()
	tilemap_astar_cells = []
	tilemap_astar_points = []

func astar_get_cells(id):
	tilemap_astar_cells.append_array(Global.LEVEL_LAYER_LOGIC.get_used_cells_by_id(id))

# Applying unique IDs to empty cells
func astar_add_points():
	for cell in tilemap_astar_cells:
		tilemap_astar.add_point(uuid(cell),cell,1.0)

#Checking neighbour cells in order RIGHT, LEFT, DOWN, UP
func astar_connect_points():
	for cell in tilemap_astar_cells:
		var tilemapAdjacentCells = [Vector2(1,0),Vector2(-1,0),Vector2(0,1),Vector2(0,-1)]
		for check in tilemapAdjacentCells:
			var nextCell = cell + check
			if tilemap_astar_cells.has(nextCell):
				tilemap_astar.connect_points(uuid(cell),uuid(nextCell),false)
	
func astar_find_occupied_points(moving_body_position:Vector2,target_body_position:Vector2):
	var child_count = Global.LEVEL_LAYER_LOGIC.get_child_count()
	var child_exception_list:Array = []
	var child_positions:Array = []
	var disable_points:Array = []
	
	#Enable all of currently disabled points
	astar_enable_points(tilemap_astar_disabled_points)
	
	#Get a list of exceptions by group
	child_exception_list.append_array(astar_get_exceptions(Global.GROUPS.ITEM))
	child_exception_list.append_array(astar_get_exceptions(Global.GROUPS.NONE))
	
	#Find all of the positions that need to be disabled, excluding the moving and target node
	for idx in child_count:
		var child = Global.LEVEL_LAYER_LOGIC.get_child(idx)
		var child_position = (world_to_map(child.get_global_position()))
		if child_position != moving_body_position and child_position != target_body_position and child_exception_list.has(child) == false:
			child_positions.append(child_position)
			
	#Convert positions to astar point ids
	for cell in child_positions:
		var point = tilemap_astar_points[tilemap_astar_cells.find(cell)]
		disable_points.append(point)
		pass
		
	#Store list of disbled points and pass on list of points to disable
	tilemap_astar_disabled_points = disable_points
	astar_disable_points(disable_points)

func astar_disable_points(points_list):
	for point in points_list:
		tilemap_astar.set_point_disabled(point,true)
	pass

func astar_enable_points(points_list): 
	for point in points_list:
		tilemap_astar.set_point_disabled(point,false)
	pass

func astar_get_exceptions(group):
	var child_list:Array = []
	var node_to_scan = Global.LEVEL_LAYER_LOGIC
	var node_to_scan_size:int = node_to_scan.get_child_count()
	for i in node_to_scan_size:
		var node_child = node_to_scan.get_child(i)
		if node_child.is_in_group(group) == true:
			child_list.append(node_child)
	return child_list

#Building a path between two points
func astar_get_path(start,end):
	var tilemap_astar_path
	tilemap_astar_path = tilemap_astar.get_point_path(uuid(start),uuid(end))
	return tilemap_astar_path

# Pairing function for creating unique IDs based on the Vector2 x and y coordinates
func uuid(point:Vector2):
	var a = point.x
	var b = point.y
	return (a + b) * (a + b + 1) / 2 + b

# FOG OF WAR
#---------------------------------------------------------------------------------------
func fog_fill():
	for x in range(0, map_width):
		for y in range(0, map_height):
			Global.LEVEL_LAYER_FOG.set_cell(x, y, TILESET_FOG.TILE_FULL)
	pass

func fog_update():
	var cell_array:Array

	var player = Global.NODE_PLAYER
	var player_position = player.position/grid_size
	
	var visibility_level = Data.LEVEL_DATA[Global.LEVEL_COUNT].get("SETTINGS")["Visibility"]
	var fog_range = min(player.stat_visibility, visibility_level)
	var rect_start = Vector2(player_position.x - fog_range, player_position.y - fog_range)
	var rect_close = Vector2(player_position.x + fog_range, player_position.y + fog_range)
	var rect_width = ((rect_close.x - rect_start.x)+1)
	var rect_height = ((rect_close.y - rect_start.y)+1)
	var rect = Rect2(rect_start,rect_close)
	
	# Add collider exceptions
	get_raycast_exceptions(player.NODE_RAYCAST_FOG,Global.GROUPS.ITEM)
	get_raycast_exceptions(player.NODE_RAYCAST_FOG,Global.GROUPS.KINEMATIC)
	
	get_raycast_exceptions(player.NODE_RAYCAST_MOB,Global.GROUPS.ITEM)
	
	fog_fill()
	
	#FOG SPECIFIC RAYCAST CHECK
	# Prepare cells to check
	cell_array = []
	for x in range(0, rect_width):
		for y in range(0, rect_height):
			var cell = Vector2((rect_start.x + x),(rect_start.y + y))
			cell_array.append(cell)
			
	# Check cells
	for cell in cell_array:
		player.raycast_cast_to(player.NODE_RAYCAST_FOG,player_position,cell)
		if player.NODE_RAYCAST_FOG.is_colliding() == true:
			var raycast_collider = player.NODE_RAYCAST_FOG.get_collider()
			var raycast_collider_point = player.NODE_RAYCAST_FOG.get_collision_point()
			var raycast_collider_position = self.world_to_map(raycast_collider_point)
			if raycast_collider == Global.LEVEL_LAYER_LOGIC:
				Global.LEVEL_LAYER_FOG.set_cell(raycast_collider_position.x, raycast_collider_position.y, TILESET_FOG.TILE_NONE)
		else:
			Global.LEVEL_LAYER_FOG.set_cell(cell.x, cell.y, TILESET_FOG.TILE_NONE)
			
	#MOB SPECIFIC RAYCAST CHECK
	cell_array = []
	rect_start = Vector2(player_position.x - (fog_range+2), player_position.y - (fog_range+2))
	rect_close = Vector2(player_position.x + (fog_range+2), player_position.y + (fog_range+2))
	rect_width = ((rect_close.x - rect_start.x)+2)
	rect_height = ((rect_close.y - rect_start.y)+2)
	
	# Prepare cells to check
	for x in range(0, rect_width):
		for y in range(0, rect_height):
			var cell = Vector2((rect_start.x + x),(rect_start.y + y))
			cell_array.append(cell)
			
	for cell in cell_array:
		player.raycast_cast_to(player.NODE_RAYCAST_MOB,player_position,cell)
		player.NODE_RAYCAST_MOB.force_raycast_update()
		if player.NODE_RAYCAST_MOB.is_colliding() == true:
			var raycast_collider = player.NODE_RAYCAST_MOB.get_collider()
			var raycast_collider_point = player.NODE_RAYCAST_MOB.get_collision_point()
			var raycast_collider_position = self.world_to_map(raycast_collider_point)
			if raycast_collider.is_in_group(Global.GROUPS.HOSTILE) && raycast_collider.AI_state != Global.AI_STATE_LIST.STATE_WANDER:
				raycast_collider.AI_state = Global.AI_STATE_LIST.STATE_ENGAGE
				player.NODE_RAYCAST_MOB.add_exception(raycast_collider)
		else:
			pass
	
	player.NODE_RAYCAST_FOG.clear_exceptions()
	player.NODE_RAYCAST_MOB.clear_exceptions()
	emit_signal("fog_update_completed")

# UTILITY FUNCTIONS
#---------------------------------------------------------------------------------------
func util_check_diagonal_tile_4(x, y, tile_id):
	var count = 0
	if self.get_cell(x+1, y+1) == tile_id:  count += 1
	if self.get_cell(x+1, y-1) == tile_id:  count += 1
	if self.get_cell(x-1, y+1) == tile_id:  count += 1
	if self.get_cell(x-1, y-1) == tile_id:  count += 1
	return count

func util_check_nearby_tile_4(x, y, tile_id):
	var count = 0
	if self.get_cell(x, y-1)   == tile_id:  count += 1
	if self.get_cell(x, y+1)   == tile_id:  count += 1
	if self.get_cell(x-1, y)   == tile_id:  count += 1
	if self.get_cell(x+1, y)   == tile_id:  count += 1
	return count

func util_check_nearby_tile_8(x, y, tile_id):
	var count = 0
	if self.get_cell(x, y-1)   == tile_id:  count += 1
	if self.get_cell(x, y+1)   == tile_id:  count += 1
	if self.get_cell(x-1, y)   == tile_id:  count += 1
	if self.get_cell(x+1, y)   == tile_id:  count += 1
	if self.get_cell(x+1, y+1) == tile_id:  count += 1
	if self.get_cell(x+1, y-1) == tile_id:  count += 1
	if self.get_cell(x-1, y+1) == tile_id:  count += 1
	if self.get_cell(x-1, y-1) == tile_id:  count += 1
	return count

func util_get_occupied_cells():
	var occupied_cells = []
	for idx in self.get_child_count():
		var child = Global.LEVEL_LAYER_LOGIC.get_child(idx)
		var child_position = (world_to_map(child.get_global_position()))
		if child.is_in_group(Global.GROUPS.HOSTILE) or child.is_in_group(Global.GROUPS.PLAYER):
			occupied_cells.append(child_position)
	return occupied_cells

func util_get_free_fog_cells():
	var fog_cells_free = []
	var fog_cells = Global.LEVEL_LAYER_FOG.get_used_cells_by_id(TILESET_FOG.TILE_FULL)
	var occupied_cells = util_get_occupied_cells()
	for cell in fog_cells:
		var cell_to_check = Global.LEVEL_LAYER_LOGIC.get_cellv(cell)
		if cell_to_check == TILESET_BASE.TILE_FLOOR and occupied_cells.has(cell) == false:
			fog_cells_free.append(cell)
	return fog_cells_free

func util_chance(percentage):
	randomize()
	if percentage == 0:
		return false
	elif randi() % 100 <= percentage:  
		return true
	else:                     
		return false

func get_raycast_exceptions(raycast,group):
	var node_to_scan = Global.LEVEL_LAYER_LOGIC
	var node_to_scan_size:int = node_to_scan.get_child_count()
	for i in node_to_scan_size:
		var node_child = node_to_scan.get_child(i)
		if node_child.is_in_group(group) == true:
			raycast.add_exception(node_child)
	pass
