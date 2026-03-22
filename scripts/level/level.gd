extends Node2D
class_name Level

onready var _tree:SceneTree = get_tree()
onready var _tilemap_logic:TileMap = $Logic
onready var _tilemap_debug:TileMap = $Debug
onready var _tilemap_decor:TileMap = $Decor
onready var _tilemap_debris:TileMap = $Debris
onready var _tilemap_base:TileMap = $Base
onready var _tilemap_fog:TileMap = $Fog
onready var _audio:Audio2D = Audio2D.new()
onready var level_rect = _tilemap_logic.get_used_rect()
onready var _utility:Utility = Utility.new()

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

var _shadowcasting:LevelShadowcasting
var _furnisher:LevelFurnisher
var _pathfinding:PathFinding2D
var _generator:Generator2D
var _decorator:Decorator2D

var point_radius = 3
var grid_size:int = 8
var light_level:int = 5
var scale_multiplier = 8
var offset = Vector2(4,4)
var enabled_point_color = Color('00ff00')
var disabled_point_color = Color('ff0000')
var line_color = Color('0000ff')
var line_width = 1
var furniture:Array = []

func _init():
	Global.set_level(self)

func _ready():
	randomize()
	Events.connect("player_moved", self, "_on_player_moved")
	
func _draw():
	for point in _pathfinding._astar.get_points():
		
		for other in _pathfinding._astar.get_point_connections(point):
			draw_line(_point_pos(point), _point_pos(other), line_color, line_width)
			
		var point_color = disabled_point_color if _pathfinding._astar.is_point_disabled(point) else enabled_point_color
		draw_circle(_point_pos(point), point_radius, point_color)

func _point_pos(id):
	return offset + _pathfinding._astar.get_point_position(id) * scale_multiplier

func set_tileset(tileset:TileSet) -> void:
	_tilemap_decor.set_tileset(tileset)
	_tilemap_debris.set_tileset(tileset)
	_tilemap_base.set_tileset(tileset)

