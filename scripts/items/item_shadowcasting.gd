extends Node
class_name ItemShadowcasting

var _shadowcasting:SymmetricShadowcasting2D
var visible_cells:Array = []
var max_distance:int = 0
var center:Vector2 = Vector2.ZERO

func _init(is_tile_blocking:FuncRef):
	self._shadowcasting = SymmetricShadowcasting2D.new(
		is_tile_blocking,
		funcref(self, 'on_tile_visible')
	)
	
func cast(center:Vector2, distance:int) -> Array:
	self.center = center
	self.max_distance = distance
		
	visible_cells.clear()
	on_tile_visible(center)

	_shadowcasting.cast(center, distance)
	return visible_cells

func on_tile_visible(tile:Vector2) -> void:
	var distance = center.distance_to(tile)

	if distance > max_distance:
		return

	visible_cells.append(tile)
