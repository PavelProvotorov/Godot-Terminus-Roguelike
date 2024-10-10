extends Node

onready var DEBUG_LABEL = preload("res://scenes/DebugLabel.tscn")

onready var TILEMAP_LOGIC = $Logic
onready var TILEMAP_DEBUG = $Debug

onready var MAP_WIDTH = TILEMAP_LOGIC.get_used_rect().size.x
onready var MAP_HEIGHT = TILEMAP_LOGIC.get_used_rect().size.y
onready var LEVEL_ROOMS:Array = []
onready var min_room_size = 2
onready var min_split_size = min_room_size * 2 + 1

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
	debug_add_cell_positions(TILEMAP_LOGIC.get_used_cells())
	generator_start()
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_space"):
		generator_start()
	pass

func generator_start():
	generator_clear_level()
	generator_room_subdivide(1, 1, MAP_WIDTH - 2, MAP_HEIGHT - 2)
	generator_clear_dead_ends(TILEMAP_LOGIC, [TILES_LOGIC.DOOR, TILES_LOGIC.WALL], TILES_LOGIC.EMPTY, TILES_LOGIC.EMPTY)
	LEVEL_ROOMS = generator_get_rooms(TILEMAP_LOGIC, TILES_LOGIC.EMPTY)
	debug_print_rooms(LEVEL_ROOMS)
	pass

func generator_room_subdivide(x1, y1, x2, y2):
	randomize()
	var w = x2 - x1 + 1
	var h = y2 - y1 + 1
	
	if randf() < 0.5:
		if w >= min_split_size:
			generator_room_subdivide_width(x1, y1, x2, y2)
		elif h >= min_split_size:
			generator_room_subdivide_height(x1, y1, x2, y2)
	else:
		if h >= min_split_size:
			generator_room_subdivide_height(x1, y1, x2, y2)
		elif w >= min_split_size:
			generator_room_subdivide_width(x1, y1, x2, y2)

func generator_room_subdivide_width(x1, y1, x2, y2):
	randomize()
	var x = rand_range(x1 + min_room_size, x2 - min_room_size)

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
	var y = rand_range(y1 + min_room_size, y2 - min_room_size)

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
			var count = util_check_nearby_tile_4(cell.x, cell.y, check_tile)
			if count >= 3:
				tilemap.set_cellv(cell, set_tile)
				completed = false
			pass
	pass

func generator_get_rooms(tilemap: TileMap, tile:int):
	var rooms = []
	var visited = []
	
	for x in range(0, MAP_WIDTH):
		for y in range(0, MAP_HEIGHT):
			
			var cell = Vector2(x, y)
			if tilemap.get_cellv(cell) == TILES_LOGIC.EMPTY and !visited.has(cell):
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

func generator_clear_level():
	var rect = TILEMAP_LOGIC.get_used_rect()
	var rect_start = Vector2(rect.position.x + 1, rect.position.y + 1)
	var rect_end = Vector2(rect.end.x - 2, rect.end.y - 2)
	
	for width in range(int(rect_start.x), int(rect_end.x) + 1):
		for height in range(int(rect_start.y), int(rect_end.y) + 1):
			TILEMAP_LOGIC.set_cell(width, height, TILES_LOGIC.EMPTY)
	pass

func util_check_nearby_tile_4(x, y, tile_id):
	var count: int = 0
	if TILEMAP_LOGIC.get_cell(x, y-1)   == tile_id:  count += 1
	if TILEMAP_LOGIC.get_cell(x, y+1)   == tile_id:  count += 1
	if TILEMAP_LOGIC.get_cell(x-1, y)   == tile_id:  count += 1
	if TILEMAP_LOGIC.get_cell(x+1, y)   == tile_id:  count += 1
	return count

func tilemap_get_cells_in_array(tilemap:TileMap, ids:Array):
	var cells = []
	for id in ids:
		cells.append_array(tilemap.get_used_cells_by_id(id))
	return cells

func debug_print_rooms(rooms:Array):
	for room in rooms.size():
		print(room, ": ", rooms[room])
	pass 

func debug_add_cell_positions(cells:PoolVector2Array):
	for cell in cells:
		var label = DEBUG_LABEL.instance()
		label.text = str(cell)
		label.set_position(TILEMAP_DEBUG.map_to_world(cell))
		TILEMAP_DEBUG.add_child(label)
	pass
