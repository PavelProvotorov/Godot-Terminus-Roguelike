extends Node
class_name Utility

func call_lifecycle_hook(hook:FuncRef):
	if hook is FuncRef and hook.is_valid():
		return hook.call_func()

func get_chance(percentage:int) -> bool:
  return percentage > 0 and randi() % 100 < percentage

func get_nearby_cells_8(origin_cell:Vector2, multiplier:int=0) -> Array:
	return [
		Vector2(origin_cell.x, origin_cell.y - 8),
		Vector2(origin_cell.x, origin_cell.y+8),
		Vector2(origin_cell.x-8, origin_cell.y),
		Vector2(origin_cell.x+8, origin_cell.y),
		Vector2(origin_cell.x+8, origin_cell.y+8),
		Vector2(origin_cell.x+8, origin_cell.y-8),
		Vector2(origin_cell.x-8, origin_cell.y+8),
		Vector2(origin_cell.x-8, origin_cell.y-8),
	]

func count_nearby_tiles_8(tilemap:TileMap, cell:Vector2, tiles:Array) -> int:
	var count:int = 0
	if tilemap.get_cell(cell.x, cell.y-1)   in tiles:  count += 1
	if tilemap.get_cell(cell.x, cell.y+1)   in tiles:  count += 1
	if tilemap.get_cell(cell.x-1, cell.y)   in tiles:  count += 1
	if tilemap.get_cell(cell.x+1, cell.y)   in tiles:  count += 1
	if tilemap.get_cell(cell.x+1, cell.y+1) in tiles:  count += 1
	if tilemap.get_cell(cell.x+1, cell.y-1) in tiles:  count += 1
	if tilemap.get_cell(cell.x-1, cell.y+1) in tiles:  count += 1
	if tilemap.get_cell(cell.x-1, cell.y-1) in tiles:  count += 1
	return count
