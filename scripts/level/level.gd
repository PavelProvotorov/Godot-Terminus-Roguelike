extends Node2D

onready var _tree:SceneTree = get_tree()
onready var _tilemap_logic:TileMap = $Logic
onready var _tilemap_debug:TileMap = $Debug
onready var _tilemap_decor:TileMap = $Decor
onready var _tilemap_debris:TileMap = $Debris
onready var _tilemap_base:TileMap = $Base
onready var _tilemap_fog:TileMap = $Fog
onready var level_rect = _tilemap_logic.get_used_rect()

onready var TILES = {
	EMPTY = _tilemap_logic.tile_set.find_tile_by_name("TILE_EMPTY"),
	FLOOR = _tilemap_logic.tile_set.find_tile_by_name("TILE_FLOOR"),
	WALL = _tilemap_logic.tile_set.find_tile_by_name("TILE_WALL"),
	DOOR = _tilemap_logic.tile_set.find_tile_by_name("TILE_DOOR"),
	OBJECT = _tilemap_logic.tile_set.find_tile_by_name("TILE_OBJECT"),
	ENTRANCE = _tilemap_logic.tile_set.find_tile_by_name("TILE_ENTRANCE"),
	EXIT = _tilemap_logic.tile_set.find_tile_by_name("TILE_EXIT"),
	FOG = _tilemap_fog.tile_set.find_tile_by_name("TILE_FOG")
	}

onready var _queue:Queue
var _shadowcasting:ShadowCasting2D
var _pathfinding:PathFinding2D
var _generator:Generator2D
var _decorator:Decorator2D

var point_radius = 3
var scale_multiplier = 8
var offset = Vector2(4,4)
var enabled_point_color = Color('00ff00')
var disabled_point_color = Color('ff0000')
var line_color = Color('0000ff')
var line_width = 1

func _ready():
	randomize()
	Events.connect("enemy_died", self, "_on_enemy_death")
	Events.connect("enemy_spawned", self, "_on_enemy_spawned")
	Events.connect("enemy_moved", self, "_on_enemy_moved")
	Events.connect("player_moved", self, "_on_player_moved")
	Events.connect("level_door_open", self, "_on_level_door_open")
	Events.connect("end_turn", self, "_on_end_turn")
	
	add_player()
	generate_level()
	add_enemies()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_read"):
		generate_level()
	pass
	
func _draw():
	for point in _pathfinding._astar.get_points():
		
		for other in _pathfinding._astar.get_point_connections(point):
			draw_line(_point_pos(point), _point_pos(other), line_color, line_width)
			
		var point_color = disabled_point_color if _pathfinding._astar.is_point_disabled(point) else enabled_point_color
		draw_circle(_point_pos(point), point_radius, point_color)

func _point_pos(id):
	return offset + _pathfinding._astar.get_point_position(id) * scale_multiplier

func generate_level():
	_generator = Generator2D.new(
		_tilemap_logic
	)
	
	_decorator = Decorator2D.new(
		_tilemap_decor,
		_tilemap_base,
		_tilemap_debris
	)
	
	_pathfinding = PathFinding2D.new(
		tilemap_get_cells_in_array(_tilemap_logic, [
			TILES.ENTRANCE,
			TILES.FLOOR,
			TILES.EXIT,
			TILES.DOOR
		])
	)
	_pathfinding.disable_points(_tilemap_logic.get_used_cells_by_id(TILES.DOOR))

	_decorator.decorate_level({
		"TILE_FLOOR": _tilemap_logic.get_used_cells_by_id(TILES.FLOOR),
		"TILE_WALL": _tilemap_logic.get_used_cells_by_id(TILES.WALL),
		"TILE_ENTRANCE": _tilemap_logic.get_used_cells_by_id(TILES.ENTRANCE),
		"TILE_EXIT": _tilemap_logic.get_used_cells_by_id(TILES.EXIT),
		"TILE_BASE": _generator.generator_get_walls_base(),
		"TILE_DEBRIS": _tilemap_logic.get_used_cells_by_id(TILES.FLOOR),
		"TILE_DOOR_CLOSED": _tilemap_logic.get_used_cells_by_id(TILES.DOOR),
		"TILE_OBJECT_BIG": _generator.object_big_cells,
		"TILE_OBJECT_SMALL": _generator.object_small_cells
	})
	
	_shadowcasting = ShadowCasting2D.new(
		_tilemap_logic,
		_tilemap_fog,
		[TILES.WALL, TILES.DOOR],
		TILES.FLOOR,
		TILES.FOG
	)
	
	_queue = Queue.new(
		_tilemap_logic,
		_tree
	)
	
	Events.emit_signal(
		"level_generation_complete", 
		_tilemap_logic.map_to_world(_generator.generator_get_entrance())
	)

