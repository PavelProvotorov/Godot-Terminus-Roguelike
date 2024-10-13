extends Node

onready var DEBUG_LABEL = preload("res://scenes/DebugLabel.tscn")

onready var TILEMAP_LOGIC = $Logic
onready var TILEMAP_DEBUG = $Debug

onready var MAP_WIDTH = TILEMAP_LOGIC.get_used_rect().size.x
onready var MAP_HEIGHT = TILEMAP_LOGIC.get_used_rect().size.y
onready var MIN_ROOM_SIZE = 2
onready var MIN_SPLIT_SIZE = MIN_ROOM_SIZE * 2 + 1

onready var TILES_LOGIC = {
	EMPTY = TILEMAP_LOGIC.tile_set.find_tile_by_name("TILE_EMPTY"),
	FLOOR = TILEMAP_LOGIC.tile_set.find_tile_by_name("TILE_FLOOR"),
	WALL = TILEMAP_LOGIC.tile_set.find_tile_by_name("TILE_WALL"),
	DOOR = TILEMAP_LOGIC.tile_set.find_tile_by_name("TILE_DOOR")
	}

onready var DIRECTIONS = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
]

func _ready():
	randomize()
	debug_add_cell_positions(TILEMAP_LOGIC.get_used_cells())
	generator_start()
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_space"):
		generator_start()
	pass

func generator_start():
	randomize()
	generator_clear_level()
	generator_room_subdivide(1, 1, MAP_WIDTH - 2, MAP_HEIGHT - 2)
	generator_clear_dead_ends(TILEMAP_LOGIC, [TILES_LOGIC.DOOR, TILES_LOGIC.WALL], TILES_LOGIC.EMPTY, TILES_LOGIC.EMPTY)
	generator_fill_one_way_rooms(TILEMAP_LOGIC, TILES_LOGIC.EMPTY, TILES_LOGIC.WALL)
	generator_remove_room_walls(TILEMAP_LOGIC, [TILES_LOGIC.WALL, TILES_LOGIC.DOOR])
	debug_print_rooms()

func generator_room_subdivide(x1, y1, x2, y2):
	randomize()
	var w = x2 - x1 + 1
	var h = y2 - y1 + 1
	
	if randf() < 0.5:
		if w >= MIN_SPLIT_SIZE:
			generator_room_subdivide_width(x1, y1, x2, y2)
		elif h >= MIN_SPLIT_SIZE:
			generator_room_subdivide_height(x1, y1, x2, y2)
	else:
		if h >= MIN_SPLIT_SIZE:
			generator_room_subdivide_height(x1, y1, x2, y2)
		elif w >= MIN_SPLIT_SIZE:
			generator_room_subdivide_width(x1, y1, x2, y2)

func generator_room_subdivide_width(x1, y1, x2, y2):
	randomize()
	var x = rand_range(x1 + MIN_ROOM_SIZE, x2 - MIN_ROOM_SIZE)

	for y in range(y1, y2 + 1):
		TILEMAP_LOGIC.set_cell(x, y, TILES_LOGIC.WALL)

	generator_room_subdivide(x1, y1, x - 1, y2)
	generator_room_subdivide(x + 1, y1, x2, y2)

	var doory = rand_range(y1 + 1, y2 - 1)
	TILEMAP_LOGIC.set_cell(x, doory, TILES_LOGIC.DOOR)

	# Account for walls placed deeper into recursion.
	TILEMAP_LOGIC.set_cell(x-1, doory, TILES_LOGIC.EMPTY)
	TILEMAP_LOGIC.set_cell(x+1, doory, TILES_LOGIC.EMPTY)

func generator_room_subdivide_height(x1, y1, x2, y2):
	randomize()
	var y = rand_range(y1 + MIN_ROOM_SIZE, y2 - MIN_ROOM_SIZE)

	for x in range(x1, x2 + 1):
		TILEMAP_LOGIC.set_cell(x, y, TILES_LOGIC.WALL)

	generator_room_subdivide(x1, y1, x2, y - 1)
	generator_room_subdivide(x1, y + 1, x2, y2)

	var doorx = rand_range(x1 + 1, x2 - 1)
	TILEMAP_LOGIC.set_cell(doorx, y, TILES_LOGIC.DOOR)
	
	# Account for walls placed deeper into recursion.
	TILEMAP_LOGIC.set_cell(doorx, y-1, TILES_LOGIC.EMPTY)
	TILEMAP_LOGIC.set_cell(doorx, y+1, TILES_LOGIC.EMPTY)

