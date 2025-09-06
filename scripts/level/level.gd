extends Node2D
class_name Level

onready var _tree:SceneTree = get_tree()
onready var _tilemap_logic:TileMap = $Logic
onready var _tilemap_debug:TileMap = $Debug
onready var _tilemap_decor:TileMap = $Decor
onready var _tilemap_debris:TileMap = $Debris
onready var _tilemap_base:TileMap = $Base
onready var _tilemap_fog:TileMap = $Fog
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

onready var TILESET = {
	DECO_1 = load("res://resources/tilesets/tileset_deco_1.tres"),
	DECO_2 = load("res://resources/tilesets/tileset_deco_2.tres"),
	DECO_3 = load("res://resources/tilesets/tileset_deco_3.tres"),
	DECO_4 = load("res://resources/tilesets/tileset_deco_4.tres"),
	DECO_5 = load("res://resources/tilesets/tileset_deco_5.tres"),
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
	Events.connect("player_moved", self, "_on_player_moved")
	Events.connect("end_turn", self, "_on_end_turn")
	
	set_tileset(TILESET.DECO_3)
	
	add_player_instance()
	generate_level()
	
	
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

func set_tileset(tileset:TileSet) -> void:
	_tilemap_decor.set_tileset(tileset)
	_tilemap_debris.set_tileset(tileset)
	_tilemap_base.set_tileset(tileset)

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
	
	populate_level()
	
	Events.emit_signal(
		"level_generation_complete", 
		_tilemap_logic.map_to_world(_generator.generator_get_entrance())
	)

func populate_level():
	clear_tilemap_children(_tilemap_logic)
	add_entities({
		'enemies': {
			"Grunt": 0,
			"Bloater": 0,
			"Colony": 0,
			"MindFlayer": 0,
			"Hydra": 100,
			"Abomination": 0,
			"Parasite": 0,
			"Insect": 0,
			"Lurker": 0,
			"Behemoth": 100,
			"Horror": 0,
			"Wart": 100,
			"Infestinator": 100,
			"Creep": 0,
			"Sludge": 0,
			"Infected": 0,
			"Stalker": 0,
			"Scout": 0,
			"Templar": 0,
			"Zealot": 0,
		},
		'items': {
			"Bandage": 5,
			"Ammo": 100,
			"Grenade": 5,
			"FragGrenade": 5,
			"Medkit": 5,
			"Teleporter": 5,
			"ShieldGenerator": 5,
			"Adrenalin": 5,
			"Steroids": 5
		},
		'weapons': {
			"AssaultRifle": 100,
			"HuntingRifle": 100,
			"Pistol": 100,
			"Revolver": 0,
			"SawnOff": 100,
			"Shotgun": 100,
			"SniperRifle": 100,
			"Submachine": 100,
			"TacticalShotgun": 100,
		}
	})

func add_player_instance() -> void:
	var player = Resources.debug_player.instance()
	player.set_position(Vector2(0, 0))
	_tilemap_logic.add_child(player)
	
func add_entities(entities:Dictionary) -> void:
	var free_cells = get_floor_cells()
	add_enemies(entities.get('enemies', {}), 5, 10, free_cells)
	add_items(entities.get('items', {}), 3, 5, free_cells)
	app_weapons(entities.get('weapons', {}), 0, 1, free_cells)

func add_enemies(enemy_list: Dictionary, min_count:int, max_count:int, free_cells:Array) -> void:
	var enemies_count = rand_range(min_count, max_count)
	var enemies_added = 0
	
	while enemies_added < enemies_count and free_cells.size() > 0:
		
		var cell = free_cells.pick_random()
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
	var floor_cells = get_floor_cells()
	var entities = get_tree().get_nodes_in_group("ENTITY")
	var entities_positions = []
	for entity in entities:
		entities_positions.append(entity.position / 8)
	return get_array_difference(floor_cells, entities_positions)
	
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

func open_door(entity_pos:Vector2, door_pos:Vector2, distance:int) -> void:
	var entity_pos_tilemap = _tilemap_logic.world_to_map(entity_pos)
	var door_pos_tilemap = _tilemap_logic.world_to_map(door_pos)
	
	_tilemap_logic.set_cellv(door_pos_tilemap, TILES.FLOOR)
	_decorator.update_decoration('TILE_DOOR_OPEN', [door_pos_tilemap])
	_pathfinding.enable_points([door_pos_tilemap])
	var cells = _shadowcasting.update(entity_pos_tilemap, distance)
	Events.emit_signal("level_fog_updated", cells)
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
	var cells = _shadowcasting.update(pos_tilemap, distance)
	Events.emit_signal("level_fog_updated", cells)

func set_pathfinding_points(to_disable:Array, to_enable:Array) -> void:
	_pathfinding.enable_points(to_enable)
	_pathfinding.disable_points(to_disable)
	update()

func _on_end_turn(node:Node) -> void:
	print("----------------------------------")
	print("Turn Ended By: ", node)
	_queue.process(_tree, node)

func node_exists(node:Node) -> bool:
	return _tilemap_logic.has_node(str(node))

func get_spawn_chance(percentage:int) -> bool:
  return percentage > 0 and randi() % 100 < percentage

func clear_tilemap_children(tilemap:TileMap) -> void:
	for child in tilemap.get_children():
		if not child.is_in_group("PLAYER"):
			child.queue_free()
			
func get_array_difference(array_1:Array, array_2:Array) -> Array:
	var output:Array = []
	for element in array_1:
		if not (element in array_2):
			output.append(element)
	return output