func add_player():
	var player = Resources.debug_player.instance()
	player.set_position(Vector2(0, 0))
	_tilemap_logic.add_child(player)

func add_enemies():
	var free_cells = _tilemap_logic.get_used_cells_by_id(TILES.FLOOR)
	for idx in range(3):
		var cell = free_cells.pick_random()
		free_cells.erase(cell)
		
		var enemy = Resources.debug_grunt.instance()
		enemy.set_position(_tilemap_logic.map_to_world(cell))
		_tilemap_logic.add_child(enemy)
		_pathfinding.disable_points([
			_tilemap_logic.world_to_map(cell * 8)
		])
		
func spawn_enemy(pos:Vector2, enemy:KinematicBody2D) -> void:
	enemy.set_position(_tilemap_logic.map_to_world(pos))
	_tilemap_logic.add_child(enemy)

func get_tile_position_name(pos:Vector2) -> String:
	var pos_tilemap = _tilemap_logic.world_to_map(pos)
	return TILES.find_key(_tilemap_logic.get_cellv(pos_tilemap))

func tilemap_get_cells_in_array(tilemap:TileMap, ids:Array) -> Array:
	var cells = []
	for id in ids:
		cells.append_array(tilemap.get_used_cells_by_id(id))
	return cells

func _on_level_door_open(entity_pos:Vector2, door_pos:Vector2, distance:int) -> void:
	var entity_pos_tilemap = _tilemap_logic.world_to_map(entity_pos)
	var door_pos_tilemap = _tilemap_logic.world_to_map(door_pos)
	
	_tilemap_logic.set_cellv(door_pos_tilemap, TILES.FLOOR)
	_decorator.update_decoration('TILE_DOOR_OPEN', [door_pos_tilemap])
	_pathfinding.enable_points([door_pos_tilemap])
	_shadowcasting.update(entity_pos_tilemap, distance)
	
func find_path(start:Vector2, end:Vector2) -> Array:
	return _pathfinding.get_path(
		_tilemap_logic.world_to_map(start),
		_tilemap_logic.world_to_map(end)
	)

func is_fog_cell(cell:Vector2) -> bool:
	return _tilemap_fog.get_cellv(cell) == TILES.FOG
	
func _on_player_moved(pos:Vector2, distance:int) -> void:
	var pos_tilemap = _tilemap_logic.world_to_map(pos)
#	print("Player moved: ", pos_tilemap, " > ", distance)
	var cells = _shadowcasting.update(pos_tilemap, distance)
	Events.emit_signal("level_fog_updated", cells)

func _on_enemy_moved(prev_pos:Vector2, new_pos:Vector2) -> void:
	_pathfinding.disable_points([
		_tilemap_logic.world_to_map(new_pos)
	])
	_pathfinding.enable_points([
		_tilemap_logic.world_to_map(prev_pos)
	])
	update()
	
func _on_enemy_spawned(pos:Vector2) -> void:
	_pathfinding.disable_points([
		_tilemap_logic.world_to_map(pos)
	])
	update()

func _on_enemy_death(node:Node2D, pos:Vector2) -> void:
	_pathfinding.enable_points([
		_tilemap_logic.world_to_map(pos)
	])
	update()

func _on_end_turn(node:Node) -> void:
	print("----------------------------------")
	print("Turn Ended By: ", node)
	_queue.process(_tree, node)