func generator_clear_dead_ends(tilemap:TileMap, ids:Array, check_tile:int, set_tile:int):
	var completed = false

	while !completed:
		completed = true
		var cells = tilemap_get_cells_in_array(tilemap, ids)

		for cell in cells:
			var count = util_count_nearby_tile_4(cell.x, cell.y, check_tile)
			if count >= 3:
				tilemap.set_cellv(cell, set_tile)
				completed = false
			pass
	pass

func generator_remove_room_walls(tilemap:TileMap, tiles:Array) -> void:
	randomize()
	var walls:Array = generator_get_room_walls(tilemap, tiles)
	walls.shuffle()
	
	var cells = []
	for i in (randi() % 3 + 1):
		if walls.size() != 0:
			var wall = walls.pick_random()
			cells.append_array(wall)
			walls.erase(wall)
	
	for cell in cells:
		tilemap.set_cellv(cell, TILES_LOGIC.EMPTY)
	
	generator_clear_dead_ends(TILEMAP_LOGIC, [TILES_LOGIC.DOOR, TILES_LOGIC.WALL], TILES_LOGIC.EMPTY, TILES_LOGIC.EMPTY)
	pass

func generator_get_room_walls(tilemap: TileMap, tiles:Array) -> Array:
	var walls = []
	var visited = []
	
	for x in range(0, MAP_WIDTH):
		for y in range(0, MAP_HEIGHT):
			
			var cell = Vector2(x, y)
			if tilemap.get_cellv(cell) in tiles and !visited.has(cell) and util_count_nearby_tile_4(cell.x, cell.y, TILES_LOGIC.EMPTY) >= 2:
				var wall = generator_wall_flood_fill(tilemap, tiles, cell, visited)
				if wall.size() > 0:
					walls.append(wall)
	return walls

func generator_wall_flood_fill(tilemap:TileMap, tiles:Array, start_cell:Vector2, visited:Array):
	var wall = []
	var stack = [start_cell]
	
	while stack:
		var cell = stack.pop_back()
		
		if !visited.has(cell) and tilemap.get_cellv(cell) in tiles:
			visited.append(cell)
			if util_count_nearby_tile_4(cell.x, cell.y, TILES_LOGIC.EMPTY) >= 2:
				wall.append(cell)
			
			for direction in DIRECTIONS:
				var neighbor = cell + direction
				if !visited.has(neighbor) and tilemap.get_cellv(neighbor) in tiles:
					if util_count_nearby_tile_4(neighbor.x, neighbor.y, TILES_LOGIC.EMPTY) >= 2:
						stack.append(neighbor)
	return wall

func generator_room_apply_padding(room:Array) -> Array:
	var result = []
	for cell in room:
		var count = 0
		count += util_count_nearby_tile_4(cell.x, cell.y, TILES_LOGIC.WALL)
		count += util_count_nearby_tile_4(cell.x, cell.y, TILES_LOGIC.DOOR)
		if count == 0:
			result.append(cell)
			
	return result

func generator_get_rooms(tilemap: TileMap, tile:int):
	var rooms = []
	var visited = []
	
	for x in range(0, MAP_WIDTH):
		for y in range(0, MAP_HEIGHT):
			
			var cell = Vector2(x, y)
			if tilemap.get_cellv(cell) == tile and !visited.has(cell):
				var room = generator_room_flood_fill(tilemap, tile, cell, visited)
				if room.size() > 0:
					rooms.append(room)
	return rooms

