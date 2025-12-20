extends Node
class_name LevelFurnisher

var _utility:Utility = Utility.new()
var furniture:Array = []
var TILES:Dictionary = {}
var tilemap:TileMap
var grid_size:int = 8

func _init(tilemap:TileMap, furniture:Array, tiles:Dictionary):
	self.tilemap = tilemap
	self.furniture = furniture
	self.TILES = tiles
	place_furniture()

func place_furniture() -> void:
	
	if furniture.size() == 0:
		return
	
	randomize()
	var room_cells:Array = get_cells()
	room_cells.shuffle()
	furniture.shuffle()
	
	var max_furniture:int = 3
	var current_furniture:int = 0
	var free_cells:Dictionary = {}
	for cell in room_cells:
		free_cells[cell] = true
		
	for placement_cell in room_cells:
		
		if current_furniture >= max_furniture:
			break
		
		var data = furniture.pick_random()
		var obj:PackedScene = data.get('object')
		var obj_cells:Array = data.get('cells')
		var placeable:bool = true
			
		for cell in obj_cells:
			var offset_cell = placement_cell + cell
			
			if not free_cells.get(offset_cell, false):
				placeable = false
		
		if placeable:
			current_furniture += 1
			
			var instance = obj.instance()
			instance.position = placement_cell * grid_size
			tilemap.add_child(instance)
			
			for cell in obj_cells:
				var occupied = placement_cell + cell
				for x in range(-1, 2):
					for y in range(-1, 2):
						free_cells[occupied + Vector2(x, y)] = false
						
			for cell in obj_cells:
				tilemap.set_cellv(placement_cell + cell, TILES.OBJECT)
			continue
		
	pass 
	
func get_cells() -> Array:
	var result = []
	var check_cells = tilemap.get_used_cells_by_id(TILES.FLOOR)
	for cell in check_cells:
		var count = _utility.count_nearby_tiles_8(tilemap, cell, [
			TILES.WALL, 
			TILES.DOOR, 
			TILES.OBJECT
		])
		if count == 0:
			result.append(cell)
	return result