func generate_level():
	_generator = Generator2D.new(
		_tilemap_logic,
		furniture
	)
	
	_decorator = Decorator2D.new(
		_tilemap_decor,
		_tilemap_base,
		_tilemap_debris
	)
	
	_furnisher = LevelFurnisher.new(
		_tilemap_logic,
		furniture,
		TILES
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
	
	var floor_tiles:Array = []
	floor_tiles.append_array(_tilemap_logic.get_used_cells_by_id(TILES.FLOOR))
	floor_tiles.append_array(_tilemap_logic.get_used_cells_by_id(TILES.OBJECT))
	_decorator.decorate_level({
		"TILE_FLOOR": floor_tiles,
		"TILE_WALL": _tilemap_logic.get_used_cells_by_id(TILES.WALL),
		"TILE_ENTRANCE": _tilemap_logic.get_used_cells_by_id(TILES.ENTRANCE),
		"TILE_EXIT": _tilemap_logic.get_used_cells_by_id(TILES.EXIT),
		"TILE_BASE": _generator.generator_get_walls_base(),
		"TILE_DEBRIS": _tilemap_logic.get_used_cells_by_id(TILES.FLOOR),
		"TILE_DOOR_CLOSED": _tilemap_logic.get_used_cells_by_id(TILES.DOOR),
	})
	
	_shadowcasting = LevelShadowcasting.new(
		_tilemap_fog,
		funcref(self, 'is_tile_blocking')
	)
	
	populate_level()
	
	print("----------------------------------")
	print("LEVEL GENERATION COMPLETE")
	Events.emit_signal("level_generation_complete", self)
	_tilemap_logic.process_queue()

func populate_level():
	var current_depth = Global.get_depth()
	add_entities(Resources.level_configuration.get(current_depth))

func add_player() -> void:
	var player = Global.get_player()
	player.set_position(Vector2(0, 0))
	_tilemap_logic.add_child(player)
	
func add_entities(entities:Dictionary) -> void:
	var free_cells = get_floor_cells()
	add_player()
	add_enemies(entities.get('enemies', {}), 10, 15, free_cells)
	add_items(entities.get('items', {}), 3, 5, free_cells)
	app_weapons(entities.get('weapons', {}), 0, 1, free_cells)

func add_enemies(enemy_list: Dictionary, min_count:int, max_count:int, free_cells:Array) -> void:
	var enemies_count = rand_range(min_count, max_count)
	var entrance:Vector2 = get_entrance() / grid_size
	var safe_distance:int = 4
	var enemies_added:int = 0
	
	if enemy_list.size() <= 0:
		return
	
	while enemies_added < enemies_count and free_cells.size() > 0:
		
		var cell = free_cells.pick_random()
		
		if cell.distance_to(entrance) < safe_distance:
			free_cells.erase(cell)
			continue
		
		var enemy = enemy_list.keys()[randi() % enemy_list.size()]
			
		if get_spawn_chance(enemy_list.get(enemy)):
			
			var enemy_res = load("res://scenes/mobs/%s.tscn" % enemy)
			var enemy_instance = enemy_res.instance()
			
			spawn_enemy(cell, enemy_instance)
			free_cells.erase(cell)
			enemies_added += 1

func add_items(item_list: Dictionary, min_count:int, max_count:int, free_cells:Array) -> void:
	var items_count = rand_range(min_count, max_count)
	var items_added = 0
	
	if item_list.size() <= 0:
		return
	
	while items_added < items_count and free_cells.size() > 0:
		
		var cell = free_cells.pick_random()
		var item = item_list.keys()[randi() % item_list.size()]
			
		if get_spawn_chance(item_list.get(item)):
			
			var item_res = load("res://scenes/items/%s.tscn" % item)
			var item_instance:Item = item_res.instance()
			
			spawn_item(cell, item_instance)
			free_cells.erase(cell)
			items_added += 1

func app_weapons(weapon_list: Dictionary, min_count:int, max_count:int, free_cells:Array) -> void:
	var weapons_count = rand_range(min_count, max_count)
	var weapons_added = 0
	
	if weapon_list.size() <= 0:
		return
	
	while weapons_added < weapons_count and free_cells.size() > 0:
		
		var cell = free_cells.pick_random()
		var weapon = weapon_list.keys()[randi() % weapon_list.size()]
			
		if get_spawn_chance(weapon_list.get(weapon)):
			
			var weapon_res = load("res://scenes/weapons/%s.tscn" % weapon)
			var weapon_instance:Weapon = weapon_res.instance()
			
			spawn_item(cell, weapon_instance)
			free_cells.erase(cell)
			weapons_added += 1
	
func spawn_enemy(pos:Vector2, enemy:KinematicBody2D) -> void:
	enemy.set_position(_tilemap_logic.map_to_world(pos))
	_tilemap_logic.add_child(enemy)
	_pathfinding.disable_points([
		_tilemap_logic.world_to_map(pos * 8)
	])
	update()
	
func spawn_item(pos:Vector2, item:Control) -> void:
	item.set_position(_tilemap_logic.map_to_world(pos))
	_tilemap_logic.add_child(item)

func get_floor_cells() -> Array:
	return _tilemap_logic.get_used_cells_by_id(TILES.FLOOR)
	
func get_free_cells() -> Array:
	var free_cells = []
	free_cells.append_array(_tilemap_logic.get_used_cells_by_id(TILES.FLOOR))
	free_cells.append_array(_tilemap_logic.get_used_cells_by_id(TILES.ENTRANCE))
	free_cells.append_array(_tilemap_logic.get_used_cells_by_id(TILES.EXIT))
	var entities = get_tree().get_nodes_in_group("ENTITY")
	var entities_positions = []
	for entity in entities:
		entities_positions.append(entity.position / 8)
	return get_array_difference(free_cells, entities_positions)

func get_door_cells() -> Array:
	return _tilemap_logic.get_used_cells_by_id(TILES.DOOR)
	
func get_hidden_free_cells() -> Array:
	var free_cells:Array = get_free_cells()
	var hidden_cells:Array = []
	
	for cell in free_cells:
		var hidden = (_tilemap_fog.get_cellv(cell) == TILES.FOG)
		if hidden: hidden_cells.append(cell)
		
	return hidden_cells

func get_tile_position_name(pos:Vector2) -> String:
	var pos_tilemap = _tilemap_logic.world_to_map(pos)
	return TILES.find_key(_tilemap_logic.get_cellv(pos_tilemap))

func tilemap_get_cells_in_array(tilemap:TileMap, ids:Array) -> Array:
	var cells = []
	for id in ids:
		cells.append_array(tilemap.get_used_cells_by_id(id))
	return cells

func open_door(door_pos:Vector2) -> void:
	var door_pos_tilemap = _tilemap_logic.world_to_map(door_pos)
	
	_audio.play_sound(door_pos, Resources.SOUNDS.open)
	_tilemap_logic.set_cellv(door_pos_tilemap, TILES.FLOOR)
	_decorator.update_decoration('TILE_DOOR_OPEN', [door_pos_tilemap])
	_pathfinding.enable_points([door_pos_tilemap])
	Events.emit_signal("level_door_opened")
	update()
	
func find_path(start:Vector2, end:Vector2) -> Array:
	return _pathfinding.get_path(
		_tilemap_logic.world_to_map(start),
		_tilemap_logic.world_to_map(end)
	)

func is_fog_cell(cell:Vector2) -> bool:
	return _tilemap_fog.get_cellv(cell) == TILES.FOG
	
func update_level_fog(pos:Vector2, distance:int) -> void:
	var pos_tilemap = _tilemap_logic.world_to_map(pos)
	var cells = _shadowcasting.cast(pos_tilemap, distance)
	Events.emit_signal("level_fog_updated", cells)

func set_pathfinding_points(to_disable:Array, to_enable:Array) -> void:
	_pathfinding.enable_points(to_enable)
	_pathfinding.disable_points(to_disable)
	update()

func node_exists(node:Node) -> bool:
	return _tilemap_logic.has_node(str(node))

func get_spawn_chance(percentage:int) -> bool:
  return percentage > 0 and randi() % 100 < percentage

func get_array_difference(array_1:Array, array_2:Array) -> Array:
	var output:Array = []
	for element in array_1:
		if not (element in array_2):
			output.append(element)
	return output

func is_tile_blocking(cell:Vector2) -> bool:
	var blocking_tiles = [
		TILES.WALL,
		TILES.DOOR
	]
	return blocking_tiles.has(_tilemap_logic.get_cellv(cell))
	
func get_entrance() -> Vector2:
	return _tilemap_logic.map_to_world(_generator.generator_get_entrance())

func get_light_level():
	return light_level