func generator_room_flood_fill(tilemap:TileMap, tile:int, start_cell:Vector2, visited:Array):
	var room = []
	var stack = [start_cell]
	
	while stack:
		var cell = stack.pop_back()
		
		if !visited.has(cell) and tilemap.get_cellv(cell) == tile:
			visited.append(cell)
			room.append(cell)
			
			for direction in DIRECTIONS:
				var neighbor = cell + direction
				if !visited.has(neighbor) and tilemap.get_cellv(neighbor) == tile:
					stack.append(neighbor)
	return room

func generator_fill_one_way_rooms(tilemap:TileMap, tile_check:int, tile_fill:int) -> void:
	var rooms = generator_get_rooms(tilemap, tile_check)
	rooms = generator_get_one_way_rooms(rooms.duplicate())
	
	for room in rooms:
		for cell in room:
			tilemap.set_cellv(cell, tile_fill)
	pass

func generator_get_one_way_rooms(rooms:Array) -> Array:
	var output:Array = []
	var door_list:Array = []
	
	for room in rooms:
		door_list = []
		
		for cell in room:
			door_list.append_array(util_get_nearby_tile_4(cell.x, cell.y, TILES_LOGIC.DOOR))
		
		if door_list.size() == 1:
			var duplicate = room.duplicate(true)
			duplicate.append_array(door_list)
			output.append(duplicate)
			
	return output

func generator_clear_level() -> void:
	var rect = TILEMAP_LOGIC.get_used_rect()
	var rect_start = Vector2(rect.position.x + 1, rect.position.y + 1)
	var rect_end = Vector2(rect.end.x - 2, rect.end.y - 2)
	
	for width in range(int(rect_start.x), int(rect_end.x) + 1):
		for height in range(int(rect_start.y), int(rect_end.y) + 1):
			TILEMAP_LOGIC.set_cell(width, height, TILES_LOGIC.EMPTY)
	pass

func furnisher_find_free_space(cells: Array, object_size: Vector2) -> Array:
	var result = []
	for cell in cells:
		if furnisher_space_is_free(cells, cell, object_size):
			result.append(cell)
	return result

func furnisher_space_is_free(cells: Array, cell: Vector2, object_size: Vector2) -> bool:
	for x in range(object_size.x):
		for y in range(object_size.y):
			var check_cell = cell + Vector2(x, y)
			if !cells.has(check_cell):
				return false
	return true
	
func util_count_nearby_tile_4(x:int, y:int, tile_id:int) -> int:
	var count:int = 0
	if TILEMAP_LOGIC.get_cell(x, y-1)   == tile_id:  count += 1
	if TILEMAP_LOGIC.get_cell(x, y+1)   == tile_id:  count += 1
	if TILEMAP_LOGIC.get_cell(x-1, y)   == tile_id:  count += 1
	if TILEMAP_LOGIC.get_cell(x+1, y)   == tile_id:  count += 1
	return count

func util_get_nearby_tile_4(x:int, y:int, tile_id:int) -> Array:
	var list:Array = []
	if TILEMAP_LOGIC.get_cell(x, y-1)   == tile_id:  list.append(Vector2(x, y-1))
	if TILEMAP_LOGIC.get_cell(x, y+1)   == tile_id:  list.append(Vector2(x, y+1))
	if TILEMAP_LOGIC.get_cell(x-1, y)   == tile_id:  list.append(Vector2(x-1, y))
	if TILEMAP_LOGIC.get_cell(x+1, y)   == tile_id:  list.append(Vector2(x+1, y))
	return list

func tilemap_get_cells_in_array(tilemap:TileMap, ids:Array) -> Array:
	var cells = []
	for id in ids:
		cells.append_array(tilemap.get_used_cells_by_id(id))
	return cells

func debug_print_rooms() -> void:
	print("---------------------")
	var rooms = generator_get_rooms(TILEMAP_LOGIC, TILES_LOGIC.EMPTY)
	for room in rooms.size():
		print(room, ": ", rooms[room])
	pass 

func debug_add_cell_positions(cells:PoolVector2Array) -> void:
	for cell in cells:
		var label = DEBUG_LABEL.instance()
		label.text = str(cell)
		label.set_position(TILEMAP_DEBUG.map_to_world(cell))
		TILEMAP_DEBUG.add_child(label)
	pass
